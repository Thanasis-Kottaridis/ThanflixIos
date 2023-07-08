//
//  ApplicationStateEvents.swift
//  Presentation
//
//  Created by thanos kottaridis on 9/5/23.
//

import Foundation
import Domain

public enum ApplicationStateEvents {
    case enterToUninitializedState
    case enterToInitializedState
    case enterToAuthState
    case enterToMainAppState
    case enterBootstrapCompleteState
    case logout(isHard: Bool)
}
