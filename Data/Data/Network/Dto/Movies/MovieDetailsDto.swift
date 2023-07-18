//
//  MovieDetails.swift
//  Domain
//
//  Created by thanos kottaridis on 18/7/23.
//

import Foundation

public struct MovieDetailsDto: Codable {
    
    public let adult: Bool?
    public let backdropPath: String?
    public let belongsToCollection: MovieCollectionDto?
    public let budget: Int?
    public let genres: [GenreDto]?
    public let homepage: String?
    public let id: Int?
    public let imdbID: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompanyDto]?
    public let productionCountries: [ProductionCountryDto]?
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguageDto]?
    public let status: String?
    public let tagline: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    public init(
        adult: Bool? = nil,
        backdropPath: String? = nil,
        belongsToCollection: MovieCollectionDto? = nil,
        budget: Int? = nil,
        genres: [GenreDto]? = nil,
        homepage: String? = nil,
        id: Int? = nil,
        imdbID: String? = nil,
        originalLanguage: String? = nil,
        originalTitle: String? = nil,
        overview: String? = nil,
        popularity: Double? = nil,
        posterPath: String? = nil,
        productionCompanies: [ProductionCompanyDto]? = nil,
        productionCountries: [ProductionCountryDto]? = nil,
        releaseDate: String? = nil,
        revenue: Int? = nil,
        runtime: Int? = nil,
        spokenLanguages: [SpokenLanguageDto]? = nil,
        status: String? = nil,
        tagline: String? = nil,
        title: String? = nil,
        video: Bool? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
