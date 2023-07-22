//
//  SeriesDetailsScreen.swift
//  Series
//
//  Created by thanos kottaridis on 22/7/23.
//

import SwiftUI
import Domain
import Presentation

struct SeriesDetailsScreen: View {
    
    // MARK: - Vars
    @StateObject var viewModel: SeriesDetailsViewModel
    @State private var headerHeight: CGFloat = 0.0
    
    var body: some View {
        GenericHeaderOverlapWrapper(
            configurations: GenericHeaderConfigurations.Builder()
                .addBackBtn {
                    viewModel.onTriggeredEvent(event: .goBack)
                }
                .build(),
            headerHeight: $headerHeight
        ) {
            ScrollView {
                
            }
        }
    }
}

struct SeriesDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SeriesDetailsScreen(viewModel: SeriesDetailsViewModel(seriesId: 1, actionHandler: nil))
    }
}
