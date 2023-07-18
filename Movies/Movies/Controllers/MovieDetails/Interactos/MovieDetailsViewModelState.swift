//
//  MovieDetailsViewModelState.swift
//  Movies
//
//  Created thanos kottaridis on 18/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import Foundation
import Domain
import Presentation

class MovieDetailsViewModelState: BaseState {
    
    // Set variables here
    let isLoading: Bool
    let isOnline: Bool
    let movieId: Int
    let details: ShowDetails
    
    init(
         isLoading: Bool = false,
         isOnline: Bool = true,
         movieId: Int = -1,
         details: ShowDetails = ShowDetails()
     ) {
         self.isLoading = isLoading
         self.isOnline = isOnline
         self.movieId = movieId
         self.details = details
     }
    
    func copy(
        isLoading: Bool? = nil,
        isOnline: Bool? = nil,
        movieId: Int? = nil,
        details: ShowDetails? = nil
    ) -> MovieDetailsViewModelState {
        return MovieDetailsViewModelState(
            isLoading: isLoading ?? self.isLoading,
            isOnline: isOnline ?? self.isOnline,
            movieId: movieId ?? self.movieId,
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
