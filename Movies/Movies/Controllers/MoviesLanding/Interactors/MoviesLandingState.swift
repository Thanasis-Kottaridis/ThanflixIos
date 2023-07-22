//
//  MoviesLandingState.swift
//  Movies
//
//  Created thanos kottaridis on 12/7/23.
//  Copyright © 2023 . All rights reserved.
//
//

import Foundation
import Domain
import Presentation

class MoviesLandingState: BaseState {
    
    // Set variables here
    let isLoading: Bool
    let isOnline: Bool
    let nowPlayingMovies: [Show]
    let popularMovies: [Show]
    let topRatedMovies: [Show]
    let upcomingMovies: [Show]
    
    var moviesDisplayable: [SectionModel<String, Show>] {
        
        var sections: [SectionModel<String, Show>] = []
        
        if !nowPlayingMovies.isEmpty {
            let section = SectionModel(model: Str.moviesLandingNowPlaying, items: nowPlayingMovies)
            sections.append(section)
        }
        
        if !popularMovies.isEmpty {
            let section = SectionModel(model: Str.moviesLandingMostPopular, items: popularMovies)
            sections.append(section)
        }
        
        if !topRatedMovies.isEmpty {
            let section = SectionModel(model: Str.moviesLandingTopRated, items: topRatedMovies)
            sections.append(section)
        }
        
        if !upcomingMovies.isEmpty {
            let section = SectionModel(model: Str.moviesLandingUpcoming, items: upcomingMovies)
            sections.append(section)
        }
        
        return sections
    }
    
    init(
         isLoading: Bool = false,
         isOnline: Bool = true,
         nowPlayingMovies: [Show] = [],
         popularMovies: [Show] = [],
         topRatedMovies: [Show] = [],
         upcomingMovies: [Show] = []
     ) {
         self.isLoading = isLoading
         self.isOnline = isOnline
         self.nowPlayingMovies = nowPlayingMovies
         self.popularMovies = popularMovies
         self.topRatedMovies = topRatedMovies
         self.upcomingMovies = upcomingMovies
     }
    
    func copy(
        isLoading: Bool? = nil,
        isOnline: Bool? = nil,
        nowPlayingMovies: [Show]? = nil,
        popularMovies: [Show]? = nil,
        topRatedMovies: [Show]? = nil,
        upcomingMovies: [Show]? = nil
    ) -> MoviesLandingState {
        return MoviesLandingState(
            isLoading: isLoading ?? self.isLoading,
            isOnline: isOnline ?? self.isOnline,
            nowPlayingMovies: nowPlayingMovies ?? self.nowPlayingMovies,
            popularMovies: popularMovies ?? self.popularMovies,
            topRatedMovies: topRatedMovies ?? self.topRatedMovies,
            upcomingMovies: upcomingMovies ?? self.upcomingMovies
        )
    }
    
    func baseCopy(
        isLoading: Bool?,
        isOnline: Bool?
    ) -> Self {
        return self.copy(isLoading: isLoading, isOnline: isOnline ) as! Self
    }
}
