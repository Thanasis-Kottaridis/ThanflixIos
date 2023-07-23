//
//  BaseErrorDispatcherImpl.swift
//  PayzyB2B
//
//  Created by thanos kottaridis on 28/6/23.
//

import Foundation
import Domain

public class BaseErrorDispatcherImpl: BaseErrorDispatcher {
    
    public init() {}
    
    public func handleErrors(
        actionHandler: BaseActionHandler?,
        error: BaseException,
        config: HandleErrorsConfig
    ) -> Bool {
        let genericErrorMessage = config.genericErrorMessage
  
        // MARK: Handle Unauthorized
        if error.errorCode == 401 {
            
            // custom handling
            guard config.handleUnauthorize == nil else {
                config.handleUnauthorize?()
                return true
            }
            
            self.logUserOut(actionHandler: actionHandler, isHard: true)
            return true
        }
        // MARK: Handle Unenrolled
        else if error.errorCode == 403 {
            
            // custom handling
            guard config.handleUnenroll == nil else {
                config.handleUnenroll?()
                return true
            }
            
            self.logUserOut(actionHandler: actionHandler, isHard: true)
            return true
        }
        // MARK: Handle intenal server error
        else if error.errorCode == 500 {
            
            // custom handling
            guard config.handleInternalServerError == nil else {
                config.handleInternalServerError?()
                return true
            }
            
            let action = PresentFeedbackAction(feedbackMessage: FeedbackMessage(message: genericErrorMessage, type: .error))
            actionHandler?.handleBaseAction(action: action)
            return true
        }
        // MARK: default error handling.
        else {
            
            // custom handling
            guard config.defaultHandling == nil else {
                config.defaultHandling?()
                return true
            }
            let action = PresentFeedbackAction(feedbackMessage: FeedbackMessage(message: genericErrorMessage, type: .error))
            actionHandler?.handleBaseAction(action: action)
            return true
        }
    }
    
    private func logUserOut(
        actionHandler: BaseActionHandler?,
        isHard: Bool = false,
        forReason: String? = nil
    ) {
        //Show feedbackMessage
        let action = PresentFeedbackAction(feedbackMessage: FeedbackMessage(message: forReason ?? Str.loginSessionInvalidated, type: .error))
        actionHandler?.handleBaseAction(action: action)
        
        // TODO: - Add logout and session invalidation.
    }
    
}
