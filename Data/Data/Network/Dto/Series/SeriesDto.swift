//
//  SeriesDto.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation
public struct SeriesDto: Codable {
    
    public let backdropPath: String?
    public let firstAirDate: String?
    public let genreID: [Int]?
    public let id: Int?
    public let name: String?
    public let originCountry: [String]?
    public let originalLanguage: String?
    public let originalName: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    public init(
        backdropPath: String? = nil,
        firstAirDate: String? = nil,
        genreID: [Int]? = nil,
        id: Int? = nil,
        name: String? = nil,
        originCountry: [String]? = nil,
        originalLanguage: String? = nil,
        originalName: String? = nil,
        overview: String? = nil,
        popularity: Double? = nil,
        posterPath: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.backdropPath = backdropPath
        self.firstAirDate = firstAirDate
        self.genreID = genreID
        self.id = id
        self.name = name
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    
    
    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreID = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
