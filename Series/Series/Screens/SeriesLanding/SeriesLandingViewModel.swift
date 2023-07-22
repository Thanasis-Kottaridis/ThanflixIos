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

    init(actionHandler: BaseActionHandler) {
        self.actionHandler = actionHandler
        state = SeriesLandingState()
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
            // Event case go here
        case .fetchData:
            break
        case .goToShowDetails(id: let id):
            break
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
}
