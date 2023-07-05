//
//  RequestHeadersBuilderImpl.swift
//  Thanflix
//
//  Created by thanos kottaridis on 5/7/23.
//

import UIKit
import Domain
import Data

public class RequestHeadersBuilderImpl: RequestHeadersBuilder {
    private var appConfig: DataAppConfig {
        @Injected(\.dataAppConfig)
        var appConfig: DataAppConfig
        return appConfig
    }
    
    public init() {}
    
    public func withUserAgent(headers: inout [String : String]) {
       
        let osVersion: String = UIDevice.current.systemVersion
        let manufacture = "Apple"
        let model: String = UIDevice.modelName
        let ppi: CGFloat? = UIScreen.pointsPerInch
        let width = UIScreen.main.bounds.width * UIScreen.main.scale
        let height = UIScreen.main.bounds.height * UIScreen.main.scale
         
        headers["User-Agent"] = "iOS/\(osVersion) (\(manufacture); \(model); W \(width); H \(height); D \(Int(ppi ?? UIScreen.main.scale)) Thanfix/\(appConfig.appAbsoluteVersion)"
    }
    
    public func withLocalizationHeaders(headers: inout [String : String]) {
        print("Not Yet Implemented")
    }
    
    public func withApiKey(headers: inout [String : String]) {
        print("Not Yet Implemented")
    }
    
    public func withDefaultHeaders(headers: inout [String : String]) {
        headers["accept"] = "application/json"
        headers["Authorization"] = "Bearer \(appConfig.apiAccessToken)"
        
        
    }
}
