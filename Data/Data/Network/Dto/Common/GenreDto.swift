//
//  Genre.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

public struct GenreDto: Codable {

    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
