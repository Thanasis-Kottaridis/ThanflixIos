//
//  MoviesDataContext.swift
//  Domain
//
//  Created by thanos kottaridis on 7/7/23.
//

import Foundation

public protocol MoviesDataContext {
    
    func getFavoriteMovies() async -> Result<PagedListResult<Movie>?, BaseException>
}


public class DefaultMoviesDataContext: MoviesDataContext {

    public init() {}
    
    public func getFavoriteMovies() async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
}
