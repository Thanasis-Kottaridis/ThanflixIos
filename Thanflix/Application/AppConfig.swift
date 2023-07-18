//
//  AppConfig.swift
//  Thanflix
//
//  Created by thanos kottaridis on 5/7/23.
//

import Foundation
import Data

final class AppConfig: DataAppConfig {
        
    lazy var hasAlreadyRun: Bool = false
    
    lazy var appBundleID: String = {
        return path("CFBundleIdentifier")
    }()
    
    lazy var environmentName: String = {
        return getEnvironment("Environment", "Environment Name")
    }()
    
    lazy var appVersion: String = {
        let version = path("CFBundleShortVersionString")
        let buildNo = path("CFBundleVersion")
        return "\(version)(\(buildNo))"
    }()
    
    lazy var appAbsoluteVersion: String = {
        return path("CFBundleShortVersionString")
    }()
    
    lazy var appApiBaseUrl: String = {
        return path("Environment", "App Api Base URL")
    }()
    
    lazy var mediaApiBaseUrl: String = {
        return path("Environment", "Media Api Base URL")
    }()
    
    lazy var apiKey: String = {
        return "40bcc56bcbc19c6715ac1eec3580d78e"
    }()
    
    lazy var apiAccessToken: String = {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MGJjYzU2YmNiYzE5YzY3MTVhYzFlZWMzNTgwZDc4ZSIsInN1YiI6IjY0YTAzY2ZjOGMwYTQ4MDBjNzYzZDRiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6BM8aYSJ_L4CMAO-8zKlgfViqA4eWMYkilTY2FnRMjg"
    }()
    
    lazy var accountId: String = {
        return "20091904"
    }()
    
    

    private func path(_ keys: String...) -> String {
        var current = Bundle.main.infoDictionary
        for (index, key) in keys.enumerated() {
            if index == keys.count - 1 {
                guard let
                        result = (current?[key] as? String)?.replacingOccurrences(of: "\\", with: ""),
                      !result.isEmpty else {
                    assertionFailure(keys.joined(separator: " -> ").appending(" not found"))
                    return ""
                }
                return result
            }
            current = current?[key] as? [String: Any]
        }
        assertionFailure(keys.joined(separator: " -> ").appending(" not found"))
        return ""
    }
    
    private func getEnvironment(_ keys: String...) -> String {
        var current = Bundle.main.infoDictionary
        for (index, key) in keys.enumerated() {
            if index == keys.count - 1 {
                guard let result = (current?[key] as? String) else {
                    return Environments.DEV.rawValue
                }
                return result
            }
            current = current?[key] as? [String: Any]
        }
        return Environments.DEV.rawValue
    }
}
