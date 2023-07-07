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
}
