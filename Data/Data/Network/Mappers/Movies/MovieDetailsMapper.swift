//
//  MovieDetailsMapper.swift
//  Data
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation
import Domain

public class MovieDetailsMapper: DomainMapper {
    
    public typealias Model = MovieDetailsDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = ShowDetails // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: MovieDetailsDto) -> ShowDetails {
        return ShowDetails(
            id: model.id,
            posterPath: model.posterPath,
            backdropPath: model.backdropPath,
            releaseDate: convertDate(model.releaseDate),
            title: model.title,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount,
            popularity: model.popularity,
            overview: getShowOverview(model: model),
            productionCompanies: ProductionCompaniesMapper().mapDomainLists(modelList: model.productionCompanies ?? [])
        )
    }
    
    public func domainToModel(domainModel: ShowDetails) -> MovieDetailsDto {
        return MovieDetailsDto()
    }
    
    private func getShowOverview(model: MovieDetailsDto) -> [Overview] {
        var showOverview: [Overview] = []
        
        // 1. add run time
        showOverview.append(Overview(
            key: "OVERVIEW_RUNTIME",
            value: formatMinutes(model.runtime ?? 0)
        ))
        
        // 2. add countries overview
        showOverview.append(Overview(
            key: "OVERVIEW_COUNTRIES",
            value: model.productionCountries?.map({ $0.name }).joined(separator: ",")
        ))
        
        // 3. Add language overview
        showOverview.append(Overview(
            key: "OVERVIEW_LANGUAGE",
            value: model.spokenLanguages?.map({ $0.name }).joined(separator: ",")
        ))
        
        // 4. Add Geners overview
        showOverview.append(Overview(
            key: "OVERVIEW_GENERS",
            value: model.genres?.map({ $0.name }).joined(separator: ",")
        ))
        
        // 5. Add Budget overview
        showOverview.append(Overview(
            key: "OVERVIEW_BUDGET",
            value: formatAmountInDollars(model.budget ?? 0)
        ))
        
        // 6. Add Revenuw overview
        showOverview.append(Overview(
            key: "OVERVIEW_REVENUE",
            value: formatAmountInDollars(model.revenue ?? 0)
        ))
        
        // 7. Add Revenuw overview
        showOverview.append(Overview(
            key: "OVERVIEW_SYNOPSIS",
            value: model.overview
        ))
        
        return showOverview
    }
    
    private func formatAmountInDollars(_ amount: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        
        return formatter.string(from: NSNumber(value: amount))
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
    
    private func formatMinutes(_ totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        var formattedTime = ""
        if hours > 0 {
            formattedTime += "\(hours) Hour"
            if hours > 1 {
                formattedTime += "s"
            }
        }
        
        if minutes > 0 {
            if !formattedTime.isEmpty {
                formattedTime += " "
            }
            formattedTime += "\(minutes) Minute"
            if minutes > 1 {
                formattedTime += "s"
            }
        }
        
        return formattedTime
    }
}
