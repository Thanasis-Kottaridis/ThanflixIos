//
//  SeriesDetailsDto.swift
//  Data
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation

public struct SeriesDetailsDto: Codable {
    
    public let adult: Bool?
    public let backdropPath: String?
    public let createdBy: [CreatorDto]?
    public let episodeRunTime: [Int]?
    public let firstAirDate: String?
    public let genres: [GenreDto]?
    public let homepage: String?
    public let id: Int?
    public let inProduction: Bool?
    public let languages: [String]?
    public let lastAirDate: String?
    public let lastEpisodeToAir: EpisodeDto?
    public let name: String?
    public let nextEpisodeToAir: EpisodeDto?
    public let networks: [NetworkDto]?
    public let numberOfEpisodes: Int?
    public let numberOfSeasons: Int?
    public let originCountry: [String]?
    public let originalLanguage: String?
    public let originalName: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompanyDto]?
    public let productionCountries: [ProductionCountryDto]?
    public let seasons: [SeasonDto]?
    public let spokenLanguages: [SpokenLanguageDto]?
    public let status: String?
    public let tagline: String?
    public let type: String?
    public let voteAverage: Double?
    public let voteCount: Int?

    public init(
        adult: Bool? = nil,
        backdropPath: String? = nil,
        createdBy: [CreatorDto]? = nil,
        episodeRunTime: [Int]? = nil,
        firstAirDate: String? = nil,
        genres: [GenreDto]? = nil,
        homepage: String? = nil,
        id: Int? = nil,
        inProduction: Bool? = nil,
        languages: [String]? = nil,
        lastAirDate: String? = nil,
        lastEpisodeToAir: EpisodeDto? = nil,
        name: String? = nil,
        nextEpisodeToAir: EpisodeDto? = nil,
        networks: [NetworkDto]? = nil,
        numberOfEpisodes: Int? = nil,
        numberOfSeasons: Int? = nil,
        originCountry: [String]? = nil,
        originalLanguage: String? = nil,
        originalName: String? = nil,
        overview: String? = nil,
        popularity: Double? = nil,
        posterPath: String? = nil,
        productionCompanies: [ProductionCompanyDto]? = nil,
        productionCountries: [ProductionCountryDto]? = nil,
        seasons: [SeasonDto]? = nil,
        spokenLanguages: [SpokenLanguageDto]? = nil,
        status: String? = nil,
        tagline: String? = nil,
        type: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.createdBy = createdBy
        self.episodeRunTime = episodeRunTime
        self.firstAirDate = firstAirDate
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.inProduction = inProduction
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.lastEpisodeToAir = lastEpisodeToAir
        self.name = name
        self.nextEpisodeToAir = nextEpisodeToAir
        self.networks = networks
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.seasons = seasons
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.type = type
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
