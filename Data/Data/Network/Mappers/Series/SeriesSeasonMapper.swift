//
//  SeriesSeasonMapper.swift
//  Data
//
//  Created by thanos kottaridis on 23/7/23.
//

import Foundation
import Domain

public class SeriesSeasonMapper: DomainMapper {
    
    public typealias Model = SeasonDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = Show // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: SeasonDto) -> Show {
        return Show(
            id: model.id,
            posterPath: model.posterPath,
            releaseDate: model.airDate,
            title: model.name,
            voteAverage: model.voteAverage
        )
    }
    
    public func domainToModel(domainModel: Show) -> SeasonDto {
        return SeasonDto()
    }
}
