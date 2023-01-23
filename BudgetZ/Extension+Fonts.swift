//
//  Extension+Fonts.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 16/01/23.
//

import SwiftUI

enum NunitoFont: String {
    case regular    = "Nunito-Regular"
    case light      = "Nunito-Light"
    case medium     = "Nunito-Medium"
    case bold       = "Nunito-Bold"
    case extrabold  = "Nunito-ExtraBold"
    case semibold   = "Nunito-SemiBold"
}

extension Font {
    static var appRegularFont   = Font.custom(NunitoFont.regular.rawValue, size: 14)
    static var applightFont     = Font.custom(NunitoFont.light.rawValue, size: 13)
    static var appMediumFont    = Font.custom(NunitoFont.medium.rawValue, size: 14)
    static var appSemiBoldFont  = Font.custom(NunitoFont.semibold.rawValue, size: 14)
    static var appBoldFont      = Font.custom(NunitoFont.bold.rawValue, size: 14)
    static var appExtraBoldFont = Font.custom(NunitoFont.extrabold.rawValue, size: 14)
    
    static func customAppFont(type: NunitoFont, size: CGFloat) -> Font {
        return Font.custom(type.rawValue, size: size)
    }
}
