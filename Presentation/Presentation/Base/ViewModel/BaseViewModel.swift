//
//  BaseViewModel.swift
//  Presentation
//
//  Created by thanos kottaridis on 1/2/23.
//

import Foundation
import SwiftUI
import Domain
import Combine

// MARK: - Base Error Handler
/**
 This Protocol Has a default implementation on handleErrors Method.
 Handle errors method is used to handle all common errors that can be occured on any flow
 For example:
 - 401 for unauthorized
 - (-1100)..<(-1000): For Alamofire no internet Response
 
 It is also capable of handling all known buisness errors from `BaseException.exception` provided from Back End.
 */
public protocol BaseErrorHandler: AnyObject, BaseActionDispatcher {
    
    /**
     Handle Errors methos takes a BaseException error and displays the respective message / view to user.
     - Parameter error: Base excatpion error.
     - Parameter config: This parameter is used to pass error handling configurations
     - Returns: A Bool that shows if the error case handled or not.
     */
    @discardableResult
    func handleErrors(error: BaseException, config: HandleErrorsConfig) -> Bool
    
    func ensureMainThread(_ block:  @escaping () -> Void)
}

// MARK: - SwiftUI Base View Model
public protocol BaseViewModel: ObservableObject, BaseErrorHandler {
    associatedtype State: BaseState
    associatedtype Event
    
    var state: State { get }
    var stateValue: Published<State> { get }
    var statePublisher: Published<State>.Publisher { get }
    var anyCancelable: Set<AnyCancellable> { get set }
    
    func commonInit()
    func onTriggeredEvent(event: Event)
}

// MARK: - HandleErrorsConfig
public class HandleErrorsConfig {
    
    public let genericErrorMessage: String
    public let handleForceUdate: (() -> Void)?
    public let handleMeintenance: (() -> Void)?
    public let handleUnauthorize: (() -> Void)?
    public let handleUnenroll: (() -> Void)?
    public let handlePassExpiration: (() -> Void)?
    public let handleInternalServerError: (() -> Void)?
    public let defaultHandling: (() -> Void)?
    
    public init(
        genericErrorMessage: String,
        handleForceUdate: (() -> Void)?,
        handleMeintenance: (() -> Void)?,
        handleUnauthorize: (() -> Void)?,
        handleUnenroll: (() -> Void)?,
        handlePassExpiration: (() -> Void)?,
        handleInternalServerError: (() -> Void)?,
        defaultHandling: (() -> Void)?
    ) {
        self.genericErrorMessage = genericErrorMessage
        self.handleForceUdate = handleForceUdate
        self.handleMeintenance = handleMeintenance
        self.handleUnauthorize = handleUnauthorize
        self.handleUnenroll = handleUnenroll
        self.handlePassExpiration = handlePassExpiration
        self.handleInternalServerError = handleInternalServerError
        self.defaultHandling = defaultHandling
    }
    
    public class Builder {
        private var genericErrorMessage: String = Str.somethingWentWrongTryAgain
        private var handleForceUdate: (() -> Void)?
        private var handleMeintenance: (() -> Void)?
        private var handleUnauthorize: (() -> Void)?
        private var handleUnenroll: (() -> Void)?
        private var handlePassExpiration: (() -> Void)?
        private var handleInternalServerError: (() -> Void)?
        private var defaultHandling: (() -> Void)?
        
        public init() {}
        
        @discardableResult
        public func setGenericErrorMessage(message: String) -> Self {
            self.genericErrorMessage = message
            return self
        }
        
        @discardableResult
        public func setHandleForceUdate(handler: (() -> Void)?) -> Self {
            self.handleForceUdate = handler
            return self
        }
        
        @discardableResult
        public func setHandleMeintenance(handler: (() -> Void)?) -> Self {
            self.handleMeintenance = handler
            return self
        }
        
        @discardableResult
        public func setHandleUnauthorize(handler: (() -> Void)?) -> Self {
            self.handleUnauthorize = handler
            return self
        }
        
        @discardableResult
        public func setHandleUnenroll(handler: (() -> Void)?) -> Self {
            self.handleUnenroll = handler
            return self
        }
        
        @discardableResult
        public func setPassExpiration(handler: (() -> Void)?) -> Self {
            self.handlePassExpiration = handler
            return self
        }
        
        @discardableResult
        public func setHandleInternalServerError(handler: (() -> Void)?) -> Self {
            self.handleInternalServerError = handler
            return self
        }
        
        @discardableResult
        public func setDefaultHandling(handler: (() -> Void)?) -> Self {
            self.defaultHandling = handler
            return self
        }
        
        public func build() -> HandleErrorsConfig {
            return HandleErrorsConfig(
                genericErrorMessage: genericErrorMessage,
                handleForceUdate: handleForceUdate,
                handleMeintenance: handleMeintenance,
                handleUnauthorize: handleUnauthorize,
                handleUnenroll: handleUnenroll,
                handlePassExpiration: handlePassExpiration,
                handleInternalServerError: handleInternalServerError,
                defaultHandling: defaultHandling
            )
        }
    }
}
