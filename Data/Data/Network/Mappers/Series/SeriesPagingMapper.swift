//
//  SeriesPagingMapper.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation
import Domain

public class SeriesPagingMapper: PagingDataDomainMapper {
    
    public typealias Model = SeriesDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = Show // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: SeriesDto) -> Show {
        return Show(
            id: model.id,
            posterPath: model.posterPath,
            releaseDate: model.firstAirDate,
            title: model.name,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount
        )
    }
    
    public func domainToModel(domainModel: Show) -> SeriesDto {
        return SeriesDto()
    }

}
