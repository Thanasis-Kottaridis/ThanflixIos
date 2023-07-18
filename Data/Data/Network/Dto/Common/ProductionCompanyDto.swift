//
//  ProductionCompanyDto.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

struct ProductionCompanyDto: Codable {
    let id: Int
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
