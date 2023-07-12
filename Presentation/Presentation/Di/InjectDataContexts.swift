//
//  InjectDataContexts.swift
//  Presentation
//
//  Created by thanos kottaridis on 14/3/23.
//

import Foundation
import Domain

private struct MoviesDataContextProvider: InjectionKey {
    static var currentValue: MoviesDataContext = DefaultMoviesDataContext()
}

extension InjectedValues {
    
    public var moviesDataContext: MoviesDataContext {
        get { Self[MoviesDataContextProvider.self] }
        set { Self[MoviesDataContextProvider.self] = newValue }
    }
}
