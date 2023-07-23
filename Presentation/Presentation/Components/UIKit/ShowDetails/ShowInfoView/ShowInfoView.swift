//
//  ShowInfoView.swift
//  Movies
//
//  Created by thanos kottaridis on 19/7/23.
//

import UIKit
import Domain

public class ShowInfoView: UIView {
    private enum ConstraintConstants {
        static let cornerRadius = 16.adapted()
    }
    
    // MARK: - Outlets
    public var contentView: UIView?
    /// # Poster
    @IBOutlet public weak var posterImageView: UIImageView!
    /// # Movie Info
    @IBOutlet public weak var movieInfoContainer: UIView!
    @IBOutlet public weak var titleLbl: UILabel!
    @IBOutlet public weak var releaseDateLbl: UILabel!
    @IBOutlet public weak var releaseInfoLbl: UILabel!
    /// # Watched Btn
    @IBOutlet public weak var watchedBtn: UIButton!
    /// # Details View
    @IBOutlet public weak var detailsContainer: UIView!
    /// # Vote Average
    @IBOutlet public weak var voteAverageContainer: UIView!
    @IBOutlet public weak var voteAverageLbl: UILabel!
    @IBOutlet public weak var voteAverageTitleLbl: UILabel!
    /// # Vote Count
    @IBOutlet public weak var voteCountContainer: UIView!
    @IBOutlet public weak var voteCountLbl: UILabel!
    @IBOutlet public weak var voteCountTitleLbl: UILabel!
    /// # popularity
    @IBOutlet public weak var popularityContainer: UIView!
    @IBOutlet public weak var popularityLbl: UILabel!
    @IBOutlet public weak var popularityTitleLbl: UILabel!

    
    // MARK: - Vars
    public let kCONTENT_XIB_NAME = "ShowInfoView"
    private var showDetails: ShowDetails?

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
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
        [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
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
        showDetails: ShowDetails
    ) {
        self.showDetails = showDetails
        posterImageView.layer.cornerRadius = ConstraintConstants.cornerRadius
        setUpInfoView(showDetails)
        setUpButton()
        fetchBackgroundImage(showDetails.posterPath)
        setUpDetailsView(showDetails)
    }
    
    private func setUpInfoView(_ showDetails: ShowDetails) {
        titleLbl.attributedText = showDetails.title?.with(.title2(weight: .EXTRA_BOLD, color: .TintPrimary))
        releaseDateLbl.attributedText = showDetails.releaseDate?.with(.title2(weight: .EXTRA_BOLD, color: .TintTertiary))
        releaseInfoLbl.attributedText = Str.releaseDateInfo.with(.body2(weight: .EXTRA_BOLD, color: .TintTertiary))
        
        contentView?.setNeedsLayout()
        contentView?.layoutIfNeeded()
    }
    
    private func setUpButton() {
        watchedBtn.backgroundColor = ColorPalette.BrandPrimary.value
        watchedBtn.layer.cornerRadius = ConstraintConstants.cornerRadius
        watchedBtn.setAttributedTitle(
            Str.watchedButtonTitle.with(.body2(weight: .EXTRA_BOLD, color: .TintWhite)),
            for: .normal
        )
    }
    
    private func setUpDetailsView(_ showDetails: ShowDetails) {
        // set up vote average
        voteAverageLbl.attributedText = "\(showDetails.voteAverage ?? 0)".with(.body2(weight: .EXTRA_BOLD, color: .TintSecondary))
        voteAverageTitleLbl.attributedText = Str.voteAverageTitle.with(.body2(weight: .EXTRA_BOLD, color: .TintTertiary))
        
        // set up vote count
        voteCountLbl.attributedText = "\(showDetails.voteCount ?? 0)".with(.body2(weight: .EXTRA_BOLD, color: .TintSecondary))
        voteCountTitleLbl.attributedText = Str.voteCountTitle.with(.body2(weight: .EXTRA_BOLD, color: .TintTertiary))
        
        // set up popularity
        popularityLbl.attributedText = "\(showDetails.popularity ?? 0)".with(.body2(weight: .EXTRA_BOLD, color: .TintSecondary))
        popularityTitleLbl.attributedText = Str.popularityTitle.with(.body2(weight: .EXTRA_BOLD, color: .TintTertiary))
    }
    
    private func fetchBackgroundImage(_ mediaId: String?) {
        
        guard let mediaId = mediaId else {
            self.titleLbl.isHidden = false
            return
        }
        
        Task.init {
            let result = await photosManager.fetchImage(mediaId: mediaId, size:.w300)
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .Success(let image):
                    self?.posterImageView.image = image
                case .Failure(_):
                    break
                }
            }
        }
    }
}
