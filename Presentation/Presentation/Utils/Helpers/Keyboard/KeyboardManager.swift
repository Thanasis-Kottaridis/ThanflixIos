//
//  KeyboardManager.swift
//  Presentation
//
//  Created by thanos kottaridis on 22/7/23.
//

import Combine
import UIKit

/**
    # KeyboardManager
    This helper Manager is used in order to obsearve `keyboardWillShowNotification` and `keyboardWillHideNotification`
    in ordert to provide Keyboard Height to subscriber views using combine.
 */
public class KeyboardManager: ObservableObject {
    
    static let shared = KeyboardManager()
    
    @Published var keyboardHeight: CGFloat = 0
    
    var keyboardCancellable = Set<AnyCancellable>()
    
    public init() {
        NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                
                guard let userInfo = notification.userInfo else { return }
                guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                
                self.keyboardHeight = keyboardFrame.size.height
                
            }
            .store(in: &keyboardCancellable)
        
        NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillHideNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                
                guard let userInfo = notification.userInfo else { return }
                guard userInfo[UIResponder.keyboardFrameEndUserInfoKey] is CGRect else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.keyboardHeight =  0
                }
            }
            .store(in: &keyboardCancellable)

    }
    
}
