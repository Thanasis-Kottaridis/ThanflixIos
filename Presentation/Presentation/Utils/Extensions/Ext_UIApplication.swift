//
//  Ext_UIApplication.swift
//  Presentation
//
//  Created by thanos kottaridis on 8/7/23.
//

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
}
