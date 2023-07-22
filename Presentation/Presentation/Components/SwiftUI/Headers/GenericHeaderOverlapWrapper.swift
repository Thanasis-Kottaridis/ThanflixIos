//
//  GenericHeaderOverlapWrapper.swift
//  Presentation
//
//  Created by thanos kottaridis on 22/7/23.
//

import Foundation
import SwiftUI

public struct GenericHeaderOverlapWrapper <Content: View>: View {
    
    // MARK: - VARS
    private let configurations: GenericHeaderConfigurations
    @Binding private var headerHeight: CGFloat
    public var content: () -> Content

    public init(
        configurations: GenericHeaderConfigurations,
        headerHeight: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.configurations = configurations
        _headerHeight = headerHeight
        self.content = content
    }
    
    public var body: some View {
        
        // 1. Add a Z stack to achive overlap between header and content
        ZStack {
            // 2. Add Content VStack
            VStack {
                // 3. Add Content
                content()
            }
            // 4. Add header view on top of other content.
            VStack {
                VStack {
                    GenericHeaderViewRepresentable(
                        height: $headerHeight,
                        configurations: configurations
                    )
                }
                .frame(height: headerHeight)                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

