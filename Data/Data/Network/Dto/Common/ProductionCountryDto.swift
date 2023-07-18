//
//  ProductionCountryDto.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

struct ProductionCountryDto: Codable {
    let isoCode: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case isoCode = "iso_3166_1"
        case name
    }
}
