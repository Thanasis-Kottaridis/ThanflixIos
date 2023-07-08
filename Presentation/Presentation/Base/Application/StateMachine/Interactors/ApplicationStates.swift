//
//  ApplicationStates.swift
//  Presentation
//
//  Created by thanos kottaridis on 31/5/23.
//

import UIKit
import Domain
import CoreTelephony

// MARK: - Application States
public protocol ApplicationState {
    var previousState: ApplicationState? { get }
    var delegate: ApplicationStateManager? { get }
    
    func didEnterState()
}

// MARK: - Default Impl
extension ApplicationState {
    public func didEnterState() {}
}

public struct UninitializedState: ApplicationState {
    
    public let previousState: ApplicationState?
    public weak var delegate: ApplicationStateManager?
    
    public init(previousState: ApplicationState? = nil, delegate: ApplicationStateManager?) {
        self.previousState = previousState
        self.delegate = delegate
    }
    
    public func didEnterState() {
        
        // TODO: - Make initialization calls here
        // 1. Show snapshot window while waiting.
        // 2. get instalation ID from BE
        // 3. register push token.
        
        // 4. Enter initialized state
        delegate?.enter(event: .enterToInitializedState)
    }
}

public struct InitializedState: ApplicationState {
    
    public let previousState: ApplicationState?
    public weak var delegate: ApplicationStateManager?
    
    public init(previousState: ApplicationState? = nil, delegate: ApplicationStateManager?) {
        self.previousState = previousState
        self.delegate = delegate
    }
    
    public func didEnterState() {
        checkUserComeBack()
    }
    
    private func checkUserComeBack() {
        // FIXME: Start from login
        // else enter to AuthState
        delegate?.enter(event: .enterToMainAppState)
    }
}

public struct AuthState: ApplicationState {
    public let previousState: ApplicationState?
    public weak var delegate: ApplicationStateManager?
    
    public init(previousState: ApplicationState? = nil, delegate: ApplicationStateManager?) {
        self.previousState = previousState
        self.delegate = delegate
    }
}

public struct MainAppState: ApplicationState {
    public let previousState: ApplicationState?
    public weak var delegate: ApplicationStateManager?
    
    public init(previousState: ApplicationState? = nil, delegate: ApplicationStateManager?) {
        self.previousState = previousState
        self.delegate = delegate
    }
    
    public func didEnterState() {
        // TODO: - Handle pending notifications here.
        delegate?.enter(event: .enterBootstrapCompleteState)
    }
}

public struct BootstrapCompleteState: ApplicationState {
    public let previousState: ApplicationState?
    public weak var delegate: ApplicationStateManager?
    
    public init(previousState: ApplicationState? = nil, delegate: ApplicationStateManager?) {
        self.previousState = previousState
        self.delegate = delegate
    }
}

public struct LogoutState: ApplicationState {
    public let previousState: ApplicationState?
    public weak var delegate: ApplicationStateManager?
    private let isHardLogout: Bool
    
    public init(
        previousState: ApplicationState? = nil,
        isHardLogout: Bool,
        delegate: ApplicationStateManager?
    ) {
        self.previousState = previousState
        self.delegate = delegate
        self.isHardLogout = isHardLogout
    }
    
    public func didEnterState() {
        performLogout(isHardLogout)
    }
    
    private func performLogout(_ isHardLogout: Bool) {
        // TODO: - Clear sessions and perform logout
        print("LOG OUT!!!!!")
    }
}
