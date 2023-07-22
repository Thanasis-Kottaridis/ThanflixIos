//
//  ShowDetails.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation


public struct ShowDetails: Codable, Equatable {
    
    public let id: Int?
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let title: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let popularity: Double?
    public let overview: [Overview]?
    public let productionCompanies: [ProductionCompany]?
    public let seasons: [Show]?
    
    public init(
        id: Int? = nil,
        posterPath: String? = nil,
        backdropPath: String? = nil,
        releaseDate: String? = nil,
        title: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        popularity: Double? = nil,
        overview: [Overview]? = nil,
        productionCompanies: [ProductionCompany]? = nil,
        seasons: [Show]? = nil
    ) {
        self.id = id
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.popularity = popularity
        self.overview = overview
        self.productionCompanies = productionCompanies
        self.seasons = seasons
    }
}

public struct Overview: Codable, Equatable {
    public let key: String
    public let value: String?
    
    public init(key: String, value: String? = nil) {
        self.key = key
        self.value = value
    }
}

public struct ProductionCompany: Codable, Equatable {
    
    public let id: Int?
    public let logoPath: String?
    public let name: String?
    
    public init(id: Int? = nil, logoPath: String? = nil, name: String? = nil) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
    }
}
