//
//  SeriesDetailsMapper.swift
//  Data
//
//  Created by thanos kottaridis on 23/7/23.
//

import Foundation
import Domain

public class SeriesDetailsMapper: DomainMapper {
    
    public typealias Model = SeriesDetailsDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = ShowDetails // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: SeriesDetailsDto) -> ShowDetails {
        return ShowDetails(
            id: model.id,
            posterPath: model.posterPath,
            backdropPath: model.backdropPath,
            releaseDate: convertDate(model.firstAirDate),
            title: model.name,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            popularity: model.popularity,
            overview: getShowOverview(model: model),
            productionCompanies: ProductionCompaniesMapper().mapDomainLists(modelList: model.productionCompanies ?? []),
            seasons: SeriesSeasonMapper().mapDomainLists(modelList: model.seasons ?? [])
        )
    }
    
    public func domainToModel(domainModel: ShowDetails) -> SeriesDetailsDto {
        return SeriesDetailsDto()
    }
    
    private func getShowOverview(model: SeriesDetailsDto) -> [Overview] {
        var showOverview: [Overview] = []
        
        // 1. add number of seasons and episodes
        if let seasons = model.numberOfSeasons,
           let episodes = model.numberOfEpisodes {
            showOverview.append(Overview(
                key: "OVERVIEW_SESONS_AND_EPISODES",
                value: "\(seasons) Seasons - \(episodes) Episodes"
            ))
        }

        
        // 2. add countries overview
        if let value = model.spokenLanguages {
            showOverview.append(Overview(
                key: "OVERVIEW_COUNTRIES",
                value:value.map({ $0.name }).joined(separator: ",")
            ))
        }
        
        // 3. Add language overview
        if let value = model.spokenLanguages {
            showOverview.append(Overview(
                key: "OVERVIEW_LANGUAGE",
                value: value.map({ $0.name }).joined(separator: ",")
            ))
        }
        
        // 4. Add Geners overview
        if let value = model.genres {
            showOverview.append(Overview(
                key: "OVERVIEW_GENERS",
                value: value.map({ $0.name }).joined(separator: ",")
            ))
        }
        
        // 5. Add Synopsis overview
        if let value = model.overview, !value.isEmpty {
            showOverview.append(Overview(
                key: "OVERVIEW_SYNOPSIS",
                value: value
            ))
        }
        
        return showOverview
    }
    
    
    private func convertDate(_ dateString: String?) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateString = dateString,
              let date = dateFormatter.date(from: dateString)
        else {
            // Return nil if the input date string is invalid
            return nil
        }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")

        return dateFormatter.string(from: date)
    }
}
