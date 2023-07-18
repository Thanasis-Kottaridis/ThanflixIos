//
//  MoviesDataContextImpl.swift
//  Data
//
//  Created by thanos kottaridis on 7/7/23.
//

import Foundation
import Domain
import Alamofire

public class MoviesDataContextImpl: MoviesDataContext {

    private let sessionManager: Session = InjectedValues[\.networkProvider].sessionManager

    public init() {}
    
    // MARK: - Acount Endpoints
    public func getFavoriteMovies() async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getFavoriteMovies)
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    // MARK: - Movies Endpoint
    public func getNowPlayingMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getNowPlayingMovies(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getPopularMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getPopularMovies(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getTopRatedMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getTopRatedMovies(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getUpcomingMovies(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getUpcomingMovies(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getMovieDetails(movieId: Int) async -> Result<ShowDetails?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getMovieDetails(movieId: movieId))
            .validateRawResponseWrapper(
                fromType: MovieDetailsDto.self,
                mapperType: ShowDetails.self,
                mapper: { response in
                    return MovieDetailsMapper().modelToDomain(model: response)
                }
            )
    }
    
    
    
    // MARK: - Series Endpoint
    public func getAiringTodaySeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getAiringTodaySeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getOnTheAirSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getOnTheAirSeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getTopRatedSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getTopRatedSeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
    
    public func getUpcomingSeries(page: Int) async -> Result<PagedListResult<Show>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getUpcomingSeries(page: page))
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[MovieDto]>.self,
                mapperType: PagedListResult<Show>.self,
                mapper: { response in
                    return MoviePagingMapper().domainToPagingData(response: response)
                }
            )
    }
}
