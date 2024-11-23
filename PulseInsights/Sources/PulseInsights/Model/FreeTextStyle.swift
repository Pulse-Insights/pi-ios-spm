//
//  FreeTextStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class FreeTextStyle: Decodable {

    var backgroundColor: String?
    var borderColor: String?
    var borderWidth: Int?
    var fontColor: String?
    var maxLines: Int?
    var placeholderFontColor: String?

    private enum CodingKeys: String, CodingKey {
        case backgroundColor = "background-color"
        case borderColor = "border-color"
        case borderWidth = "border-width"
        case fontColor = "font-color"
        case maxLines = "max-lines"
        case placeholderFontColor = "placeholder-font-color"
    }

    func getTheme() -> FreeTextTheme {
        let themeObj = FreeTextTheme()

        themeObj.backgroundColor.code = backgroundColor ?? themeObj.backgroundColor.code
        themeObj.borderColor.code = borderColor ?? themeObj.borderColor.code
        themeObj.borderWidth = borderWidth ?? themeObj.borderWidth
        themeObj.fontColor.code = fontColor ?? themeObj.fontColor.code
        themeObj.maxLines = maxLines ?? themeObj.maxLines
        themeObj.placeholderFontColor.code = placeholderFontColor ?? themeObj.placeholderFontColor.code

        return themeObj
    }
}
