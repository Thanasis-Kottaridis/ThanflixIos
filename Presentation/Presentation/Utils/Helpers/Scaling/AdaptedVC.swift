//
//  AdaptedVC.swift
//  Payzy
//
//  Created by thanos kottaridis on 23/5/22.
//

import UIKit

public protocol AdaptedVC {
    var contentView: UIView! { get set }
    var contentViewHeight: NSLayoutConstraint! { get set }
    var contentViewWidth: NSLayoutConstraint! { get set }

    func adaptContentView()
}

public extension AdaptedVC {
    
    var safeAreaBottomPadding: CGFloat {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    var safeAreaTopPadding: CGFloat {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window?.safeAreaInsets.top ?? 0
    }
    
    var scaleFactor: CGFloat {
        return UIScreen.main.bounds.width / Dimension.width.getReferenceDimension()
    }
    
    func adaptContentView() {
        let screenRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
        contentViewWidth.constant = Dimension.width.getReferenceDimension()
        contentViewHeight.constant = (screenRatio * Dimension.width.getReferenceDimension())
        
        contentView.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
}
