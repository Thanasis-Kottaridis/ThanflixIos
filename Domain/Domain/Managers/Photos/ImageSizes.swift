//
//  ImageSizes.swift
//  Domain
//
//  Created by thanos kottaridis on 15/7/23.
//

import Foundation

public enum ImageSize: String, SafeEnumType {
    public static var defaultCase: ImageSize = .original
    
    case w45
    case w92
    case w154
    case w185
    case w300
    case w342
    case w500
    case h632
    case w780
    case w1280
    case original
}
