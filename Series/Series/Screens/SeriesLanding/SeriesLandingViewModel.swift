//
//  SeriesLandingViewModel.swift
//  Series
//
//  Created thanos kottaridis on 22/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import UIKit
import Domain
import Presentation
import Combine

class SeriesLandingViewModel: BaseViewModel {
    // MARK: - DI
    @Injected(\.seriesDataContext)
    private var seriesDataContext: SeriesDataContext
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = SeriesLandingState
    typealias Event = SeriesLandingEvents
    
    @Published private(set) var state: State
    
    var stateValue: Published<State> {
        return _state
    }
    
    var statePublisher: Published<State>.Publisher {
        return $state
    }

    var anyCancelable = Set<AnyCancellable>()

    init(actionHandler: BaseActionHandler?) {
        self.actionHandler = actionHandler
        state = SeriesLandingState()
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
            // Event case go here
        case .fetchData:
            fetchAllData()
        case .goToShowDetails(id: let id):
            break
        }
    }
    
    private func fetchAllData() {
        // 1. create dispatch group
        let dispatchGroup = DispatchGroup()
        
        // 2. show loader
        self.state = self.state.copy(isLoading: false)

        // 3. call all endpoints
        fetchTodaySeries(dispatchGroup: dispatchGroup)
        fetchOnTheAirSeries(dispatchGroup: dispatchGroup)
        fetchPopularSeries(dispatchGroup: dispatchGroup)
        fetchTopRatedSeries(dispatchGroup: dispatchGroup)
        
        // 4. Wait all calls to completed
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.state = self.state.copy(isLoading: false)
        }
    }
    
    private func fetchTodaySeries(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()

        Task.init {
            let result = await seriesDataContext.getAiringTodaySeries(page: 1)
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(todaySeries: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func fetchOnTheAirSeries(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()

        Task.init {
            let result = await seriesDataContext.getOnTheAirSeries(page: 1)
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(onTheAirSeries: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func fetchPopularSeries(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        Task.init {
            let result = await seriesDataContext.getPopularSeries(page: 1)
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(popularSeries: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func fetchTopRatedSeries(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()

        Task.init {
            let result = await seriesDataContext.getTopRatedSeries(page: 1)
            ensureMainThread { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .Success(let response):
                    self.state = self.state.copy(topRatedSeries: response?.results)
                case .Failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }

}
