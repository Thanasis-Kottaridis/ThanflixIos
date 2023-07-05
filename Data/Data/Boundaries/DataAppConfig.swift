//
//  DataAppConfig.swift
//  Data
//
//  Created by thanos kottaridis on 2/2/23.
//

import Foundation

public protocol DataAppConfig {
    var appApiBaseUrl: String { get }
    var apiKey: String { get }
    var environmentName: String { get }
    var apiAccessToken: String { get }
    var appAbsoluteVersion: String { get }
    var appBundleID: String { get }
}

public class DefaultDataAppConfig: DataAppConfig {
    
    public init() {}
    
    public var appApiBaseUrl: String {
        return "not yet implemented"
    }
    
    public var apiKey: String {
        return "not yet implemented"
    }
    
    public var environmentName: String {
        return "not yet implemented"
    }
    
    public var apiAccessToken: String {
        return "not yet implemented"
    }
    
    public var appAbsoluteVersion: String  {
        return "not yet implemented"
    }
    
    public var appBundleID: String  {
        return "not yet implemented"
    }
}
