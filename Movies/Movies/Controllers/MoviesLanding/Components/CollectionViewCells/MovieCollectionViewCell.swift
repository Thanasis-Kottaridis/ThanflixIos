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
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
    }
    
    func setUpCell(movie: Movie, indexPath: IndexPath) {
        
        contentView.backgroundColor = UIColor.random()
        
        titleLbl.attributedText = movie.title?.with(.body1(weight: .BOLD))
        titleLbl.numberOfLines = 0
    }
}
