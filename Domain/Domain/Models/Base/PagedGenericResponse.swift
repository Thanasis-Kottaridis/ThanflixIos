//
//  PagedGenericResponse.swift
//
//  Created by thanos kottaridis on 3/6/21.
//

import Foundation

public typealias VoidResponse = String

public struct PagedGenericResponse<T: Codable>: Codable {
    public var results: T?
    public var page: Int?
    public var total_pages: Int?
    public var total_results: Int?
    
    internal init(results: T? = nil, page: Int? = nil, total_pages: Int? = nil, total_results: Int? = nil) {
        self.results = results
        self.page = page
        self.total_pages = total_pages
        self.total_results = total_results
    }
}
