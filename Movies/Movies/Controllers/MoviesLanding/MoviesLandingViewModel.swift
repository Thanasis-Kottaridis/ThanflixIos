//
//  MoviesLandingViewModel.swift
//  Movies
//
//  Created thanos kottaridis on 12/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import UIKit
import Domain
import Presentation
import Combine

class MoviesLandingViewModel: BaseViewModel {
    
    // MARK: - DI
    @Injected(\.moviesDataContext)
    private var moviesDataContext: MoviesDataContext
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = MoviesLandingState
    typealias Event = MoviesLandingEvents
    
    @Published private(set) var state: State
    
    var stateValue: Published<State> {
        return _state
    }
    
    var statePublisher: Published<State>.Publisher {
        return $state
    }
    
    var anyCancelable = Set<AnyCancellable>()

    init(actionHandler: BaseActionHandler) {
        self.actionHandler = actionHandler
        state = MoviesLandingState(isLoading: true)
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
        case .fetchData:
            fetchAllData()
        }
    }
    
    private func fetchAllData() {
        // 1. create dispatch group
        let dispatchGroup = DispatchGroup()
        
        // 2. show loader
        self.state = self.state.copy(isLoading: true)

        // 3. call all endpoints
        fetchNowPlayingMovies(dispatchGroup: dispatchGroup)
        fetchPopularMovies(dispatchGroup: dispatchGroup)
        fetchTopRatedMovies(dispatchGroup: dispatchGroup)
        fetchUpcomingMovies(dispatchGroup: dispatchGroup)
        
        // 4. Wait all calls to completed
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.state = self.state.copy(isLoading: false)
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
    private func fetchNowPlayingMovies(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        Task.init {
            let result = await moviesDataContext.getFavoriteMovies()
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(nowPlayingMovies: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func fetchPopularMovies(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        Task.init {
            let result = await moviesDataContext.getFavoriteMovies()
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(popularMovies: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func fetchTopRatedMovies(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()

        Task.init {
            let result = await moviesDataContext.getFavoriteMovies()
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(topRatedMovies: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func fetchUpcomingMovies(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        Task.init {
            let result = await moviesDataContext.getFavoriteMovies()
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(upcomingMovies: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
}
