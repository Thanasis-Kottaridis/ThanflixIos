//
//  SeriesLandingState.swift
//  Series
//
//  Created thanos kottaridis on 22/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import Foundation
import Domain
import Presentation

class SeriesLandingState: BaseState {
    
    // Set variables here
    let isLoading: Bool
    let isOnline: Bool
    let todaySeries: [Show]
    let onTheAirSeries: [Show]
    let popularSeries: [Show]
    let topRatedSeries: [Show]
    
    var seriesDisplayable: [SectionModel<String, Show>] {
        
        var sections: [SectionModel<String, Show>] = []
        
        if !todaySeries.isEmpty {
            let section = SectionModel(model: Str.seriesLandingToday, items: todaySeries)
            sections.append(section)
        }
        
        if !onTheAirSeries.isEmpty {
            let section = SectionModel(model: Str.seriesLandingOnTheAir, items: onTheAirSeries)
            sections.append(section)
        }
        
        if !popularSeries.isEmpty {
            let section = SectionModel(model: Str.seriesLandingPopular, items: popularSeries)
            sections.append(section)
        }
        
        if !topRatedSeries.isEmpty {
            let section = SectionModel(model: Str.seriesLandingTopRated, items: topRatedSeries)
            sections.append(section)
        }
    
        return sections
    }
    
    init(
         isLoading: Bool = false,
         isOnline: Bool = true,
         todaySeries: [Show] = [],
         onTheAirSeries: [Show] = [],
         popularSeries: [Show] = [],
         topRatedSeries: [Show] = []
     ) {
         self.isLoading = isLoading
         self.isOnline = isOnline
         self.todaySeries = todaySeries
         self.onTheAirSeries = onTheAirSeries
         self.popularSeries = popularSeries
         self.topRatedSeries = topRatedSeries
     }
    
    func copy(
        isLoading: Bool? = nil,
        isOnline: Bool? = nil,
        todaySeries: [Show]? = nil,
        onTheAirSeries: [Show]? = nil,
        popularSeries: [Show]? = nil,
        topRatedSeries: [Show]? = nil
    ) -> SeriesLandingState {
        return SeriesLandingState(
            isLoading: isLoading ?? self.isLoading,
            isOnline: isOnline ?? self.isOnline,
            todaySeries: todaySeries ?? self.todaySeries,
            onTheAirSeries: onTheAirSeries ?? self.onTheAirSeries,
            popularSeries: popularSeries ?? self.popularSeries,
            topRatedSeries: topRatedSeries ?? self.topRatedSeries
        )
    }
    
    func baseCopy(
        isLoading: Bool?,
        isOnline: Bool?
    ) -> Self {
        return self.copy(isLoading: isLoading, isOnline: isOnline ) as! Self
    }
}
