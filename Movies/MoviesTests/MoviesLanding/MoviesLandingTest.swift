//
//  MoviesLandingTest.swift
//  MoviesTests
//
//  Created by thanos kottaridis on 23/7/23.
//

import XCTest
import Domain
import Presentation
@testable import Movies
import Combine

// MARK: - Mock Action Handler
fileprivate class MockActionHandler: BaseActionHandler {
    var loaderExp: XCTestExpectation?
    var feedbackExp: XCTestExpectation?
    var movieDetailsExp: XCTestExpectation?

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
        
        if action is GoToMovieDetails {
            movieDetailsExp?.fulfill()
        }
    }
}

// MARK: - Mock Movies DataContext
fileprivate let mock_nowPlayingMovies: [Show] = [
    Show(
        id: 1,
        posterPath: "poster/path/1",
        releaseDate: "01-01-2023",
        title: "Mock Now Playing 2",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 2,
        posterPath: "poster/path/2",
        releaseDate: "01-01-2023",
        title: "Mock Now Playing 2",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 3,
        posterPath: "poster/path/3",
        releaseDate: "01-01-2023",
        title: "Mock Now Playing 3",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 4,
        posterPath: "poster/path/4",
        releaseDate: "01-01-2023",
        title: "Mock Now Playing 4",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 5,
        posterPath: "poster/path/5",
        releaseDate: "01-01-2023",
        title: "Mock Now Playing 5",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

// MARK: - Mock Data
fileprivate let mock_popularMovies: [Show] = [
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
    ),
    Show(
        id: 8,
        posterPath: "poster/path/8",
        releaseDate: "01-01-2023",
        title: "Mock Popular 8",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 9,
        posterPath: "poster/path/9",
        releaseDate: "01-01-2023",
        title: "Mock Popular 9",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 10,
        posterPath: "poster/path/10",
        releaseDate: "01-01-2023",
        title: "Mock Popular 10",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

fileprivate let mock_topRatedMovies: [Show] = [
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
        title: "Mock Top Rated 12",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 13,
        posterPath: "poster/path/13",
        releaseDate: "01-01-2023",
        title: "Mock Top Rated 13",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 14,
        posterPath: "poster/path/14",
        releaseDate: "01-01-2023",
        title: "Mock Top Rated 14",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 15,
        posterPath: "poster/path/15",
        releaseDate: "01-01-2023",
        title: "Mock Top Rated 15",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

fileprivate let mock_upcomingMovies: [Show] = [
    Show(
        id: 16,
        posterPath: "poster/path/16",
        releaseDate: "01-01-2023",
        title: "Mock Upcoming 16",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 17,
        posterPath: "poster/path/17",
        releaseDate: "01-01-2023",
        title: "Mock Upcoming 17",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 18,
        posterPath: "poster/path/18",
        releaseDate: "01-01-2023",
        title: "Mock Upcoming 18",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 19,
        posterPath: "poster/path/19",
        releaseDate: "01-01-2023",
        title: "Mock Upcoming 19",
        voteAverage: 5.5,
        voteCount: 1000
    ),
    Show(
        id: 20,
        posterPath: "poster/path/20",
        releaseDate: "01-01-2023",
        title: "Mock Upcoming 20",
        voteAverage: 5.5,
        voteCount: 1000
    )
]

// MARK: - Mock Datacontext
fileprivate class MockMoviesDataContext: MoviesDataContext {
    
    var expectation: XCTestExpectation?
    var isError: Bool
    var nowPlayingMovies: [Show]
    var popularMovies: [Show]
    var topRatedMovies: [Show]
    var upcomingMovies: [Show]
    var requestCounter: Int = 0

    init(
        expectation: XCTestExpectation? = nil,
        isError: Bool = false,
        nowPlayingMovies: [Show],
        popularMovies: [Show],
        topRatedMovies: [Show],
        upcomingMovies: [Show]
    ) {
        self.expectation = expectation
        self.isError = isError
        self.nowPlayingMovies = nowPlayingMovies
        self.popularMovies = popularMovies
        self.topRatedMovies = topRatedMovies
        self.upcomingMovies = upcomingMovies
    }
    
    func getFavoriteMovies() async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    func getNowPlayingMovies(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: nowPlayingMovies, page: page))
        }
    }
    
    func getPopularMovies(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: popularMovies, page: page))
        }
        
        
    }
    
    func getTopRatedMovies(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: topRatedMovies, page: page))
        }
        
    }
    
    func getUpcomingMovies(page: Int) async -> Domain.Result<Domain.PagedListResult<Domain.Show>?, Domain.BaseException> {
        if isError {
            return Result.Failure(BaseException())
        } else {
            return Result.Success(getPagedList(shows: upcomingMovies, page: page))
        }
    }
    
    func getMovieDetails(movieId: Int) async -> Domain.Result<Domain.ShowDetails?, Domain.BaseException> {
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
        var stateObserver: [MoviesLandingState] = []
        
        // set mock repository Dependency.
        InjectedValues[\.moviesDataContext] = MockMoviesDataContext(
            nowPlayingMovies: mock_nowPlayingMovies,
            popularMovies: mock_popularMovies,
            topRatedMovies: mock_topRatedMovies,
            upcomingMovies: mock_upcomingMovies
        )
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        
        // initialze viewModel
        let viewModel = MoviesLandingViewModel(actionHandler: mockActionHandler)
        viewModel.onTriggeredEvent(event: .fetchData)
        
        // obsearve until recieve movies
        viewModel.statePublisher
            .sink { state in
                stateObserver.append(state)
            }
            .store(in: &cancellables)
        
        // create new expectaion waiting requests to complete.
        let exp = expectation(
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
        var stateObserver: [MoviesLandingState] = []
        
        // set mock repository Dependency.
        InjectedValues[\.moviesDataContext] = MockMoviesDataContext(
            isError: true,
            nowPlayingMovies: mock_nowPlayingMovies,
            popularMovies: mock_popularMovies,
            topRatedMovies: mock_topRatedMovies,
            upcomingMovies: mock_upcomingMovies
        )
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        
        // initialze viewModel
        let viewModel = MoviesLandingViewModel(actionHandler: mockActionHandler)
        viewModel.onTriggeredEvent(event: .fetchData)
        
        // obsearve until recieve movies
        viewModel.statePublisher
            .sink { state in
                stateObserver.append(state)
            }
            .store(in: &cancellables)
        
        // create new expectaion waiting requests to complete.
        let exp = expectation(
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
        InjectedValues[\.moviesDataContext] = MockMoviesDataContext(
            nowPlayingMovies: mock_nowPlayingMovies,
            popularMovies: mock_popularMovies,
            topRatedMovies: mock_topRatedMovies,
            upcomingMovies: mock_upcomingMovies
        )
       
        // set up mock ActionHandler
        let mockActionHandler = MockActionHandler()
        
        // initialze viewModel
        let viewModel = MoviesLandingViewModel(actionHandler: mockActionHandler)
        
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
        viewModel.onTriggeredEvent(event: .goToMovieDetails(index: IndexPath(row: 3, section: 0)))
        
//        // create new expectaion waiting requests to complete.
//        exp = expectation(
//            description: "hide loader after requests loader expectation"
//        )
//        mockActionHandler.feedbackExp = exp
//        // await for expectation
//        waitForExpectations(timeout: 10)
        
        // (because we perform 4 request to fetch data from BE)
        let actions = mockActionHandler.actionsCalled
        XCTAssertTrue(
            (actions[0] as! GoToMovieDetails).id == 4 &&
            actions.count == 1
        )
    }
}
