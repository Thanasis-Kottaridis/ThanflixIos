//
//  DataBoundry.swift
//  Data
//
//  Created by thanos kottaridis on 2/2/23.
//

import Foundation
import Domain

public class DataBoundry {
    
    // MARK: - Dependencies
    var appConfig: DataAppConfig
    var requestHeadersBuilder: RequestHeadersBuilder

    public init(
        appConfig: DataAppConfig,
        requestHeadersBuilder: RequestHeadersBuilder
    ) {
        self.appConfig = appConfig
        self.requestHeadersBuilder = requestHeadersBuilder
    }
    
    public func initialize() {
        // set up dependencies
        InjectedValues[\.dataAppConfig] = appConfig
        InjectedValues[\.requestHeadersBuilder] = requestHeadersBuilder
    }

}
