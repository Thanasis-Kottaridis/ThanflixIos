//
//  MovieOverviewView.swift
//  Movies
//
//  Created by thanos kottaridis on 20/7/23.
//

import UIKit
import Domain
import Presentation

class MovieOverviewView: UIView {
    
    private enum ConstraintConstants {
        static let cornerRadius = 16.adapted()
    }
    
    // MARK: - Outlets
    public var contentView: UIView?
    @IBOutlet public weak var titleLbl: UILabel!
    @IBOutlet public weak var contentStackView: UIStackView!

    // MARK: - Vars
    public let kCONTENT_XIB_NAME = "MovieOverviewView"
    private var showDetails: ShowDetails?
    
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
    
    public func setupView(showDetails: ShowDetails) {
        
        titleLbl.attributedText = Str.overviewTitle.with(.title3(weight: .EXTRA_BOLD, color: .TintSecondary))
        
        guard let overviewList = showDetails.overview
        else { return }
        setUpStackView(overviewList: overviewList)
    }
    
    private func setUpStackView(overviewList: [Overview]) {
        contentStackView.layer.cornerRadius = ConstraintConstants.cornerRadius
        contentStackView.backgroundColor = ColorPalette.BackgroundDefaultPrimary.value
        
        for (index, overview) in overviewList.enumerated() {
            let view = MovieOverviewItemView(frame: .zero)
            view.setUpView(overview: overview)
            view.separatorView.isHidden = index == overviewList.count - 1
            contentStackView.addArrangedSubview(view)
        }
    }
}
