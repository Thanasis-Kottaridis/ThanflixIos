//
//  ProductionCompaniesView.swift
//  Movies
//
//  Created by thanos kottaridis on 20/7/23.
//

import UIKit
import Domain

public class ProductionCompaniesView: UIView {
    
    private enum CellIdentifiers {
        static let companyCell = "ProductionCompanyCell"
    }
    
    // MARK: - Outlets
    public var contentView: UIView?
    @IBOutlet public weak var titleLbl: UILabel!
    @IBOutlet public weak var collectionView: UICollectionView!
    
    // MARK: - Vars
    public let kCONTENT_XIB_NAME = "ProductionCompaniesView"
    private var showDetails: ShowDetails?
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12.adapted()
        layout.minimumLineSpacing = 12.adapted()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20.adapted(), left: 20.adapted(), bottom: 5.adapted(), right: 5.adapted())
        return layout
    }()
    
    // MARK: - Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        xibSetup()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
        [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    public func setupView(showDetails: ShowDetails) {
        self.showDetails = showDetails
        
        titleLbl.attributedText = Str.productionCompaniesTitle.with(.title3(weight: .EXTRA_BOLD, color: .TintSecondary))
        setCollectionView()
        collectionView.reloadData()
    }
    
    private func setCollectionView() {
        // 1. set up delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 2. register cell
        let cell = UINib(
            nibName: CellIdentifiers.companyCell,
            bundle: Bundle(for: ProductionCompanyCell.self)
        )
        collectionView.register(
            cell,
            forCellWithReuseIdentifier: CellIdentifiers.companyCell
        )
        
        collectionView.collectionViewLayout = flowLayout
    }
}

// MARK: - UICollectionViewDataSource
extension ProductionCompaniesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.adapted(), height: 90.adapted())
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showDetails?.productionCompanies?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellIdentifiers.companyCell, for: indexPath
        ) as? ProductionCompanyCell,
              let company = showDetails?.productionCompanies?[safe: indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        
        cell.setUpCell(
            company: company,
            indexPath: indexPath
        )
        
        return cell
    }
}

