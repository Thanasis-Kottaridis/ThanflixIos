//
//  SectionModel.swift
//  Domain
//
//  Created by thanos kottaridis on 12/7/23.
//

import Foundation

public struct SectionModel<Section, ItemType>: Equatable where Section: Equatable, ItemType: Equatable {
    public var model: Section
    public var items: [ItemType]

    public init(model: Section, items: [ItemType]) {
        self.model = model
        self.items = items
    }
}
