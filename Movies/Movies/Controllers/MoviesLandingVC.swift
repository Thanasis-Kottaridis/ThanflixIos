//
//  MoviesLandingVC.swift
//  Movies
//
//  Created by thanos kottaridis on 11/7/23.
//

import UIKit
import Presentation

class MoviesLandingVC: BaseVC {

    init() {
        super.init(
            nibName: String(describing: type(of: self)),
            bundle: Bundle(for: type(of: self)),
            hideTabBar: false
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
    }
    
    override func setUpObservers() {
    }
}
