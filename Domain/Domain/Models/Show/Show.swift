//
//  Show.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

public struct Show: Codable, Equatable {
    
    public let id: Int?
    public let posterPath: String?
    public let releaseDate: String?
    public let title: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    public init(
        id: Int? = nil,
        posterPath: String? = nil,
        releaseDate: String? = nil,
        title: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.id = id
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
