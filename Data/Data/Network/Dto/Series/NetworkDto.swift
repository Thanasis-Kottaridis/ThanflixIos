//
//  NetworkDto.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation

public struct NetworkDto: Codable {
    
    public let id: Int?
    public let logoPath: String?
    public let name: String?
    public let  originCountry: String?
    
    public init(id: Int? = nil, logoPath: String? = nil, name: String? = nil, originCountry: String? = nil) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
