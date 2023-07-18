//
//  PhotosManager.swift
//  Data
//
//  Created by thanos kottaridis on 15/7/23.
//

import Foundation
import Domain
import Alamofire
import AlamofireImage

public struct PhotosManagerImpl: PhotosManager {
    
    private var imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    public init() {}
    
    public func fetchImage(
        for url: String,
        completion: @escaping (Image) -> Void,
        errorCompletion: @escaping (Error) -> Void
    ) {        
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                errorCompletion(error)
            }
        }
    }
    
    public func cacheImage(image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    public func getCachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
    
    public func clearCachedImage(for url: String) {
        imageCache.removeImage(withIdentifier: url)
    }
}
