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
    let leftIconAction: (() -> Void)?
    let rightIconName: String?
    let rightIconTint: ColorPalette?
    let rightIconAction: (() -> Void)?
    
    public init(
        title: String?,
        titleColor: ColorPalette?,
        leftIconName: String?,
        leftIconTint: ColorPalette?,
        leftIconAction: (() -> Void)?,
        rightIconName: String?,
        rightIconTint: ColorPalette?,
        rightIconAction: (() -> Void)?
    ) {
        self.title = title
        self.titleColor = titleColor
        self.leftIconName = leftIconName
        self.leftIconTint = leftIconTint
        self.leftIconAction = leftIconAction
        self.rightIconName = rightIconName
        self.rightIconTint = rightIconTint
        self.rightIconAction = rightIconAction
    }
    
    public class Builder {
        private var title: String?
        private var titleColor: ColorPalette? = .TintPrimary
        private var leftIconName: String?
        private var leftIconTint: ColorPalette? = .TintSecondary
        private var leftIconAction: (() -> Void)?
        private var rightIconName: String?
        private var rightIconTint: ColorPalette? = .TintSecondary
        private var rightIconAction: (() -> Void)?

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
        public func addLeftIconAction(action: @escaping () -> Void) -> Self {
            self.leftIconAction = action
            return self
        }
        
        @discardableResult
        public func addBackBtn(action: @escaping () -> Void) -> Self {
            self.leftIconName = "chevron-left"
            self.leftIconAction = action
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
        
        @discardableResult
        public func addRightIconAction(action: @escaping () -> Void) -> Self {
            self.rightIconAction = action
            return self
        }
        
        public func build() -> GenericHeaderConfigurations {
            GenericHeaderConfigurations(
                title: title,
                titleColor: titleColor,
                leftIconName: leftIconName,
                leftIconTint: leftIconTint,
                leftIconAction: leftIconAction,
                rightIconName: rightIconName,
                rightIconTint: rightIconTint,
                rightIconAction: rightIconAction
            )
        }
    }
}

public class GenericHeaderView: UIView {
    
    // MARK: - Const
    private enum ConstraintConstants {
        static let collapsedHeight = 44.adapted()
    }
    
    // MARK: - Outlets
    public let kCONTENT_XIB_NAME = "GenericHeaderView"
    public var contentView: UIView?
    @IBOutlet public weak var leftIcon: UIImageView!
    @IBOutlet public weak var rightIcon: UIImageView!
    @IBOutlet public weak var collapsingView: UIStackView!
    @IBOutlet public weak var collapedTitle: UILabel!
    @IBOutlet public weak var expandTitle: UILabel!
    
    ///# Constraint Outlets
    @IBOutlet weak var collapsableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var safeAreaMaskHeight: NSLayoutConstraint!
    
    // MARK: - Vars
    private weak var parentScrollView: UIScrollView?
    private let blurEffectView = UIVisualEffectView()
    private var configurations: GenericHeaderConfigurations?
    private var contentViewInitialHeight: CGFloat?
    
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
        let topSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.top
        safeAreaMaskHeight.constant = topSafeArea ?? 0
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
    
    public func setupView(
        configurations: GenericHeaderConfigurations,
        parentScrollView: UIScrollView? = nil
    ) {
        // 1. get configurations
        self.configurations = configurations
        
        // 2. set up parent scroll view if exists.
        self.parentScrollView = parentScrollView
//        self.parentScrollView?.contentInsetAdjustmentBehavior = .never

        // 3. set up UI
        configureButtons()
        configureTitles()
        setBlurEffect()
    }
}

// MARK: - Configure UI Ext
extension GenericHeaderView {
    
    private func configureButtons() {
        
        // 1. set up right icon
        if let iconName = configurations?.rightIconName,
           let iconTint = configurations?.rightIconTint,
           let action = configurations?.rightIconAction
        {
            rightIcon.isHidden = false
            rightIcon.image = UIImage(named: iconName)
            rightIcon.tintColor = iconTint.value
            rightIcon.addTapGestureRecognizer(action: action)
            
        } else {
            rightIcon.isHidden = true
        }
        
        // 2. set up left icon
        if let iconName = configurations?.leftIconName,
           let iconTint = configurations?.leftIconTint,
           let action = configurations?.leftIconAction{
            leftIcon.isHidden = false
            leftIcon.image = UIImage(named: iconName)
            leftIcon.tintColor = iconTint.value
            leftIcon.addTapGestureRecognizer(action: action)
            
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
            weight: .EXTRA_BOLD,
            color: tintColor
        ))
    }
    
    // MARK: Shape Of Tab Bar
    func setBlurEffect() {
        guard let contentView = self.contentView
        else { return }
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        let blurEffectView = UIVisualEffectView()
        blurEffectView.effect = UIBlurEffect(style: .light)
        blurEffectView.frame = contentView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //Add Blur To Tab Bar
        contentView.insertSubview(blurEffectView, at: 0)

    }
}

// MARK: - Animation Ext
extension GenericHeaderView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        let newHeight = (contentView?.frame.height ?? 0) // - safeAreaMaskHeight.constant
        print("Header debug.... height \(String(describing: contentView?.frame.height)), collapsing View height \(String(describing: newHeight))")
        
        guard newHeight != contentViewInitialHeight
        else { return }
        
            self.contentViewInitialHeight = newHeight
            let topInsets = self.contentViewInitialHeight! - (parentScrollView?.safeAreaInsets.top ?? 0)
            self.parentScrollView?.contentInset = UIEdgeInsets(
                top: topInsets,
                left: 0,
                bottom: 0,
                right: 0
            )
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.parentScrollView?.setContentOffset(
                CGPoint(x: 0, y: -self.contentViewInitialHeight!),
                animated: false
            )
        }
    }
    
    public func handleAnimation(newOffset: CGFloat) {
        
        // 1. Get helper vars for animation
        let y = (-newOffset) - (contentViewInitialHeight ?? 0)
        print("scroll debug... y = \(y), collapsingViewHeight = \(contentViewInitialHeight), newOffser = \(newOffset)")
    }
}
