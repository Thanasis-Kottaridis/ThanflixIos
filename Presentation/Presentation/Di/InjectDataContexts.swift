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

private struct SeriesDataContextProvider: InjectionKey {
    static var currentValue: SeriesDataContext = DefaultSeriesDataContext()
}

extension InjectedValues {
    
    public var moviesDataContext: MoviesDataContext {
        get { Self[MoviesDataContextProvider.self] }
        set { Self[MoviesDataContextProvider.self] = newValue }
    }
    
    public var seriesDataContext: SeriesDataContext {
        get { Self[SeriesDataContextProvider.self] }
        set { Self[SeriesDataContextProvider.self] = newValue }
    }
}
