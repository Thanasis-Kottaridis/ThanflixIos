//
//  SeriesLandingScreen.swift
//  Series
//
//  Created by thanos kottaridis on 21/7/23.
//

import SwiftUI
import Domain
import Presentation

struct SeriesLandingScreen: View {
    
    // MARK: - Vars
    @StateObject var viewModel: SeriesLandingViewModel
    @State private var headerHeight: CGFloat = 0.0
    @State private var viewDidLoad: Bool = false
    
    var body: some View {
        GenericHeaderOverlapWrapper(
            configurations: GenericHeaderConfigurations.Builder()
                .addTitle(title: Str.seriesLandingTitle)
                .addLeftIcon(iconName: "kebab-menu")
                .addLeftIconAction(action: {
                    // TODO: - ADD ACTION
                })
                .addRightIcon(iconName: "magnifyingglass")
                .addRightIconAction(action: {
                    // TODO: - ADD ACTION
                })
                .build(),
            headerHeight: $headerHeight
        ) {
            List {
                // 1. Add a Spacer as content Inset
                // in order to achive Overlap visual Effect.
                Spacer()
                    .listRowInsets(EdgeInsets())
                    .frame(height: headerHeight)
                ForEach(
                    Array(viewModel.state.seriesDisplayable.enumerated()),
                    id: \.element.model
                ) { index, section in
                    SeriesSectionView(
                        section: section,
                        isLargeCell: index == 0,
                        onTapItem: { id in
                            print("Item Tapped")
                        }
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden, edges: .all)
                }
            }
            .listStyle(.plain)
        }.onAppear {
            guard !viewDidLoad else { return }
            UITableView.appearance().showsVerticalScrollIndicator = false
            self.viewDidLoad = true
            self.viewModel.onTriggeredEvent(event: .fetchData)
        }
    }
}

struct SeriesLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SeriesLandingScreen(
            viewModel: SeriesLandingViewModel(actionHandler: nil)
        )
    }
}
