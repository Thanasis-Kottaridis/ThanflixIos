//
//  MoviePagingMapper.swift
//  Data
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation
import Domain

public class MoviePagingMapper: PagingDataDomainMapper {
    
    public typealias Model = MovieDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = Show // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: MovieDto) -> Show {
        return Show(
            id: model.id,
            posterPath: model.posterPath,
            releaseDate: model.releaseDate,
            title: model.title,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount
        )
    }
    
    public func domainToModel(domainModel: Show) -> MovieDto {
        return MovieDto()
    }

}
