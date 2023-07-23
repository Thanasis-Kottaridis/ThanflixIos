//
//  ProductionCompaniesViewRepresentable.swift
//  Presentation
//
//  Created by thanos kottaridis on 23/7/23.
//

import SwiftUI
import Domain

public struct ProductionCompaniesWrapperView: View {
    
    private let showDetails: ShowDetails
    @State private var headerHeight: CGFloat = 0.0
    
    public init(showDetails: ShowDetails) {
        self.showDetails = showDetails
    }
    
    public var body: some View {
        VStack {
            ProductionCompaniesViewRepresentable(
                height: $headerHeight,
                showDetails: showDetails
            )
        }.frame(height: headerHeight)
    }
}

internal struct ProductionCompaniesViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = ProductionCompaniesView
    
    //MARK: - VARS
    @Binding private var height: CGFloat
    private let showDetails: ShowDetails

    public init(
        height: Binding<CGFloat>,
        showDetails: ShowDetails
    ) {
        _height = height
        self.showDetails = showDetails
    }
    
    func makeUIView(context: Context) -> UIViewType {
        let customView = ProductionCompaniesView()
        customView.setupView(showDetails: showDetails)

        DispatchQueue.main.async {
            let fittingSize = CGSize(width: customView.frame.width, height: UIView.layoutFittingCompressedSize.height)
            let size = customView.systemLayoutSizeFitting(fittingSize)
            height = size.height + 1
        }

        return customView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update any properties or perform additional configuration if needed
    }
}

