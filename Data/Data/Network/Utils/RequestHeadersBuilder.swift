//
//  RequestHeadersBuilder.swift
//  SharedDomain

import Foundation
import UIKit

public protocol RequestHeadersBuilder {
    func withUserAgent(headers: inout [String: String])
    func withLocalizationHeaders(headers: inout [String: String])
    func withApiKey(headers: inout [String: String])
    func withDefaultHeaders(headers: inout [String: String])
    
    func build(headers: inout [String: String])
}

extension RequestHeadersBuilder {
    
    public func build(headers: inout [String: String]) {
        withDefaultHeaders(headers: &headers)
        withApiKey(headers: &headers)
        withLocalizationHeaders(headers: &headers)
        withUserAgent(headers: &headers)
    }
}

public class DefaultRequestHeadersBuilder: RequestHeadersBuilder {
    
    public init() {}
    
    public func withLocalizationHeaders(headers: inout [String : String]) {
        fatalError("Not Yet Implemented")
    }
    
    public func withApiKey(headers: inout [String : String]) {
        fatalError("Not Yet Implemented")
    }
    
    public func withDefaultHeaders(headers: inout [String: String]) {
        fatalError("Not Yet Implemented")
    }
    
    public func withUserAgent(headers: inout [String : String]) {
        fatalError("Not Yet Implemented")
    }
}
