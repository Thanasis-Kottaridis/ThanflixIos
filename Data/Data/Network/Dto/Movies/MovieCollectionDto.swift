//
//  MovieCollectionDto.swift
//  Data
//
//  Created by thanos kottaridis on 19/7/23.
//

import Foundation

public struct MovieCollectionDto: Codable {
    
    public let backdropPath: String?
    public let id: Int
    public let name: String
    public let posterPath: String?
    
    public init(backdropPath: String? = nil, id: Int, name: String, posterPath: String? = nil) {
        self.backdropPath = backdropPath
        self.id = id
        self.name = name
        self.posterPath = posterPath
    }
    
    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case name
        case posterPath = "poster_path"
    }
}
