//
//  MovieCollectionViewSectionHeader.swift
//  Movies
//
//  Created by thanos kottaridis on 13/7/23.
//

import UIKit
import Presentation

class MovieCollectionViewSectionHeader: UICollectionReusableView {
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
    }
    
    func setUpView(
        title: String,
        textStyle: TextStyle.Style = .title3(weight: .EXTRA_BOLD, color: .TintSecondary)
    ) {
        
        self.backgroundColor = UIColor.clear
        
        titleLbl.attributedText = title.with(textStyle)
        titleLbl.numberOfLines = 0
    }}
