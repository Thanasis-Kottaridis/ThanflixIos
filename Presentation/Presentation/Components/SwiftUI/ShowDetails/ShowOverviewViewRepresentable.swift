//
//  ShowOverviewViewRepresentable.swift
//  Presentation
//
//  Created by thanos kottaridis on 23/7/23.
//

import SwiftUI
import Domain

public class ShowOverviewConfigurations: ObservableObject {
    
    public let showDetails: ShowDetails
    
    public init(showDetails: ShowDetails) {
        self.showDetails = showDetails
    }
}

public struct ShowOverviewWrapperView: View {
    
    @ObservedObject private var configurations: ShowOverviewConfigurations
    @State private var headerHeight: CGFloat = 0.0
    
    public init(configurations: ObservedObject<ShowOverviewConfigurations>) {
        _configurations = configurations
    }
    
    public var body: some View {
        VStack {
            ShowOverviewViewRepresentable(
                height: $headerHeight,
                showDetails: configurations.showDetails
            )
        }.frame(height: headerHeight)
    }
}

internal struct ShowOverviewViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = ShowOverviewView
    
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
        let customView = ShowOverviewView()
        customView.setupView(showDetails: showDetails)
        return customView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update any properties or perform additional configuration if needed
        uiView.setupView(showDetails: showDetails)

        DispatchQueue.main.async {
            let fittingSize = CGSize(width: uiView.frame.width, height: UIView.layoutFittingCompressedSize.height)
            let size = uiView.systemLayoutSizeFitting(fittingSize)
            height = size.height + 1
        }
    }
}
