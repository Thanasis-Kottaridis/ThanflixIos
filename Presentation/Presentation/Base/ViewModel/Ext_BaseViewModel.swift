//
//  Ext_BaseViewModel.swift
//  SharedPresentation
//
//  Created by thanos kottaridis on 28/6/23.
//

import Foundation
import Domain
import Combine

extension SwiftUIBaseViewModel {
    
    public func commonInit() {
        setUpLoadingObserver()
        setUpConnectivityObserver()
    }
    
    private func setUpLoadingObserver() {
        statePublisher
            .receive(on: DispatchQueue.main) // observe on main thread
            .map { $0.isLoading }
            .removeDuplicates()
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.actionHandler?.handleAction(action: ShowLoaderAction())
                } else {
                    self?.actionHandler?.handleAction(action: HideLoaderAction())
                }
            }
            .store(in: &anyCancelable)
    }
    
    private func setUpConnectivityObserver() {
        Publishers.Zip(statePublisher, statePublisher.dropFirst())
            .map { (oldState, newState) in
                return (newState.isOnline, oldState.isOnline)
            }
            .sink { [weak self] (newIsOnline, oldIsOnline) in
                guard let self = self else { return }
                if newIsOnline != oldIsOnline, !oldIsOnline {
                    self.actionHandler?.handleAction(action: PresentFeedbackAction(
                        feedbackMessage: FeedbackMessage.getNetworkFeedbackMessage(isOnline: true)
                    ))
                } else if !newIsOnline, newIsOnline != oldIsOnline {
                    self.actionHandler?.handleAction(action: PresentFeedbackAction(
                        feedbackMessage: FeedbackMessage.getNetworkFeedbackMessage(isOnline: false)
                    ))
                }
            }
            .store(in: &anyCancelable)
    }
}

extension BaseErrorHandler {
    
    @discardableResult
    public func handleErrors(
        error: BaseException,
        config: HandleErrorsConfig = HandleErrorsConfig.Builder().build()
    ) -> Bool {
        @Injected(\.errorDispatcher)
        var errorDispatcher: BaseErrorDispatcher
        return errorDispatcher.handleErrors(
            actionHandler: actionHandler,
            error: error,
            config: config
        )
    }
    
    public func ensureMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}
