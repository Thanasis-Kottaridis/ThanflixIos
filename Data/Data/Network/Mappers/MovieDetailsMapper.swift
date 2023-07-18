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
            releaseDate: model.releaseDate,
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
        
        // 1. add countries overview
        showOverview.append(Overview(
            key: "OVERVIEW_COUNTRIES",
            value: model.productionCountries?.map({ $0.name }).joined(separator: ",")
        ))
        
        // 2. Add language overview
        showOverview.append(Overview(
            key: "OVERVIEW_LANGUAGE",
            value: model.spokenLanguages?.map({ $0.name }).joined(separator: ",")
        ))
        
        // 3. Add Geners overview
        showOverview.append(Overview(
            key: "OVERVIEW_GENERS",
            value: model.genres?.map({ $0.name }).joined(separator: ",")
        ))
        
        // 4. Add Budget overview
        showOverview.append(Overview(
            key: "OVERVIEW_BUDGET",
            value: formatAmountInDollars(model.budget ?? 0)
        ))
        
        // 5. Add Revenuw overview
        showOverview.append(Overview(
            key: "OVERVIEW_REVENUE",
            value: formatAmountInDollars(model.revenue ?? 0)
        ))
        
        // 6. Add Revenuw overview
        showOverview.append(Overview(
            key: "OVERVIEW_SYNOPSIS",
            value: model.overview
        ))
        
        return showOverview
    }
    
    func formatAmountInDollars(_ amount: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        
        return formatter.string(from: NSNumber(value: amount))
    }
}


public class ProductionCompaniesMapper: DomainMapper {
    
    public typealias Model = ProductionCompanyDto // TODO ADD DTO (API RESPONSE) MODEL
    
    public typealias DomainModel = ProductionCompany // TODO Add application Model
    
    public init() {}
    
    public func modelToDomain(model: ProductionCompanyDto) -> ProductionCompany {
        return ProductionCompany(id: model.id, logoPath: model.logoPath, name: model.name)
    }
    
    public func domainToModel(domainModel: ProductionCompany) -> ProductionCompanyDto {
        return ProductionCompanyDto()
    }
}
