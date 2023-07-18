//
//  SpokenLanguage.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

public struct SpokenLanguageDto: Codable {
    
    public let englishName: String
    public let isoCode: String
    public let name: String

    public init(englishName: String, isoCode: String, name: String) {
        self.englishName = englishName
        self.isoCode = isoCode
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case isoCode = "iso_639_1"
        case name
    }
}
