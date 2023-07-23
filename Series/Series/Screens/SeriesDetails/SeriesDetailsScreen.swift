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
    
    // MARK: - Constraint Constants
    private enum ConstraintConstants {
        static let verticalItemSpacing = 20.adapted()
        
    }
    
    // MARK: - Vars
    @StateObject var viewModel: SeriesDetailsViewModel
    @State private var headerHeight: CGFloat = 0.0
    @State private var viewDidLoad: Bool = false
    
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
                VStack(spacing: ConstraintConstants.verticalItemSpacing) {
                    // 1. Add a Spacer as content Inset
                    // in order to achive Overlap visual Effect.
                    Spacer()
                        .frame(height: headerHeight)
                    
                    // 2. Add series Info
                    ShowInfoWrapperView(
                        configurations: ObservedObject(
                            wrappedValue: ShowInfoConfigurations(
                                showDetails: viewModel.state.details
                            )
                        )
                    )
                    
                    // 3. Add Overview List
                    ShowOverviewWrapperView(
                        configurations: ObservedObject(
                            wrappedValue: ShowOverviewConfigurations(
                                showDetails:  viewModel.state.details
                            )
                        )
                    )
                    
                    // 4. Add Seasons
                    if let seasons = viewModel.state.details.seasons {
                        SeriesSectionView(
                            section: SectionModel(
                                model: Str.seasonsTitle,
                                items: seasons
                            ),
                            isLargeCell: false,
                            onTapItem: { _ in }
                        )
                    }
                    
                
                    // 5. Add Production Companies
                    ProductionCompaniesWrapperView(
                        configurations: ObservedObject(
                            wrappedValue: ProductionCompaniesConfigurations(
                                showDetails:  viewModel.state.details
                            )
                        )
                    )
                }
            }
        }.onAppear {
            guard !viewDidLoad else { return }
            self.viewModel.onTriggeredEvent(event: .fetchData)
        }
    }
}

struct SeriesDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SeriesDetailsScreen(viewModel: SeriesDetailsViewModel(seriesId: 1, actionHandler: nil))
    }
}
