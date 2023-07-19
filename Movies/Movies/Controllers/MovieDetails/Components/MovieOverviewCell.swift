//
//  MovieOverviewCell.swift
//  Movies
//
//  Created by thanos kottaridis on 19/7/23.
//

import UIKit
import Domain
import Presentation

class MovieOverviewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var readMoreLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    private let maxCharacters = 150

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
        descriptionLbl.text = ""
        separatorView.isHidden = true
    }

    func setUpCell(
        overview: Overview,
        indexPath: IndexPath
    ) {
       
        titleLbl.attributedText =  Languages.tr(overview.key).with(.body3(weight: .EXTRA_BOLD, color: .TintTertiary ))
        titleLbl.attributedText =  overview.value?.with(.body2(weight: .REGULAR, color: .TintSecondary ))

        // check if needed to show read more
        if let value = overview.value {
            readMoreLbl.isHidden = value.count > maxCharacters
            titleLbl.attributedText =  String(value.prefix(maxCharacters))
                .with(.body2(weight: .REGULAR, color: .TintSecondary ))
        }
    }
}
