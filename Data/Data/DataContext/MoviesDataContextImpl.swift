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
    
    public func getFavoriteMovies() async -> Result<PagedListResult<Movie>?, BaseException> {
        return await sessionManager
            .request( TMDBPathRouter.getFavoriteMovies)
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[Movie]>.self,
                mapperType: PagedListResult<Movie>.self,
                mapper: { response in
                    return GenericPagingMapper<Movie>().domainToPagingData(response: response)
                }
            )
    }
}
