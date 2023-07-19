//
//  MovieOverviewCell.swift
//  Movies
//
//  Created by thanos kottaridis on 19/7/23.
//

import UIKit
import Domain
import Presentation

class MovieOverviewItemView: UIView {

    // MARK: - Outlets
    public var contentView: UIView?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var readMoreLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!
   

    // MARK: - Vars
    public let kCONTENT_XIB_NAME = "MovieOverviewItemView"
    private var overview: Overview?
    private let maxCharacters = 150

    // MARK: - DI
    @Injected(\.photosManager)
    private var photosManager: PhotosManager
    
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

    func setUpView(overview: Overview) {
       
        titleLbl.attributedText =  Languages.tr(overview.key).with(.body3(weight: .EXTRA_BOLD, color: .TintTertiary ))
        separatorView.backgroundColor = ColorPalette.SeperatorPrimary.value

        // check if needed to show read more
        if let value = overview.value {
            readMoreLbl.isHidden = value.count < maxCharacters
            readMoreLbl.attributedText = Str.readMoreTitle.with(
                style: .body2(weight: .REGULAR, color: .TintSecondary),
                attributes: [
                    StringAttribute(
                        underlineText: [Str.readMoreTitle],
                        underlineStyle: .body2(weight: .REGULAR, color: .TintSecondary),
                        aStyle: .underline
                    )
                ]
            )
            descriptionLbl.numberOfLines = 3
            descriptionLbl.attributedText =  String(value.prefix(maxCharacters))
                .with(.body2(weight: .REGULAR, color: .TintSecondary ))
        }
    }
}
