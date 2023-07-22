//
//  SeriesDataContext.swift
//  Domain
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation

public protocol SeriesDataContext {
    /// # Series Endpoints
    func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getPopularSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException>
    func getSeriesDetails(seriesId: Int) async -> Result<ShowDetails?, BaseException>
}


public class DefaultSeriesDataContext: SeriesDataContext {
    
    public init() {}
    
    public func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getPopularSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }
    
    public func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        fatalError("Not Yet Implemented")
    }

    public func getSeriesDetails(seriesId: Int) async -> Result<ShowDetails?, BaseException> {
        fatalError("Not Yet Implemented")
    }
}
