//
//  AppDelegate.swift
//  Thanflix
//
//  Created by thanos kottaridis on 2/7/23.
//

import UIKit
import Domain
import Data
import Presentation
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // This is the first method that we must call here!!!
        // set up modules
        initializeModules()
        // set up 3ed party dependencies
        initializeDependencies()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: - Initialize 3ed Party Dependencies
extension AppDelegate {
    private func initializeDependencies() {
        //enable alamofire logging
#if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
#endif
    }
}

// MARK: - Initialize Modules
extension AppDelegate {
    private func initializeModules() {
        DataBoundry(
            appConfig: AppConfig(),
            requestHeadersBuilder: RequestHeadersBuilderImpl()
        ).initialize()
        
        PresentationBoundary(
            errorDispatcher: BaseErrorDispatcherImpl(),
            moviesDataContext: MoviesDataContextImpl()
        ).initialize()
    }
}
