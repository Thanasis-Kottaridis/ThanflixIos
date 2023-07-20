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

    // MARK: - Outlets
    @IBOutlet weak var header: GenericHeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieInfoView: MovieInfoView!
    @IBOutlet weak var movieOverviewView: MovieOverviewView!
    @IBOutlet weak var productionCompaniesView: ProductionCompaniesView!

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
        setUpHeader()
    }
    
    override func setUpObservers() {
        super.setUpObservers()
        viewModel.statePublisher
            .receive(on: DispatchQueue.main) // observe on main thread
            .map { $0.details }
            .removeDuplicates()
            .sink { [weak self] showDetails in
                self?.movieInfoView.setupView(showDetails: showDetails)
                self?.movieOverviewView.setupView(showDetails: showDetails)
                self?.productionCompaniesView.setupView(showDetails: showDetails)
            }
            .store(in: &anyCancelable)
    }
    
    private func setUpHeader() {
        // Set up header
        let headerConfigs = GenericHeaderConfigurations.Builder()
            .addBackBtn(action: { [weak self] in
                self?.viewModel.onTriggeredEvent(event: .goBack)
            })
            .build()
        
        header.setupView(
            configurations: headerConfigs,
            parentScrollView: scrollView
        )
    }
}
