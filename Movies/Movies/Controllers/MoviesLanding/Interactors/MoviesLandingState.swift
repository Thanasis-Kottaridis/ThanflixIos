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
    let nowPlayingMovies: [Movie]
    let popularMovies: [Movie]
    let topRatedMovies: [Movie]
    let upcomingMovies: [Movie]
    
    var moviesDisplayable: [SectionModel<String, Movie>] {
        
        var sections: [SectionModel<String, Movie>] = []
        
        if !nowPlayingMovies.isEmpty {
            let section = SectionModel(model: "Now Playing", items: popularMovies)
            sections.append(section)
        }
        
        if !popularMovies.isEmpty {
            let section = SectionModel(model: "Most Popular", items: popularMovies)
            sections.append(section)
        }
        
        if !topRatedMovies.isEmpty {
            let section = SectionModel(model: "Top Rated", items: topRatedMovies)
            sections.append(section)
        }
        
        if !upcomingMovies.isEmpty {
            let section = SectionModel(model: "Upcoming", items: upcomingMovies)
            sections.append(section)
        }
        
        return sections
    }
    
    init(
         isLoading: Bool = false,
         isOnline: Bool = true,
         nowPlayingMovies: [Movie] = [],
         popularMovies: [Movie] = [],
         topRatedMovies: [Movie] = [],
         upcomingMovies: [Movie] = []
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
        nowPlayingMovies: [Movie]? = nil,
        popularMovies: [Movie]? = nil,
        topRatedMovies: [Movie]? = nil,
        upcomingMovies: [Movie]? = nil
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
