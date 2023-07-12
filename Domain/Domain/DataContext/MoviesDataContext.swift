//
//  MoviesDataContext.swift
//  Domain
//
//  Created by thanos kottaridis on 7/7/23.
//

import Foundation

public protocol MoviesDataContext {
    
    /// # Account Endpoint
    func getFavoriteMovies() async -> Result<PagedListResult<Movie>?, BaseException>
    
    /// # Movies Endpoints
    func getNowPlayingMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    func getPopularMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    func getTopRatedMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    func getUpcomingMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    
    /// # Series Endpoints
    func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
    func getUpcomingSeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException>
}


public class DefaultMoviesDataContext: MoviesDataContext {
    
    public init() {}
    
    public func getFavoriteMovies() async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getNowPlayingMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getPopularMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getTopRatedMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getUpcomingMovies(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getUpcomingSeries(page: Int) async -> Result<PagedListResult<Movie>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
}
