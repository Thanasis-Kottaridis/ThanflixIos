//
//  EpisodeDto.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation

public struct EpisodeDto: Codable {
    public let id: Int?
    public let name: String?
    public let overview: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let airDate: String?
    public let episodeNumber: Int?
    public let productionCode: String?
    public let runtime: Int?
    public let seasonNumber, showID: Int?
    public let stillPath: String?

    public init(
        id: Int? = nil,
        name: String? = nil,
        overview: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        airDate: String? = nil,
        episodeNumber: Int? = nil,
        productionCode: String? = nil,
        runtime: Int? = nil,
        seasonNumber: Int? = nil,
        showID: Int? = nil,
        stillPath: String? = nil
    ) {
        self.id = id
        self.name = name
        self.overview = overview
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.airDate = airDate
        self.episodeNumber = episodeNumber
        self.productionCode = productionCode
        self.runtime = runtime
        self.seasonNumber = seasonNumber
        self.showID = showID
        self.stillPath = stillPath
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}
