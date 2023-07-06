//
//  InjectBoundries.swift
//  Data
//
//  Created by thanos kottaridis on 2/2/23.
//

import Foundation
import Domain

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProvider = NetworkProviderImpl()
}

private struct DataAppConfigProvider: InjectionKey {
    static var currentValue: DataAppConfig = DefaultDataAppConfig()
}

private struct RequestHeadersBuilderProvider: InjectionKey {
    static var currentValue: RequestHeadersBuilder = DefaultRequestHeadersBuilder()
}

extension InjectedValues {
    
    var networkProvider: NetworkProvider {
        get { Self[NetworkProviderKey.self]}
        set { Self[NetworkProviderKey.self] = newValue }
    }
    
    public var dataAppConfig: DataAppConfig {
        get { Self[DataAppConfigProvider.self] }
        set { Self[DataAppConfigProvider.self] = newValue }
    }
    
    public var requestHeadersBuilder: RequestHeadersBuilder {
        get { Self[RequestHeadersBuilderProvider.self] }
        set { Self[RequestHeadersBuilderProvider.self] = newValue }
    }
}
