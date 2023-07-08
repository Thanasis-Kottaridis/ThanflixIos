//
//  ColorPalette.swift
//  Presentation
//
//  Created by thanos kottaridis on 29/1/23.
//

import UIKit

public indirect enum ColorPalette {
    
    case BrandPrimary
    case BrandSecondary
    case TintPrimary
    case TintSecondary
    case TintTertiary
    case TintWhite
    case TintRed
    case TintBlue
    case TintYellow
    case TintGreen
    case FillPrimary
    case FillSecondary
    case BackgroundDefaultPrimary
    case BackgroundGroupedPrimary
    case BackgroundGroupedSecondary
    case SeperatorPrimary
    case ShadowPrimary
    case EffectBlur
    case EffectShadow
    case CustomAlpha(color: ColorPalette ,alpha: Double)
    
    public func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

public extension ColorPalette {
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .BrandPrimary:
            instanceColor = UIColor(hexString:"#1EC7FA")
        case .BrandSecondary:
            instanceColor = UIColor(hexString:"#1E6FF1")
        case .TintPrimary:
            instanceColor = UIColor(hexString:"#000000")
        case .TintSecondary:
            instanceColor = UIColor(hexString:"#7F7F7F")
        case .TintTertiary:
            instanceColor = UIColor(hexString:"#BFBFBF")
        case .TintWhite:
            instanceColor = UIColor(hexString:"#FFFFFF")
        case .TintRed:
            instanceColor = UIColor(hexString:"#FF3B30")
        case .TintBlue:
            instanceColor = UIColor(hexString:"#007AFF")
        case .TintYellow:
            instanceColor = UIColor(hexString:"#FFCC00")
        case .TintGreen:
            instanceColor = UIColor(hexString:"#34C759")
        case .FillPrimary:
            instanceColor = UIColor(hexString:"#D8D8D8")
        case .FillSecondary:
            instanceColor = UIColor(hexString:"#BFBFBF")
        case .BackgroundDefaultPrimary:
            instanceColor = UIColor(hexString:"#F2F2F2")
        case .BackgroundGroupedPrimary:
            instanceColor = UIColor(hexString:"#FFFFFF")
        case .BackgroundGroupedSecondary:
            instanceColor = UIColor(hexString:"#FFFFFF")
        case .SeperatorPrimary:
            instanceColor = UIColor(hexString:"#D8D8D8")
        case .ShadowPrimary:
            instanceColor = UIColor(hexString:"#000000").withAlphaComponent(0.25)
        case .CustomAlpha(let color, let alpha):
            instanceColor = color.withAlpha(alpha)
        case .EffectBlur:
            instanceColor = UIColor(hexString:"#F0F0F0").withAlphaComponent(0.38)
        case .EffectShadow:
            instanceColor = UIColor(hexString:"#464646").withAlphaComponent(0.5)

        }
        
        return instanceColor

    }
}
