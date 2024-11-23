//
//  SubmitBtnStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class SubmitBtnStyle: Decodable {

    var backgroundColor: String?
    var borderColor: String?
    var borderWidth: Int?
    var fontFace: String?
    var fontSize: Int?
    var fontColor: String?
    var fontStyle: String?
    var fontWeight: CGFloat?
    var width: Int?
    var height: Int?
    var padding: Int?
    var margin: Int?
    var borderRadius: CGFloat?
    var paddingVertical: CGFloat?
    var paddingHorizontal: CGFloat?

    private enum CodingKeys: String, CodingKey {
        case backgroundColor = "background-color"
        case borderColor = "border-color"
        case borderWidth = "border-width"
        case fontFace = "font-face"
        case fontSize = "font-size"
        case fontColor = "font-color"
        case fontStyle = "font-style"
        case fontWeight = "font-weight"
        case width
        case height
        case padding
        case margin
        case borderRadius = "border-radius"
        case paddingVertical = "padding-vertical"
        case paddingHorizontal = "padding-horizontal"
    }

    func getTheme() -> SubmitBtnTheme {
        let themeObj = SubmitBtnTheme()

        themeObj.backgroundColor.code = backgroundColor ?? themeObj.backgroundColor.code
        themeObj.borderColor.code = borderColor ?? themeObj.borderColor.code
        themeObj.borderWidth = borderWidth ?? themeObj.borderWidth
        themeObj.fontFace = fontFace ?? themeObj.fontFace
        themeObj.fontSize = fontSize ?? themeObj.fontSize
        themeObj.fontColor.code = fontColor ?? themeObj.fontColor.code
        themeObj.fontStyle = fontStyle ?? themeObj.fontStyle
        themeObj.fontWeight = fontWeight ?? themeObj.fontWeight
        themeObj.width = width ?? themeObj.width
        themeObj.height = height ?? themeObj.height
        themeObj.padding = padding ?? themeObj.padding
        themeObj.margin = margin ?? themeObj.margin
        themeObj.borderRadius = borderRadius ?? themeObj.borderRadius
        themeObj.paddingHorizontal = paddingHorizontal
        themeObj.paddingVertical = paddingVertical

        return themeObj
    }
}
