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
    let topRatedSeries: [Show]
    let upcomingSeries: [Show]
    
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
        
        if !topRatedSeries.isEmpty {
            let section = SectionModel(model: Str.seriesLandingTopRated, items: topRatedSeries)
            sections.append(section)
        }
        
        if !upcomingSeries.isEmpty {
            let section = SectionModel(model: Str.seriesLandingUpcoming, items: upcomingSeries)
            sections.append(section)
        }
        
        return sections
    }
    
    init(
         isLoading: Bool = false,
         isOnline: Bool = true,
         todaySeries: [Show] = [],
         onTheAirSeries: [Show] = [],
         topRatedSeries: [Show] = [],
         upcomingSeries: [Show] = []
     ) {
         self.isLoading = isLoading
         self.isOnline = isOnline
         self.todaySeries = todaySeries
         self.onTheAirSeries = onTheAirSeries
         self.topRatedSeries = topRatedSeries
         self.upcomingSeries = upcomingSeries
     }
    
    func copy(
        isLoading: Bool? = nil,
        isOnline: Bool? = nil,
        todaySeries: [Show]? = nil,
        onTheAirSeries: [Show]? = nil,
        topRatedSeries: [Show]? = nil,
        upcomingSeries: [Show]? = nil
    ) -> SeriesLandingState {
        return SeriesLandingState(
            isLoading: isLoading ?? self.isLoading,
            isOnline: isOnline ?? self.isOnline,
            todaySeries: todaySeries ?? self.todaySeries,
            onTheAirSeries: onTheAirSeries ?? self.onTheAirSeries,
            topRatedSeries: topRatedSeries ?? self.topRatedSeries,
            upcomingSeries: upcomingSeries ?? self.upcomingSeries
        )
    }
    
    func baseCopy(
        isLoading: Bool?,
        isOnline: Bool?
    ) -> Self {
        return self.copy(isLoading: isLoading, isOnline: isOnline ) as! Self
    }
}
