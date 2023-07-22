//
//  Str.swift
//  Allios-ios
//

import Foundation
import Domain

public struct Str {

    // MARK: GENERIC ERROR MESSAGES
    public static var somethingWentWrongTryAgain: String { Languages.tr("SOMETHING_WENT_WRONG_TRY_AGAIN") }
    public static var loginSessionInvalidated: String { Languages.tr("LOGIN_SESSION_INVALIDATED") }
    public static var networkError: String { Languages.tr("NETWORK_ERROR") }
    public static var networkRestored: String { Languages.tr("NETWORK_RESTORED") }
    
    // MARK: MOVIES LANDING
    public static var moviesLandingTitle: String { Languages.tr("MOVIES_LANDING_TITLE") }
    public static var moviesLandingNowPlaying: String { Languages.tr("MOVIES_LANDING_NOW_PLAYING") }
    public static var moviesLandingMostPopular: String { Languages.tr("MOVIES_LANDING_MOST_POPULAR") }
    public static var moviesLandingTopRated: String { Languages.tr("MOVIES_LANDING_TOP_RATED") }
    public static var moviesLandingUpcoming: String { Languages.tr("MOVIES_LANDING_UPCOMING") }

    // MARK: SERIES LANDING
    public static var seriesLandingTitle: String { Languages.tr("SERIES_LANDING_TITLE") }
    public static var seriesLandingToday: String { Languages.tr("SERIES_LANDING_TODAY") }
    public static var seriesLandingOnTheAir: String { Languages.tr("SERIES_LANDING_ON_THE_AIR") }
    public static var seriesLandingTopRated: String { Languages.tr("SERIES_LANDING_TOP_RATED") }
    public static var seriesLandingPopular: String { Languages.tr("SERIES_LANDING_POPULAR") }
    
    // MARK: SHOW DETAILS INFO
    public static var releaseDateInfo: String { Languages.tr("RELEASE_DATE_INFO") }
    public static var watchedButtonTitle: String { Languages.tr("WATCHED_BUTTON_TITLE") }
    public static var voteAverageTitle: String { Languages.tr("VOTE_AVERAGE_TITLE") }
    public static var voteCountTitle: String { Languages.tr("VOTE_COUNT_TITLE") }
    public static var popularityTitle: String { Languages.tr("VOTE_POPULARITY_TITLE") }
    public static var overviewTitle: String { Languages.tr("OVERVIEW_TITLE") }
    public static var readMoreTitle: String { Languages.tr("READ_MORE_TITLE") }
    public static var productionCompaniesTitle: String { Languages.tr("PRODUCTION_COMPANIES_TITLE") }
}
