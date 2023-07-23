//
//  GenericHeaderViewRepresentable.swift
//  Presentation
//
//  Created by thanos kottaridis on 21/7/23.
//

import SwiftUI

/**
    # GenericHeaderViewRepresentable
    This view representable is used in order to make Generic Header View component swiftUI compatible
    **Important Note:** All UIKit components that take dynamicly hight using UIStackViews for example
    they need to add a height binding in order to provide their heigh after view initialization to swift UI Parent view.
 */
public struct GenericHeaderWrapperView: View {
    
    private let configurations: GenericHeaderConfigurations
    @State private var headerHeight: CGFloat = 0.0
    
    public init(configurations: GenericHeaderConfigurations) {
        self.configurations = configurations
    }
    
    public var body: some View {
        VStack {
            GenericHeaderViewRepresentable(
                height: $headerHeight,
                configurations: configurations
            )
        }.frame(height: headerHeight)
    }
}

/**
    # GenericHeaderViewRepresentable
    This view representable is used in order to make Generic Header View component swiftUI compatible
    **Important Note:** All UIKit components that take dynamicly hight using UIStackViews for example
    they need to add a height binding in order to provide their heigh after view initialization to swift UI Parent view.
 */
internal struct GenericHeaderViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = GenericHeaderView
    
    //MARK: - VARS
    @Binding private var height: CGFloat
    private let configurations: GenericHeaderConfigurations

    public init(
        height: Binding<CGFloat>,
        configurations: GenericHeaderConfigurations
    ) {
        _height = height
        self.configurations = configurations
    }
    
    func makeUIView(context: Context) -> UIViewType {
        let customView = GenericHeaderView()
        return customView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update any properties or perform additional configuration if needed
        uiView.setupView(configurations: configurations)

        DispatchQueue.main.async {
            let fittingSize = CGSize(width: uiView.frame.width, height: UIView.layoutFittingCompressedSize.height)
            let size = uiView.systemLayoutSizeFitting(fittingSize)
            height = size.height + 1
        }

    }
}
