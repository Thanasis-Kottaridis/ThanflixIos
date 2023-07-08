//
//  InjectManagers.swift
//  Presentation
//
//  Created by thanos kottaridis on 9/5/23.
//

import Foundation
import Domain

private struct ApplicationStateManagerProvider: InjectionKey {
    static var currentValue: ApplicationStateManager = ApplicationStateManagerImpl()
}

extension InjectedValues {
    
    public var applicationStateManager: ApplicationStateManager {
        get { Self[ApplicationStateManagerProvider.self] }
        set { Self[ApplicationStateManagerProvider.self] = newValue }
    }
}
