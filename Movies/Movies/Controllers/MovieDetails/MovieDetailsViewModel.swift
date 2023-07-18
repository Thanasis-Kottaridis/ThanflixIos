//
//  MovieDetailsViewModelViewModel.swift
//  Movies
//
//  Created thanos kottaridis on 18/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import UIKit
import Domain
import Presentation
import Combine

class MovieDetailsViewModel: BaseViewModel {
    
    // MARK: - DI
    @Injected(\.moviesDataContext)
    private var moviesDataContext: MoviesDataContext
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = MovieDetailsViewModelState
    typealias Event = MovieDetailsViewModelEvents
    
    @Published private(set) var state: State
    
    var stateValue: Published<State> {
        return _state
    }
    
    var statePublisher: Published<State>.Publisher {
        return $state
    }
    
    var anyCancelable = Set<AnyCancellable>()
    
    init(movieId: Int, actionHandler: BaseActionHandler) {
        self.actionHandler = actionHandler
        state = MovieDetailsViewModelState(movieId: movieId)
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
        case .fetchData:
            fetchMovieDetails()
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
    private func fetchMovieDetails() {
        
        self.state = self.state.copy(isLoading: true)
        
        Task.init {
            let result = await moviesDataContext.getMovieDetails(movieId: state.movieId)
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                self.state = self.state.copy(isLoading: false)
                
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(details: response)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
}
