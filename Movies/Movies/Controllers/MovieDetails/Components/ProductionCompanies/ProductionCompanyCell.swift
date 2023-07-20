//
//  ProductionCompanyCell.swift
//  Movies
//
//  Created by thanos kottaridis on 20/7/23.
//

import UIKit
import Domain
import Presentation

class ProductionCompanyCell: UICollectionViewCell {

    private enum ConstraintConstants {
        static let normalCornerRadius = 16.adapted()
    }
    
    // MARK: - DI
    @Injected(\.photosManager)
    private var photosManager: PhotosManager
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - Vars
    private var company: ProductionCompany?
    private var indexPath: IndexPath?

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
        titleLbl.isHidden = true
        backgroundImage.image = nil
    }
    
    func setUpCell(
        company: ProductionCompany,
        indexPath: IndexPath
    ) {
        self.company = company
        
        contentView.layer.cornerRadius = ConstraintConstants.normalCornerRadius
        contentView.clipsToBounds = true
        contentView.backgroundColor = ColorPalette.BackgroundDefaultPrimary.value
        titleLbl.isHidden = true
        
        fetchBackgroundImage(company)
    }
    
    private func fetchBackgroundImage(_ company: ProductionCompany) {
        
        guard let mediaId = company.logoPath else {
            self.setUpTitleLabel()
            return
        }
        
        Task.init {
            let result = await photosManager.fetchImage(mediaId: mediaId, size:.w154)
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .Success(let image):
                    self?.titleLbl.isHidden = true
                    self?.backgroundImage.image = image

                case .Failure(_):
                    self?.setUpTitleLabel()
                }
            }
        }
    }
    
    private func setUpTitleLabel() {
        self.titleLbl.isHidden = false
        titleLbl.attributedText = company?.name?.with(.body1(weight: .BOLD, color: .TintPrimary))
        titleLbl.numberOfLines = 0
    }
}
