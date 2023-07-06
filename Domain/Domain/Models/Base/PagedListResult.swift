//
//  PagedListResult.swift
//  Domain
//
//  Created by thanos kottaridis on 29/10/22.
//

import Foundation

public struct PagedListResult<T> {
    public let results: [T]
    public let next: Int?
    public let previous: Int?
    public let current: Int?
    public let total: Int?
    
    public init(results: [T] = [],
         next: Int? = nil,
         previous: Int? = nil,
         current: Int? = nil,
         total: Int? = nil
    ) {
        self.results = results
        self.next = next
        self.previous = previous
        self.current = current
        self.total = total
    }
}
