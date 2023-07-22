//
//  SeriesDetailsViewModel.swift
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

class SeriesDetailsViewModel: BaseViewModel {
    
    // MARK: - DI
    @Injected(\.seriesDataContext)
    private var seriesDataContext: SeriesDataContext
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = SeriesDetailsState
    typealias Event = SeriesDetailsEvents
    
    @Published private(set) var state: State
    
    var stateValue: Published<State> {
        return _state
    }
    
    var statePublisher: Published<State>.Publisher {
        return $state
    }

    var anyCancelable = Set<AnyCancellable>()

    init(seriesId: Int, actionHandler: BaseActionHandler?) {
        self.actionHandler = actionHandler
        state = SeriesDetailsState(seriesId: seriesId)
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
        case .goBack:
            actionHandler?.handleAction(action: PopAction())
        case .fetchData:
            fetchSeriesDetails()
        }
    }
    
    private func fetchSeriesDetails() {
        
        self.state = self.state.copy(isLoading: true)
        
        Task.init {
            let result = await seriesDataContext.getSeriesDetails(seriesId: state.seriesId)
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
    }}
