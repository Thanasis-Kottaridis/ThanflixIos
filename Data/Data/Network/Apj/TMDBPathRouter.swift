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
    
    case getFavoriteMovies
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .getFavoriteMovies:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getFavoriteMovies:
            return "account/\(accountID)/favorite/movies"
        }
    }
    
    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .put, .post, .get:
            switch self {
                case .getFavoriteMovies:
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
        }
        
        // TODO: - Add Constant headers (device info, language etc)
        
        var finalRequest = try encoding.encode(request, with: parameters)
        
        // Log request
        print(request)
        return finalRequest
    }
}
