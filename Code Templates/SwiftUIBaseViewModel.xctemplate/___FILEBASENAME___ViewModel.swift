//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ . All rights reserved.
//
//

import UIKit
import Domain
import SharedPresentation
import Presentation
import RxDataSources

class ___VARIABLE_moduleName___ViewModel: SwiftUIBaseViewModel {
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = ___VARIABLE_moduleName___State
    typealias Event = ___VARIABLE_moduleName___Events
    
    @Published private(set) var state: State
    
    var stateValue: Published<State> {
        return _state
    }
    
    var statePublisher: Published<State>.Publisher {
        return $state
    }
    
    init(actionHandler: BaseActionHandler) {
        self.actionHandler = actionHandler
        state = ___VARIABLE_moduleName___State()
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
            // Event case go here
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
}
