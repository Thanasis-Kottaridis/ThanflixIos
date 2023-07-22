//
//  SeriesDetailsState.swift
//  Series
//
//  Created thanos kottaridis on 22/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import Foundation
import Domain
import Presentation

class SeriesDetailsState: BaseState {
    
    // Set variables here
    let isLoading: Bool
    let isOnline: Bool
    let seriesId: Int
    let details: ShowDetails
    
    init(
         isLoading: Bool = false,
         isOnline: Bool = true,
         seriesId: Int = -1,
         details: ShowDetails = ShowDetails()
     ) {
         self.isLoading = isLoading
         self.isOnline = isOnline
         self.seriesId = seriesId
         self.details = details
     }
    
    func copy(
        isLoading: Bool? = nil,
        isOnline: Bool? = nil,
        seriesId: Int? = nil,
        details: ShowDetails? = nil
    ) -> SeriesDetailsState {
        return SeriesDetailsState(
            isLoading: isLoading ?? self.isLoading,
            isOnline: isOnline ?? self.isOnline,
            seriesId: seriesId ?? self.seriesId,
            details: details ?? self.details
        )
    }
    
    func baseCopy(
        isLoading: Bool?,
        isOnline: Bool?
    ) -> Self {
        return self.copy(isLoading: isLoading, isOnline: isOnline ) as! Self
    }
}
