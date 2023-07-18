//
//  MoviesDataContext.swift
//  Domain
//
//  Created by thanos kottaridis on 7/7/23.
//

import Foundation

public protocol MoviesDataContext {
    
    /// # Account Endpoint
    func getFavoriteMovies() async -> Result<PagedListResult<Show>?, BaseException>
    
    /// # Movies Endpoints
    func getNowPlayingMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getPopularMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getTopRatedMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getUpcomingMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    
    /// # Series Endpoints
    func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getUpcomingSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
}


public class DefaultMoviesDataContext: MoviesDataContext {
    
    public init() {}
    
    public func getFavoriteMovies() async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getNowPlayingMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getPopularMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getTopRatedMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getUpcomingMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getUpcomingSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
}
