//
//  MovieDetailsVC.swift
//  Movies
//
//  Created by thanos kottaridis on 18/7/23.
//

import UIKit
import Presentation
import Combine

class MovieDetailsVC: BaseVC {

    // MARK: - Vars
    private(set) var viewModel: MovieDetailsViewModel

    private var anyCancelable = Set<AnyCancellable>()
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: String(describing: type(of: self)),
            bundle: Bundle(for: type(of: self))
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func populateData() {
        super.populateData()
        viewModel.onTriggeredEvent(event: .fetchData)
    }
    
    override func setupView() {
        super.setupView()
    }
    
    override func setUpObservers() {
    }
}
