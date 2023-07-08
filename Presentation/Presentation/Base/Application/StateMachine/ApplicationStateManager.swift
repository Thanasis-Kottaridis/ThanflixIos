//
//  ApplicationStateManager.swift
//  Presentation
//
//  Created by thanos kottaridis on 7/5/23.
//

import UIKit
import Domain
import Domain
import CoreTelephony

// MARK: - Navigation Actions
public struct GoToInitializedState: Action {
    public init() {}
}

public struct GoToLogin: Action {
    public init() {}
}

public struct GoToMainApp: Action {
    public init() {}
}


public protocol ApplicationStateManager: AnyObject, BaseActionDispatcher, BaseErrorHandler {
    
    func getCurrentState() -> ApplicationState
    
    func enter(event: ApplicationStateEvents)
}

public class ApplicationStateManagerImpl: ApplicationStateManager {
    
    private var currentState: ApplicationState? {
        didSet {
            print("Apllication State Debug ℹ️ ... New State enter -> " + String(describing: currentState))
            currentState?.didEnterState()
        }
    }
    public var actionHandler: BaseActionHandler?
    
    public init(currentState: ApplicationState? = nil) {
        self.currentState = currentState
    }
    
    public func getCurrentState() -> ApplicationState {
        return currentState ?? UninitializedState(delegate: self)
    }
    
    public func enter(event: ApplicationStateEvents) {
        
        switch event {
        case .enterToUninitializedState:
            currentState =  UninitializedState(delegate: self)
        case .enterToInitializedState:
            currentState = InitializedState(previousState: currentState, delegate: self)
        case .enterToAuthState:
            currentState = AuthState(previousState: currentState, delegate: self)
            actionHandler?.handleAction(action: GoToLogin())
        case .enterToMainAppState:
            currentState = MainAppState(previousState: currentState, delegate: self)
            actionHandler?.handleAction(action: GoToMainApp())
        case .enterBootstrapCompleteState:
            currentState = BootstrapCompleteState(previousState: currentState, delegate: self)
        case .logout(let isHard):
            currentState = LogoutState(
                previousState: currentState,
                isHardLogout: isHard,
                delegate: self
            )
        }
    }
}
