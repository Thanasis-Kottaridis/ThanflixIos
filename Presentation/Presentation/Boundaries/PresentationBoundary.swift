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
    var moviesDataContext: MoviesDataContext

    public init(
        errorDispatcher: BaseErrorDispatcher,
        moviesDataContext: MoviesDataContext
    ) {
        self.errorDispatcher = errorDispatcher
        self.moviesDataContext = moviesDataContext
    }
    
    public func initialize() {
        // set up dependencies
        InjectedValues[\.errorDispatcher] = errorDispatcher
        InjectedValues[\.moviesDataContext] = moviesDataContext
    }
}
