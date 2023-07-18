//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by thanos kottaridis on 12/7/23.
//

import UIKit
import Domain
import Presentation

class MovieCollectionViewCell: UICollectionViewCell {
    
    private enum ConstraintConstants {
        static let largelCornerRadius = 24.adapted()
        static let normalCornerRadius = 16.adapted()
    }
    
    // MARK: - DI
    @Injected(\.photosManager)
    private var photosManager: PhotosManager
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - Vars
    private var show: Show?
    private var indexPath: IndexPath?

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
        titleLbl.isHidden = true
        backgroundImage.image = nil
    }
    
    func setUpCell(
        show: Show,
        indexPath: IndexPath
    ) {
        let isLarge = indexPath.section == 0
        contentView.layer.cornerRadius = isLarge ? ConstraintConstants.largelCornerRadius : ConstraintConstants.normalCornerRadius
        contentView.clipsToBounds = true
//        contentView.backgroundColor = ColorPalette.FillPrimary.value
        titleLbl.isHidden = true
        
        fetchBackgroundImage(show)
    }
    
    private func fetchBackgroundImage(_ show: Show) {
        
        guard let mediaId = show.posterPath else {
            self.titleLbl.isHidden = false
            return
        }
        
        Task.init {
            let result = await photosManager.fetchImage(mediaId: mediaId, size:.w300)
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .Success(let image):
                    self?.titleLbl.isHidden = true
                    self?.backgroundImage.image = image

                case .Failure(_):
                    self?.titleLbl.isHidden = false
                }
            }
        }
    }
    
    private func setUpTitleLabel() {
        self.titleLbl.isHidden = false
        titleLbl.attributedText = show?.title?.with(.body1(weight: .BOLD))
        titleLbl.numberOfLines = 0
    }
}
