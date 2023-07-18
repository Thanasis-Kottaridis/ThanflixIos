//
//  InjectManagers.swift
//  Presentation
//
//  Created by thanos kottaridis on 9/5/23.
//

import Foundation
import Domain

private struct ApplicationStateManagerProvider: InjectionKey {
    static var currentValue: ApplicationStateManager = ApplicationStateManagerImpl()
}

private struct PhotosManagerProvider: InjectionKey {
    static var currentValue: PhotosManager = DefaultPhotosManager()
}

extension InjectedValues {
    
    public var applicationStateManager: ApplicationStateManager {
        get { Self[ApplicationStateManagerProvider.self] }
        set { Self[ApplicationStateManagerProvider.self] = newValue }
    }
    
    public var photosManager: PhotosManager {
        get { Self[PhotosManagerProvider.self] }
        set { Self[PhotosManagerProvider.self] = newValue }
    }
}
