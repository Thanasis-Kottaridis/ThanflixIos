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
            break
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
}
