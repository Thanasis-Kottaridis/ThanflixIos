//
//  SafeEnumType.swift
//  Domain
//
//  Created by thanos kottaridis on 15/7/23.
//

import Foundation

public protocol SafeEnumType: RawRepresentable, CaseIterable where RawValue: Equatable {
    static var defaultCase: Self { get }
}

extension SafeEnumType {
    public init(rawValue: RawValue) {
        self = Self.allCases.first(where: { $0.rawValue == rawValue }) ?? Self.defaultCase
    }
}
