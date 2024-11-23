//
//  FontStyleBase.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class FontStyleBase: Decodable {

    var fontFace: String?
    var fontSize: Int?
    var fontColor: String?
    var fontWeight: CGFloat?
    var style: String?
    var alignment: String?

    private enum CodingKeys: String, CodingKey {
        case fontFace = "font-face"
        case fontSize = "font-size"
        case fontColor = "font-color"
        case fontWeight = "font-weight"
        case style
        case alignment
    }

    func getTheme(_ defaultStyle: FontBaseTheme) -> FontBaseTheme {
        let themeObj = FontBaseTheme()

        themeObj.fontFace = fontFace ?? defaultStyle.fontFace
        themeObj.fontSize = fontSize ?? defaultStyle.fontSize
        themeObj.fontWeight = fontWeight ?? defaultStyle.fontWeight
        themeObj.fontColor.code = fontColor ?? defaultStyle.fontColor.code
        themeObj.style = style ?? defaultStyle.style
        themeObj.alignment = alignment ?? defaultStyle.alignment

        return themeObj
    }
}
