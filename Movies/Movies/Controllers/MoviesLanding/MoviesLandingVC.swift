//
//  MoviesLandingVC.swift
//  Movies
//
//  Created by thanos kottaridis on 11/7/23.
//

import UIKit
import Presentation
import Combine

class MoviesLandingVC: BaseVC {
    
    private enum CellIdentifiers {
        static let movieCell = "MovieCollectionViewCell"
    }

    // MARK: - Outlets
    @IBOutlet weak var header: GenericHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Vars
    private(set) var viewModel: MoviesLandingViewModel
    private var anyCancelable = Set<AnyCancellable>()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()


    init(viewModel: MoviesLandingViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: String(describing: type(of: self)),
            bundle: Bundle(for: type(of: self)),
            hideTabBar: false
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
        
        setCollectionView()
        
        // Set up header
        let headerConfigs = GenericHeaderConfigurations.Builder()
            .addTitle(title: "Movies")
            .addLeftIcon(iconName: "kebab-menu")
            .addRightIcon(iconName: "magnifyingglass")
            .build()
        
        header.setupView(
            configurations: headerConfigs,
            parentScrollView: collectionView
        )
        
    }
    
    override func setUpObservers() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main) // observe on main thread
            .map { $0.moviesDisplayable }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &anyCancelable)
    }
    
    private func setCollectionView() {
        // 1. set up delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 2. register cell
        let movieCell = UINib(
            nibName: CellIdentifiers.movieCell,
            bundle: Bundle(for: MovieCollectionViewCell.self)
        )
        collectionView.register(
            movieCell,
            forCellWithReuseIdentifier: CellIdentifiers.movieCell
        )
        
        // 3. set up flow layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.collectionViewLayout = layout
    }
    
}

// MARK: - UICollectionViewDataSource
extension MoviesLandingVC: UICollectionViewDataSource, UICollectionViewDelegate {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.state.moviesDisplayable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = viewModel.state.moviesDisplayable
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellIdentifiers.movieCell, for: indexPath
        ) as? MovieCollectionViewCell
        else {
             return UICollectionViewCell()
        }
        
        let sections = viewModel.state.moviesDisplayable
        let movie = sections[indexPath.section].items[indexPath.item]
        cell.setUpCell(movie: movie, indexPath: indexPath)
        
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.handleAnimation(newOffset: scrollView.contentOffset.y)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesLandingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
