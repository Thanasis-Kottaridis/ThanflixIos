//
//  ProductionCountryDto.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

public struct ProductionCountryDto: Codable {
    public let isoCode: String
    public let name: String

    public init(isoCode: String, name: String) {
        self.isoCode = isoCode
        self.name = name
    }
    
    private enum CodingKeys: String, CodingKey {
        case isoCode = "iso_3166_1"
        case name
    }
}
