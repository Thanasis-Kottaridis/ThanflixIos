//
//  ShowDetails.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation


public struct ShowDetails: Codable {
    
    public let id: Int?
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let title: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let popularity: Double
    public let overview: [Overview]
    public let productionCompanies: [ProductionCompanies]
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case overview
        case productionCompanies
    }
}

public struct Overview: Codable {
    public let key: String?
    public let value: String?
    
    public init(key: String? = nil, value: String? = nil) {
        self.key = key
        self.value = value
    }
}

public struct ProductionCompanies: Codable {
    
    public let id: Int
    public let logoPath: String?
    public let name: String?
    
    public init(id: Int, logoPath: String? = nil, name: String? = nil) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
    }
}
