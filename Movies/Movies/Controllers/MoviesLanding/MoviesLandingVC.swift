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
        static let sectionHeader = "MovieCollectionViewSectionHeader"
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
        
        // 3. register section header view
        let sectionHeader = UINib(
            nibName: CellIdentifiers.sectionHeader,
            bundle: Bundle(for: MovieCollectionViewSectionHeader.self)
        )
        collectionView.register(
            sectionHeader,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CellIdentifiers.sectionHeader
        )

        // 4. set up compositional layout.
        setUpCompositionalLayout()
    }
    
    private func setUpCompositionalLayout() {
        // 1.
        // Set up item Size (Width, Height)
        // **Note** group dimantion is relevant to its parent (group)
        // so we want our item to has equal height with its parent group
        // and 1/3 of it's width
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1)
        )
        
        // 2. Create item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 2.1 Add item conten insets
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 6.adapted(),
            leading: 6.adapted(),
            bottom: 6.adapted(),
            trailing: 6.adapted()
        )
        
        // 3.
        // Set up group dimantions (Width, Height)
        // **Note** group dimantion is relevant to its parent (group or section)
        // in our case we want our group has equal width with our setion
        // and height 1/3 of its width.
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/3)
        )
        
        // 4. Create group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // 5. create the section that contains this group
        let section = NSCollectionLayoutSection(group: group)
        
        // 5.1 Add section conten insets
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 4.adapted(),
            leading: 14.adapted(),
            bottom: 4.adapted(),
            trailing: 14.adapted()
        )
        
        // 5.2 make section scrollable
        section.orthogonalScrollingBehavior = .continuous
        
        // 6. Create section header view
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(10.adapted())
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [headerItem]
        
        // 7. create the compositional layout contains that sections.
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        // 8. set up collection view layout
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CellIdentifiers.sectionHeader,
            for: indexPath
        ) as? MovieCollectionViewSectionHeader
        else {
                return MovieCollectionViewSectionHeader()
            }
            
        let title = viewModel.state.moviesDisplayable[indexPath.section].model
        if indexPath.section == 0 {
            headerView.setUpView(
                title: title,
                textStyle: .title1(weight: .EXTRA_BOLD, color: .TintSecondary)
            )
        } else {
            headerView.setUpView(title: title)
        }
        return headerView
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.handleAnimation(newOffset: scrollView.contentOffset.y)
    }
}
