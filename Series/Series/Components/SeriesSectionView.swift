//
//  SeriesSectionView.swift
//  Series
//
//  Created by thanos kottaridis on 22/7/23.
//

import SwiftUI
import Domain
import Presentation

struct SeriesSectionView: View {
    
    // MARK: - Constraint Constants
    private enum ConstraintConstants {
        static let horizontalPadding = 20.adapted()
        static let headerVerticalPadding = 4.adapted()
        static let caruselVerticalPadding = 6.adapted()

        static let listItemSpacing = 12.adapted()
        static let largeCellsWidth = 244.adapted()
        static let largeCellsHeght = 380.adapted()
        static let normalCellsWidth = 138.adapted()
        static let normalCellsHeight = 221.adapted()
        
        static func getCellsHeght(isLarge: Bool) -> CGFloat {
            return isLarge ? largeCellsHeght : normalCellsHeight
        }
        
        static func getCellsWidth(isLarge: Bool) -> CGFloat {
            return isLarge ? largeCellsWidth : normalCellsWidth
        }
    }
    
    // MARK: - Vars
    var section: SectionModel<String, Show>
    var isLargeCell: Bool
    var onTapItem: (Int) -> Void
    
    private var titleStyle: TextStyle.Style {
        return isLargeCell ? .title1(weight: .EXTRA_BOLD, color: .TintSecondary) : .title3(weight: .EXTRA_BOLD, color: .TintSecondary)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(section.model)
                .modifier(CustomTextStyle(style: titleStyle))
                .padding(.horizontal, ConstraintConstants.horizontalPadding)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ConstraintConstants.listItemSpacing) {
                    ForEach(section.items, id: \.id) { show in
                        SeriesItemView(
                            show: show,
                            isLargeCell: isLargeCell
                        )
                        .frame(
                            width: ConstraintConstants.getCellsWidth(isLarge: isLargeCell),
                            height: ConstraintConstants.getCellsHeght(isLarge: isLargeCell)
                        )
                        .onTapGesture {
                            onTapItem(show.id ?? -1)
                        }
                    }
                }
                .padding(.horizontal, ConstraintConstants.horizontalPadding)
                .padding(.vertical, ConstraintConstants.caruselVerticalPadding)
            }
        }
    }
}

struct SeriesSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSectionView(
            section: SectionModel<String, Show>(model: "test", items: []),
            isLargeCell: true,
            onTapItem: { _ in }
        )
    }
}
