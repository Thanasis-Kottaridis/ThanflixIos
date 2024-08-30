//
//  SwiftUIAccessibilityModifiers.swift
//  Presentation
//
//  Created by a.kottaridis on 28/8/24.
//

import Foundation
import SwiftUI

/// SwiftUI dynamicTypeSize modifier for iOS 14 or earlier
public struct SizeCategoryModifier: ViewModifier {
    
    @Environment(\.sizeCategory) private var sizeCategory
    
    private let range: ClosedRange<ContentSizeCategory>
    
    public init(range: ClosedRange<ContentSizeCategory>) {
        self.range = range
    }
    
    public func body(content: Content) -> some View {
        content
            .environment(\.sizeCategory, min(max(range.lowerBound, sizeCategory), range.upperBound))
    }
}

// Restricting Dynamic Type Sizes
public extension View {
    /**
    Sets the Dynamic Type size within the view to the given value.
     # Example Usage #
     ```
     .sizeCategory(.large) // Use a static size category
     ```
    - SeeAlso: [`dynamicTypeSize(_:)`](https://developer.apple.com/documentation/swiftui/view/dynamictypesize%28_%3A%29-1m2tf)
    */
    func sizeCategory(_ category: ContentSizeCategory) -> some View {
        environment(\.sizeCategory, category)
    }
    
    /**
     Limits the Dynamic Type size within the view to the given range.
     # Example Usage #
     ```
     .sizeCategory() // Use the default size range
     
     .sizeCategory(.small ... .extraLarge) // Use custom size range
     ```
     # Example replacement in iOS 15, if we want to use a default range #
     ```
     func sizeCategory<T: RangeExpression>(_ range: T = (.medium ... .xxLarge)) -> some View where T.Bound == DynamicTypeSize {
         dynamicTypeSize(range)
     }
     ```
    - SeeAlso: [`dynamicTypeSize(_:)`](https://developer.apple.com/documentation/swiftui/view/dynamictypesize%28_%3A%29-26aj0)
     */
    func sizeCategory(_ range: ClosedRange<ContentSizeCategory> = (.large ... .extraExtraLarge)) -> some View {
        modifier(SizeCategoryModifier(range: range))
    }
}

// Comparison functions are implemented by default in iOS 14, macOS 11, tvOS 14 and watchOS 7 or later.
// If you’re targeting later versions, you only need to make `ContentSizeCategory` conform to `Comparable`:
extension ContentSizeCategory: Comparable {}
