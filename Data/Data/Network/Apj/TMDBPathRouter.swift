//
//  TMDBPathRouter.swift
//  Data
//
//  Created by thanos kottaridis on 5/7/23.
//

import Foundation
import Alamofire
import Domain

public enum TMDBPathRouter: URLRequestConvertible {
    
    // MARK: - Inject DataModule AppConfig.
    private var baseURLPath: String {
        @Injected(\.dataAppConfig)
        var appConfig: DataAppConfig
        return appConfig.appApiBaseUrl
    }
    
    private var accountID: String {
        @Injected(\.dataAppConfig)
        var appConfig: DataAppConfig
        return appConfig.accountId
    }
    
    /// # Account Endpoint
    case getFavoriteMovies
    
    /// # Movies Endpoints
    case getNowPlayingMovies(page: Int)
    case getPopularMovies(page: Int)
    case getTopRatedMovies(page: Int)
    case getUpcomingMovies(page: Int)
    case getMovieDetails(movieId: Int)
    
    /// # Series Endpoints
    case getAiringTodaySeries(page: Int)
    case getOnTheAirSeries(page: Int)
    case getTopRatedSeries(page: Int)
    case getUpcomingSeries(page: Int)
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .getFavoriteMovies,
                .getNowPlayingMovies,
                .getPopularMovies,
                .getTopRatedMovies,
                .getUpcomingMovies,
                .getMovieDetails,
                .getAiringTodaySeries,
                .getOnTheAirSeries,
                .getTopRatedSeries,
                .getUpcomingSeries:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
            /// # Account Endpoint
        case .getFavoriteMovies:
            return "account/\(accountID)/favorite/movies"
            /// # Movies Endpoints
        case .getNowPlayingMovies:
            return "movie/now_playing"
        case .getPopularMovies:
            return "movie/popular"
        case .getTopRatedMovies:
            return "movie/top_rated"
        case .getUpcomingMovies:
            return "movie/upcoming"
        case .getMovieDetails(movieId: let movieId):
            return "movie/\(movieId)"
            
            /// # Series Endpoints
        case .getAiringTodaySeries:
            return "tv/airing_today"
        case .getOnTheAirSeries:
            return "tv/on_the_air"
        case .getTopRatedSeries:
            return "tv/popular"
        case .getUpcomingSeries:
            return "tv/top_rated"
        }
    }
    
    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .put, .post, .get:
            switch self {
            case .getFavoriteMovies,
                    .getNowPlayingMovies,
                    .getPopularMovies,
                    .getTopRatedMovies,
                    .getUpcomingMovies,
                    .getMovieDetails,
                    .getAiringTodaySeries,
                    .getOnTheAirSeries,
                    .getTopRatedSeries,
                    .getUpcomingSeries:
                return URLEncoding.queryString
                
            }
        default:
            return URLEncoding.queryString
        }
    }
    
    // MARK: Headers
    var headers: [String: String] {
        var headers: [String: String] = [:]
        
        @Injected(\.requestHeadersBuilder)
        var requestHeadersBuilder: RequestHeadersBuilder
        
        requestHeadersBuilder.build(headers: &headers)
        
        return headers
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        var parameters: Parameters?
        
        switch self {
        case .getFavoriteMovies:
            parameters = [
                "language":"en-US",
                "page":"1",
                "sort_by":"created_at.asc"
            ]
        case .getNowPlayingMovies(page: let page):
            parameters = [
                "page":page,
            ]
        case .getPopularMovies(page: let page):
            parameters = [
                "page":page,
            ]
        case .getTopRatedMovies(page: let page):
            parameters = [
                "page":page,
            ]
        case .getUpcomingMovies(page: let page):
            parameters = [
                "page":page,
            ]
        case .getAiringTodaySeries(page: let page):
            parameters = [
                "page":page,
            ]
        case .getOnTheAirSeries(page: let page):
            parameters = [
                "page":page,
            ]
        case .getTopRatedSeries(page: let page):
            parameters = [
                "page":page,
            ]
        case .getUpcomingSeries(page: let page):
            parameters = [
                "page":page,
            ]
        default:
            break
        }
        
        // TODO: - Add Constant headers (device info, language etc)
        
        var finalRequest = try encoding.encode(request, with: parameters)
        
        // Log request
        print(request)
        return finalRequest
    }
}
