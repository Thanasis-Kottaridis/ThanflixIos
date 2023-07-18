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
    
    // MARK: - Inject DataModule AppConfig.
    private var mediaApiBaseUrl: String {
        @Injected(\.dataAppConfig)
        var appConfig: DataAppConfig
        return appConfig.mediaApiBaseUrl
    }
    
    private var imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    public init() {}
    
    private func constructImageUrl(_ mediaId: String, _ size: ImageSize ) -> String {
        return "\(mediaApiBaseUrl)/\(size)/\(mediaId)"
    }
    
    public func fetchImage(mediaId: String, size: ImageSize ) async -> Domain.Result<UIImage, Error> {
        
        // 1. construct url
        let url = constructImageUrl(mediaId, size)
        // 2. Check if image exists in cache
        if let image = getCachedImage(for: url) {
            return Result.Success(image)
        }
        
        // 3. Else fetch image from server
        return await withCheckedContinuation({ continuation in
            AF.request(url).responseImage { response in
                switch response.result {
                case .success(let image):
                    continuation.resume(returning: Result.Success(image))
                case .failure(let error):
                    continuation.resume(returning: .Failure(error))
                }
            }
        })
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
