//
//  GenericHeaderView.swift
//  Presentation
//
//  Created by thanos kottaridis on 11/7/23.
//

import UIKit

enum GenericHeaderState {
    case expand
    case collapsed
}

public struct GenericHeaderConfigurations {
    
    let title: String?
    let titleColor: ColorPalette?
    let leftIconName: String?
    let leftIconTint: ColorPalette?
    let rightIconName: String?
    let rightIconTint: ColorPalette?
    
    public init(
        title: String? = nil,
        titleColor: ColorPalette? = nil,
        leftIconName: String? = nil,
        leftIconTint: ColorPalette? = nil,
        rightIconName: String? = nil,
        rightIconTint: ColorPalette? = nil
    ) {
        self.title = title
        self.titleColor = titleColor
        self.leftIconName = leftIconName
        self.leftIconTint = leftIconTint
        self.rightIconName = rightIconName
        self.rightIconTint = rightIconTint
    }
    
    public class Builder {
        private var title: String?
        private var titleColor: ColorPalette? = .TintPrimary
        private var leftIconName: String?
        private var leftIconTint: ColorPalette? = .TintSecondary
        private var rightIconName: String?
        private var rightIconTint: ColorPalette? = .TintSecondary
        
        public init() {}
        
        @discardableResult
        public func addTitle(title: String) -> Self {
            self.title = title
            return self
        }
        
        @discardableResult
        public func addTitleColor(color: ColorPalette) -> Self {
            self.titleColor = color
            return self
        }
        
        @discardableResult
        public func addLeftIcon(iconName: String) -> Self {
            self.leftIconName = iconName
            return self
        }
        
        @discardableResult
        public func addLeftIconColor(color: ColorPalette) -> Self {
            self.leftIconTint = color
            return self
        }
        
        @discardableResult
        public func addBackBtn() -> Self {
            self.leftIconName = "chevron-left"
            return self
        }
        
        @discardableResult
        public func addRightIcon(iconName: String) -> Self {
            self.rightIconName = iconName
            return self
        }
        
        @discardableResult
        public func addRightIconColor(color: ColorPalette) -> Self {
            self.leftIconTint = color
            return self
        }
    }
}

class GenericHeaderView: UIView {
    
    // MARK: - Outlets
    public let kCONTENT_XIB_NAME = "GenericHeaderView"
    public var contentView: UIView?
    @IBOutlet public weak var leftIcon: UIImageView!
    @IBOutlet public weak var rightIcon: UIImageView!
    @IBOutlet public weak var collapedTitle: UILabel!
    @IBOutlet public weak var expandTitle: UILabel!
    
    // MARK: - Vars
    private var configurations: GenericHeaderConfigurations?

    // MARK: - Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    public func setupView(configurations: GenericHeaderConfigurations) {
        self.configurations = configurations
    }
}

// MARK: - Configure UI Ext
extension GenericHeaderView {
    
    private func configureButtons() {
        
        // 1. set up right icon
        if let rightIconName = configurations?.rightIconName,
           let rightIconTint = configurations?.rightIconTint {
            rightIcon.isHidden = false
            rightIcon.image = UIImage(named: rightIconName)
            rightIcon.tintColor = rightIconTint.value

        } else {
            rightIcon.isHidden = true
        }
        
        // 2. set up left icon
        if let iconName = configurations?.rightIconName,
           let iconTint = configurations?.rightIconTint {
            leftIcon.isHidden = false
            leftIcon.image = UIImage(named: iconName)
            leftIcon.tintColor = iconTint.value

        } else {
            leftIcon.isHidden = true
        }
    }
    
    private func configureTitles() {
        
        guard let title = configurations?.title,
              let tintColor = configurations?.titleColor
        else {
            expandTitle.isHidden = true
            return
        }
        
        expandTitle.isHidden = false
        expandTitle.attributedText = title.with(.title1(
            weight: .BOLD,
            color: tintColor
        ))
    }
}
