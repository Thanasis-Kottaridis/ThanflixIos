//
//  PhotosManager.swift
//  Domain
//
//  Created by thanos kottaridis on 15/7/23.
//

import UIKit

public protocol PhotosManager {
    
    func fetchImage(mediaId: String, size: ImageSize ) async -> Result<UIImage, Error>
    func cacheImage(image: UIImage, for url: String)
    func getCachedImage(for url: String) -> UIImage?
    func clearCachedImage(for url: String)
}

// MARK: - Default Arguments
extension PhotosManager {
    public func fetchImage(mediaId: String, size: ImageSize = .original ) async -> Result<UIImage, Error> {
        await fetchImage(mediaId: mediaId, size: size)
    }
}

public class DefaultPhotosManager: PhotosManager {
    
    public init() {}
    
    public func cacheImage(image: UIImage, for url: String) {
        fatalError("Not Implemented Yet")
    }
    
    public func getCachedImage(for url: String) -> UIImage? {
        fatalError("Not Implemented Yet")
    }
    
    public func clearCachedImage(for url: String) {
        fatalError("Not Implemented Yet")

    }
}
