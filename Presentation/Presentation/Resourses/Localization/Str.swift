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
    
    // MARK: SHOW DETAILS INFO
    public static var releaseDateInfo: String { Languages.tr("RELEASE_DATE_INFO") }
    public static var watchedButtonTitle: String { Languages.tr("WATCHED_BUTTON_TITLE") }
    public static var voteAverageTitle: String { Languages.tr("VOTE_AVERAGE_TITLE") }
    public static var voteCountTitle: String { Languages.tr("VOTE_COUNT_TITLE") }
    public static var popularityTitle: String { Languages.tr("VOTE_POPULARITY_TITLE") }
}
