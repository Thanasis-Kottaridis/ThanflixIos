//
//  BaseErrorDispatcher.swift
//  SharedPresentation
//
//  Created by thanos kottaridis on 27/6/23.
//

import Foundation
import Domain

public protocol BaseErrorDispatcher {
    func handleErrors(
        actionHandler: BaseActionHandler?,
        error: BaseException,
        config: HandleErrorsConfig
    ) -> Bool
}

public class DefaultBaseErrorDispatcher: BaseErrorDispatcher {
    public func handleErrors(actionHandler: BaseActionHandler?, error: BaseException, config: HandleErrorsConfig) -> Bool {
        fatalError("Not Yet Implemented")
    }
}
