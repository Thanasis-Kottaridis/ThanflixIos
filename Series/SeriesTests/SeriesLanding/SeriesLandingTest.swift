//
//  SeriesLandingTest.swift
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
    var seriesDetailsExp: XCTestExpectation?

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
        
        if action is GoToSeriesDetails {
            seriesDetailsExp?.fulfill()
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
        
        if action is GoToSeriesDetails {
            seriesDetailsExp?.fulfill()
        }
    }
}

// MARK: - Mock Movies DataContext
fileprivate let mock_todaySeries: [Show] = [
    Show(
        id: 1,
        posterPath: "poster/path/1",
        releaseDate: "01-01-2023",
        title: "Mock Today 1",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 2,
        posterPath: "poster/path/2",
        releaseDate: "01-01-2023",
        title: "Mock Today 2",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 3,
        posterPath: "poster/path/3",
        releaseDate: "01-01-2023",
        title: "Mock Today 3",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 4,
        posterPath: "poster/path/4",
        releaseDate: "01-01-2023",
        title: "Mock Today 4",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 5,
        posterPath: "poster/path/5",
        releaseDate: "01-01-2023",
        title: "Mock Today 5",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

// MARK: - Mock Data
fileprivate let mock_onTheAirSeries: [Show] = [
    Show(
        id: 6,
        posterPath: "poster/path/6",
        releaseDate: "01-01-2023",
        title: "Mock onTheAir 6",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 7,
        posterPath: "poster/path/7",
        releaseDate: "01-01-2023",
        title: "Mock onTheAir 7",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 8,
        posterPath: "poster/path/8",
        releaseDate: "01-01-2023",
        title: "Mock onTheAir 8",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 9,
        posterPath: "poster/path/9",
        releaseDate: "01-01-2023",
        title: "Mock onTheAir 9",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 10,
        posterPath: "poster/path/10",
        releaseDate: "01-01-2023",
        title: "Mock onTheAir 10",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

fileprivate let mock_popularSeries: [Show] = [
    Show(
        id: 11,
        posterPath: "poster/path/11",
        releaseDate: "01-01-2023",
        title: "Mock Top Rated 11",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 12,
        posterPath: "poster/path/12",
        releaseDate: "01-01-2023",
        title: "Mock popular 12",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 13,
        posterPath: "poster/path/13",
        releaseDate: "01-01-2023",
        title: "Mock popular 13",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 14,
        posterPath: "poster/path/14",
        releaseDate: "01-01-2023",
        title: "Mock popular 14",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 15,
        posterPath: "poster/path/15",
        releaseDate: "01-01-2023",
        title: "Mock popular 15",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

fileprivate let mock_topRatedSeries: [Show] = [
    Show(
        id: 16,
        posterPath: "poster/path/16",
        releaseDate: "01-01-2023",
        title: "Mock topRated 16",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 17,
        posterPath: "poster/path/17",
        releaseDate: "01-01-2023",
        title: "Mock topRated 17",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 18,
        posterPath: "poster/path/18",
        releaseDate: "01-01-2023",
        title: "Mock topRated 18",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 19,
        posterPath: "poster/path/19",
        releaseDate: "01-01-2023",
        title: "Mock topRated 19",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 20,
        posterPath: "poster/path/20",
        releaseDate: "01-01-2023",
        title: "Mock topRated 20",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

// MARK: - Mock Datacontext
fileprivate class MockSeriesDataContext: SeriesDataContext {
    
    var expectation: XCTestExpectation?
    var isError: Bool
    var todaySeries: [Show]
    var onTheAirSeries: [Show]
    var popularSeries: [Show]
    var topRatedSeries: [Show]

    init(
        expectation: XCTestExpectation? = nil,
        isError: Bool = false,
        todaySeries: [Show],
        onTheAirSeries: [Show],
        popularSeries: [Show],
        topRatedSeries: [Show]
    ) {
        self.expectation = expectation
        self.isError = isError
        self.todaySeries = todaySeries
        self.onTheAirSeries = onTheAirSeries
        self.popularSeries = popularSeries
        self.topRatedSeries = topRatedSeries
    }
    
    func getAiringTodaySeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: todaySeries, page: page))
        }
    }
    
    func getOnTheAirSeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: onTheAirSeries, page: page))
        }
    }
    
    func getPopularSeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: popularSeries, page: page))
        }
    }
    
    func getTopRatedSeries(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: topRatedSeries, page: page))
        }
    }
    
    func getSeriesDetails(seriesId: Int) async -> Domain.Result<Domain.ShowDetails?, Domain.BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    private func getPagedList(shows: [Show], page: Int) -> PagedListResult<Show> {
        return PagedListResult(
            results: shows,
            next: page + 1,
            previous: min(1, page - 1),
            current: page,
            total: 10
        )
    }
}


