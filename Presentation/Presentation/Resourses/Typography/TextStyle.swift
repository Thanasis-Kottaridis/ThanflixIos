//
//  TextStyle.swift
//  Presentation
//
//  Created by thanos kottaridis on 29/1/23.
//

import Foundation
import SwiftUI
import BonMot

public struct TextStyle {
    public enum StyleWeight {
        case BLACK
        case BOLD
        case EXTRA_BOLD
        case EXTRA_LIGHT
        case LIGHT
        case REGULAR
        case SEMIBOLD
            
        func returnFont() -> Font {
            switch self {
            case .BLACK:
                return Font.MulishBlack
            case .BOLD:
                return Font.MulishBold
            case .EXTRA_BOLD:
                return Font.MulishExtraBold
            case .EXTRA_LIGHT:
                return Font.MulishExtraLight
            case .LIGHT:
                return Font.MulishLight
            case .REGULAR:
                return Font.MulishMedium
            case .SEMIBOLD:
                return Font.MulishSemiBold
            }
        }
    }
    
    public enum Style {
        // MARK: - Figma
        case title1(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case title2(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case title3(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case body1(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case body2(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case body3(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case body4(weight: StyleWeight, color: ColorPalette? = .TintPrimary)
        case custom(
            weight: StyleWeight,
            size: Int,
            ColorPalette: CGFloat,
            lineHeight: CGFloat,
            color: ColorPalette? = .TintPrimary
        )
        
        public func stringStyle() -> BonMot.StringStyle {
            switch self {
            case .title1(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 34,
                         letterSpacing: 0.02,
                         lineHeight: 41.0,
                         color: color
                )
            case .title2(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 28,
                         letterSpacing: 0.02,
                         lineHeight: 34.0,
                         color: color
                )
            case .title3(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 22,
                         letterSpacing: 0.02,
                         lineHeight: 28.0,
                         color: color
                )
            case .body1(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 17,
                         letterSpacing: 0.02,
                         lineHeight: 22.0,
                         color: color
                )
            case .body2(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 15,
                         letterSpacing: 0.02,
                         lineHeight: 20.0,
                         color: color
                )
            case .body3(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 13,
                         letterSpacing: 0.02,
                         lineHeight: 18.0,
                         color: color
                )
            case .body4(weight: let weight, color: let color):
                return getStyle(weight: weight, size: 11,
                         letterSpacing: 0.02,
                         lineHeight: 13.0,
                         color: color
                )
            case .custom(let weight, let size, let letterSpacing, let lineHeight, let color):
                return getStyle(weight: weight, size: size,
                                letterSpacing: letterSpacing,
                                lineHeight: lineHeight,
                                color: color
                        )
            }
        }

    }
    
    public static func getStyle(
        weight: StyleWeight, size: Int,
        letterSpacing: CGFloat,
        lineHeight: CGFloat,
        color: ColorPalette? = .TintPrimary
    ) -> BonMot.StringStyle {
        if let color = color {
            return StringStyle(
                .color(color.value),
                .font(weight.returnFont().of(size: size.getAdjustedFontSize())),
                .extraAttributes([NSAttributedString.Key.kern: CGFloat(size) * letterSpacing])
            )
        } else {
            return StringStyle(
                .font(weight.returnFont().of(size: size.getAdjustedFontSize())),
                .extraAttributes([NSAttributedString.Key.kern: CGFloat(size) * letterSpacing])
            )
        }
    }
}

// MARK: TextStyle.Style Attributes EXT
public extension TextStyle.Style {
    
    var weight: TextStyle.StyleWeight {
        switch self {
        case let .title1(weight, _),
            let .title2(weight, _),
            let .title3(weight, _),
            let .body1(weight, _),
            let .body2(weight, _),
            let .body3(weight, _),
            let .body4(weight, _),
            let .custom(weight, _, _, _, _):
            return weight
        }
    }
    
    var color: ColorPalette? {
        switch self {
        case let .title1(_, color),
            let .title2(_, color),
            let .title3(_, color),
            let .body1(_, color),
            let .body2(_, color),
            let .body3(_, color),
            let .body4(_, color),
            let .custom(_, _, _, _, color):
            return color
        }
    }
    
    var adaptedSize: CGFloat {
        switch self {
        case  .title1: return 34.getAdjustedFontSize()
        case .title2: return 28.getAdjustedFontSize()
        case .title3: return 22.getAdjustedFontSize()
        case .body1: return 17.getAdjustedFontSize()
        case .body2: return 15.getAdjustedFontSize()
        case .body3: return 13.getAdjustedFontSize()
        case .body4: return 11.getAdjustedFontSize()
        case .custom(_, let size, _, _, _): return CGFloat(size)
        }
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case  .title1: return CGFloat(0.02)
        case .title2: return CGFloat(0)
        case .title3: return CGFloat(0)
        case .body1: return CGFloat(0.02)
        case .body2: return CGFloat(0.02)
        case .body3: return CGFloat(0.02)
        case .body4: return CGFloat(0.02)
        case .custom(_, _,  let letterSpacing, _, _): return letterSpacing
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .title1: return CGFloat(41)
        case .title2: return CGFloat(34)
        case .title3: return CGFloat(28)
        case .body1: return CGFloat(22)
        case .body2: return CGFloat(20)
        case .body3: return CGFloat(18)
        case .body4: return CGFloat(13)
        case .custom(_, _, _, let lineHeight, _): return lineHeight
        }
    }

}

// MARK: - EXTENSIONS
public extension String {
    /**
    # Attributed Text Style util.
     Use .with method in order to get preferable  `TextStyle.Style` attributed text
     */
    func with(_ style: TextStyle.Style) -> NSAttributedString {
        return self.styled(with: style.stringStyle())
    }
}

public extension Int {
    
    /**
    # Adapted Font Size.
     Get dynamicly addapted font size based on figma width regerence
     */
    func getAdjustedFontSize() -> CGFloat {
        // Figma project is created for Pixel 2 with screen width of 411 pixels
        let projectSize: CGFloat = 411
        let currentSize: CGFloat = UIScreen.main.bounds.width
        
        // With the Rule of Three we can calculate the font size for the current device
        let finalFontSize: CGFloat = (currentSize * CGFloat(self)) / projectSize
        
        return finalFontSize
    }
}

// MARK: SwiftUI Font Modifier
public struct CustomTextStyle: ViewModifier {
    public var style: TextStyle.Style
    
    public init(style: TextStyle.Style) {
        self.style = style
    }
    
    public func body(content: Content) -> some View {
        let uiKitFont = style.weight.returnFont().of(size: style.adaptedSize)
        let lineSpacing = style.lineHeight - uiKitFont.lineHeight
        content
            .font(.custom(style.weight.returnFont().rawValue, size: style.adaptedSize))
            .foregroundColor(style.color?.value.swiftUIColor)
            .lineSpacing(lineSpacing)
    }
}
