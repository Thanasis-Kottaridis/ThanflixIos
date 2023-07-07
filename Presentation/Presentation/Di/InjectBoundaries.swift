//
//  InjectBoundaries.swift
//  Presentation
//
//  Created by thanos kottaridis on 10/11/22.
//

import Foundation
import Domain

private struct BaseErrorDispatcherProvider: InjectionKey {
    static var currentValue: BaseErrorDispatcher = DefaultBaseErrorDispatcher()
}


extension InjectedValues {
    
    public var errorDispatcher: BaseErrorDispatcher {
        get { Self[BaseErrorDispatcherProvider.self] }
        set { Self[BaseErrorDispatcherProvider.self] = newValue }
    }
}
