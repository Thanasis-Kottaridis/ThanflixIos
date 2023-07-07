//
//  SharedPresentationBoundary.swift
//  SharedPresentation
//
//  Created by Aristidis Gaitanis on 2/5/23.
//


import Foundation
import Domain

public class PresentationBoundary {

    // MARK: - Manager Dependencies
    var errorDispatcher: BaseErrorDispatcher

    public init(
        errorDispatcher: BaseErrorDispatcher
    ) {
        self.errorDispatcher = errorDispatcher
    }
    
    public func initialize() {
        // set up dependencies
        InjectedValues[\.errorDispatcher] = errorDispatcher
    }
}