final class MoviesLandingTest: XCTestCase {
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
     - view Model update state with new movies.
     - observes state using Combine
     */
    func testFetchData() throws {
        
        // this helper var keeps recored of
        // all state updates during test
        var stateObserver: [SeriesLandingState] = []
        
        //create the expectation for hide loader on VM init
        var exp = expectation(
            description: "Hide loader for initial set up"
        )
        
        // set mock repository Dependency.
        InjectedValues[\.seriesDataContext] = MockSeriesDataContext(
            todaySeries: mock_todaySeries,
            onTheAirSeries: mock_onTheAirSeries,
            popularSeries: mock_popularSeries,
            topRatedSeries: mock_topRatedSeries
        )
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        mockActionHandler.loaderExp = exp

        // initialze viewModel
        let viewModel = SeriesLandingViewModel(actionHandler: mockActionHandler)
        
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
            description: "hide loader after requests loader expectation"
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
            stateObserver.count == 6 &&
            stateObserver.first?.isLoading == true &&
            stateObserver.last?.isLoading == false
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
        var stateObserver: [SeriesLandingState] = []
        
        //create the expectation for hide loader on VM init
        var exp = expectation(
            description: "Hide loader for initial set up"
        )
        
        // set mock repository Dependency.
        InjectedValues[\.seriesDataContext] = MockSeriesDataContext(
            isError: true,
            todaySeries: mock_todaySeries,
            onTheAirSeries: mock_onTheAirSeries,
            popularSeries: mock_popularSeries,
            topRatedSeries: mock_topRatedSeries
        )
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        mockActionHandler.loaderExp = exp

        // initialze viewModel
        let viewModel = SeriesLandingViewModel(actionHandler: mockActionHandler)
        
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
            description: "hide loader after requests loader expectation"
        )
        mockActionHandler.loaderExp = exp
        
        // await for expectation
        waitForExpectations(timeout: 10)
        
        // evaluate actionsCalled
        let actions = mockActionHandler.actionsCalled
        
        // we expect 4 feedback messages one of each request that fails.
        // (because we perform 4 request to fetch data from BE)
        XCTAssertTrue(
            actions[0] is ShowLoaderAction &&
            actions[1] is PresentFeedbackAction &&
            actions[2] is PresentFeedbackAction &&
            actions[3] is PresentFeedbackAction &&
            actions[4] is PresentFeedbackAction &&
            actions[5] is HideLoaderAction &&
            actions.count == 6
        )
        
        XCTAssertTrue(
            stateObserver.count == 2 &&
            stateObserver.first?.isLoading == true &&
            stateObserver.last?.isLoading == false
        )
    }
    
    /**
     ### Test case Navigate to movie Details
     **Use Case**
     - Creates a New mockRepository
     - triggers viewModel `.fetchData` to fetch mock data
     - await expectation complete
     - reset navigation actions stack
     - triggers viewModel `.goToMovieDetails(index: Int)`
     - by passing index path (row : 3 , section: 0) -> movie with id = 4
     - BaseAction Handler performs `GoToMovieDetails` with `ID = 3`.
     */
    func testNavigateToMovie() throws {
        
        // set mock repository Dependency.
        InjectedValues[\.seriesDataContext] = MockSeriesDataContext(
            todaySeries: mock_todaySeries,
            onTheAirSeries: mock_onTheAirSeries,
            popularSeries: mock_popularSeries,
            topRatedSeries: mock_topRatedSeries
        )
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        
        // initialze viewModel
        let viewModel = SeriesLandingViewModel(actionHandler: mockActionHandler)
        
        // Fetch data and wait expecttion
        viewModel.onTriggeredEvent(event: .fetchData)
        // create new expectaion waiting requests to complete.
        var exp = expectation(
            description: "hide loader after requests loader expectation"
        )
        mockActionHandler.loaderExp = exp
        // await for expectation
        waitForExpectations(timeout: 10)
        
        // reset navigation actions
        mockActionHandler.actionsCalled = []
        
        // perform navigation
        viewModel.onTriggeredEvent(event: .goToShowDetails(id: 4))
        
        // (because we perform 4 request to fetch data from BE)
        let actions = mockActionHandler.actionsCalled
        XCTAssertTrue(
            (actions[0] as! GoToSeriesDetails).id == 4 &&
            actions.count == 1
        )
    }
}
