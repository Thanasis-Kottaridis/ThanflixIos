//
//  SeriesDataContextImpl.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation
import Domain
import Alamofire

public class SeriesDataContextImpl: SeriesDataContext {
    
    private let sessionManager: Session = InjectedValues[\.networkProvider].sessionManager

    public init() {}
    
    // MARK: - Series Endpoint
    public func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getAiringTodaySeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[SeriesDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return SeriesPagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getOnTheAirSeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[SeriesDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return SeriesPagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getPopularSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getPopularSeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[SeriesDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return SeriesPagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getTopRatedSeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[SeriesDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return SeriesPagingMapper().domainToPagingData(response: response)
                }
            )
    }
}
