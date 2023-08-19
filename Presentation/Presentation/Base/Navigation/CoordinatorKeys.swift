//
//  CoordinatorKeys.swift
//  Presentation
//
//  Created by thanos kottaridis on 29/1/23.
//

import Foundation

public protocol CoordinatorKey {
    var value: String { get }
}

public enum CoordinatorKeyImpl: String, CoordinatorKey {
    case masterCoordinator
    case mainAppCoordinator
    case moviesCoordinator
    case seriesCoordinator
    
    public var value: String {
        return self.rawValue
    }
}
