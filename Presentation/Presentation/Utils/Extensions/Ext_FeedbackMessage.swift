//
//  Ext_FeedbackMessage.swift
//  Presentation
//
//  Created by thanos kottaridis on 8/7/23.
//

import Foundation
import Domain

extension FeedbackMessage {
    public static func getNetworkFeedbackMessage(isOnline: Bool) -> Self {
        return FeedbackMessage(
            message: isOnline ? Str.networkRestored : Str.networkError,
            type: .network(isError: !isOnline)
        )
    }
}
