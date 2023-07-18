//
//  SpokenLanguage.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

struct SpokenLanguageDto: Codable {
    let englishName: String
    let isoCode: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case isoCode = "iso_639_1"
        case name
    }
}
