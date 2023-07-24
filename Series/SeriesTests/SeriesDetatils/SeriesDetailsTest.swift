//
//  SeriesDetailsTest.swift
//  SeriesTests
//
//  Created by thanos kottaridis on 24/7/23.
//

import XCTest
import Domain
import Presentation
@testable import Series
import Combine

// MARK: - Mock Action Handler
fileprivate class MockActionHandler: BaseActionHandler {
    var loaderExp: XCTestExpectation?
    var feedbackExp: XCTestExpectation?
    
    /// We use this array of acctions in order to keep
    /// reference to all actions performed during test case
    /// and to validate if thay called in proper order.
    var actionsCalled: [Action] = []
    
    func handleBaseAction(action: Action) {
        actionsCalled.append(action)
        
        if action is PresentFeedbackAction {
            feedbackExp?.fulfill()
        }
        
        if action is HideLoaderAction {
            loaderExp?.fulfill()
        }
    }
    
    func handleAction(action: Action) {
        actionsCalled.append(action)
        
        if action is PresentFeedbackAction {
            feedbackExp?.fulfill()
        }
        
        if action is HideLoaderAction {
            loaderExp?.fulfill()
        }
    }
}

fileprivate let mock_showDetails: ShowDetails = ShowDetails(
    id: 1,
    posterPath: "poster/path/1",
    backdropPath: "backdrop/path/1",
    releaseDate: "01-01-2023",
    title: "Mock Details 1",
    voteAverage: 5.5,
    voteCount: 1000,
    popularity: 1000,
    overview: [
        Overview(
            key: "overview_1",
            value: "overview 1 value"
        ),
        Overview(
            key: "overview_2",
            value: "overview 2 value"
        ),
        Overview(
            key: "overview_3",
            value: "overview 3 value"
        )
    ],
    productionCompanies: [ProductionCompany(
        id: 1,
        logoPath: "company/logo/path/1",
        name: "Company 1"
    )],
    seasons: [
        Show(
            id: 6,
            posterPath: "poster/path/6",
            releaseDate: "01-01-2023",
            title: "Mock Popular 6",
            voteAverage: 5.5,
            voteCount: 1000
        ),
        Show(
            id: 7,
            posterPath: "poster/path/7",
            releaseDate: "01-01-2023",
            title: "Mock Popular 7",
            voteAverage: 5.5,
            voteCount: 1000
        )
    ]
)

fileprivate class MockSeriesDataContext: SeriesDataContext {
    
    var expectation: XCTestExpectation?
    var isError: Bool
    
    init(
        expectation: XCTestExpectation? = nil,
        isError: Bool = false
    ) {
        self.expectation = expectation
        self.isError = isError
    }
    
    func getAiringTodaySeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    func getOnTheAirSeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    func getPopularSeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    func getTopRatedSeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    func getSeriesDetails(seriesId: Int) async -> Domain.Result<Domain.ShowDetails?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(mock_showDetails)
        }
    }
}

final class SeriesDetailsTest: XCTestCase {

    /**
     Helper var for Combine cancelables.
     we clear cancelable before each test starting
     
     */
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        // 1. reset cancelables
        cancellables = []
        
        // 2. set up base error dispatcher
        InjectedValues[\.errorDispatcher] = BaseErrorDispatcherImpl()
    }
    
    /**
     ### Test case fetchData event
     **Use Case**
     - Creates a New mockRepository
     - triggers viewModel `.fetchData`
     - View Model enters loading state.
     - BaseAction Handler Shows Loader.
     - Repository get data via Network request
     - View Model **Hides** loading state.
     - BaseAction Handler **Hides** Loader.
     - view Model update state with new movie details.
     - observes state using Combine
     */
    func testFetchData() throws {
        
        // this helper var keeps recored of
        // all state updates during test
        var stateObserver: [SeriesDetailsState] = []
        
        //create the expectation for hide loader on VM init
        var exp = expectation(
            description: "Hide loader for initial set up"
        )
        
        // set mock repository Dependency.
        InjectedValues[\.seriesDataContext] = MockSeriesDataContext()
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        mockActionHandler.loaderExp = exp

        // initialze viewModel
        let viewModel = SeriesDetailsViewModel(seriesId: 1, actionHandler: mockActionHandler)
        
        // await for expectation
        waitForExpectations(timeout: 10)
        // clear actions
        mockActionHandler.actionsCalled = []
        
       // fetch data
        viewModel.onTriggeredEvent(event: .fetchData)
        
        // obsearve until recieve movies
        viewModel.statePublisher
            .sink { state in
                stateObserver.append(state)
            }
            .store(in: &cancellables)
        
        // create new expectaion waiting requests to complete.
        exp = expectation(
            description: "hide loader after request expectation"
        )
        mockActionHandler.loaderExp = exp
        
        // await for expectation
        waitForExpectations(timeout: 10)
        
        // evaluate actionsCalled
        let actions = mockActionHandler.actionsCalled
        
        XCTAssertTrue(
            actions[0] is Presentation.ShowLoaderAction &&
            actions[1] is Presentation.HideLoaderAction &&
            actions.count == 2
        )
        
        XCTAssertTrue(
            stateObserver.count == 3 &&
            stateObserver.first?.isLoading == true &&
            stateObserver.last?.isLoading == false &&
            stateObserver.last?.details.id == 1
        )
    }
    
    /**
     ### Test case fetchData event with error
     **Use Case**
     - Creates a New mockRepository
     - triggers viewModel `.fetchData`
     - View Model enters loading state.
     - BaseAction Handler Shows Loader.
     - Datacontexy Fails to get data and returns `BaseException`
     - View Model **Hide** loading state.
     - BaseAction Handler **Hides** Loader.
     - view Model handles exception.
     - BaseAction Handler presents feedback.
     - observes state using combine
     */
    func testFetchDataWithError() throws {
        // this helper var keeps recored of
        // all state updates during test
        var stateObserver: [SeriesDetailsState] = []
        
        //create the expectation for hide loader on VM init
        var exp = expectation(
            description: "Hide loader for initial set up"
        )
        
        // set mock repository Dependency.
        InjectedValues[\.seriesDataContext] = MockSeriesDataContext(isError: true)
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        mockActionHandler.loaderExp = exp

        // initialze viewModel
        let viewModel = SeriesDetailsViewModel(seriesId: 1, actionHandler: mockActionHandler)
        
        // await for expectation
        waitForExpectations(timeout: 10)
        // clear actions
        mockActionHandler.actionsCalled = []
        
        viewModel.onTriggeredEvent(event: .fetchData)
        
        // obsearve until recieve movies
        viewModel.statePublisher
            .sink { state in
                stateObserver.append(state)
            }
            .store(in: &cancellables)
        
        // create new expectaion waiting requests to complete.
        exp = expectation(
            description: "hide loader after request expectation"
        )
        mockActionHandler.loaderExp = exp
        
        // await for expectation
        waitForExpectations(timeout: 10)
        
        // evaluate actionsCalled
        let actions = mockActionHandler.actionsCalled
        
        // we expect 1 feedback messages one of each request that fails.
        // (because we perform 4 request to fetch data from BE)
        XCTAssertTrue(
            actions[0] is ShowLoaderAction &&
            actions[1] is PresentFeedbackAction &&
            actions[2] is HideLoaderAction &&
            actions.count == 3
        )
        
        XCTAssertTrue(
            stateObserver.count == 2 &&
            stateObserver.first?.isLoading == true &&
            stateObserver.last?.isLoading == false
        )
    }

}
