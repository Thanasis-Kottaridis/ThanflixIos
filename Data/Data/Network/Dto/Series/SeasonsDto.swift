//
//  SeasonsDto.swift
//  Data
//
//  Created by thanos kottaridis on 23/7/23.
//

import Foundation

public struct SeasonDto: Codable {
    
    public let airDate: String?
    public let episodeCount, id: Int?
    public let name, overview: String?
    public let posterPath: String?
    public let seasonNumber: Int?
    public let voteAverage: Double?
    
    public init(
        airDate: String? = nil,
        episodeCount: Int? = nil,
        id: Int? = nil,
        name: String? = nil,
        overview: String? = nil,
        posterPath: String? = nil,
        seasonNumber: Int? = nil,
        voteAverage: Double? = nil
    ) {
        self.airDate = airDate
        self.episodeCount = episodeCount
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.seasonNumber = seasonNumber
        self.voteAverage = voteAverage
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}
