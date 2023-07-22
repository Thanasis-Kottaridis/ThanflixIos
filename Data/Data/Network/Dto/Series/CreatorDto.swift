//
//  CreatorDto.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation

public struct CreatorDto: Codable {
    
    public let id: Int?
    public let creditID: String?
    public let name: String?
    public let gender: Int?
    public let profilePath: String?

    public init(
        id: Int? = nil,
        creditID: String? = nil,
        name: String? = nil,
        gender: Int? = nil,
        profilePath: String? = nil
    ) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.gender = gender
        self.profilePath = profilePath
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}
