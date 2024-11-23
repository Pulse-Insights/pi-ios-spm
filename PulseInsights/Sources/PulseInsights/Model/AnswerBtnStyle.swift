//
//  AnswerBtnStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class AnswerBtnStyle: Decodable {

    var backgroundColor: String?
    var borderColor: String?
    var borderWidth: Int?
    var borderRadius: CGFloat?
    var fontColor: String?
    var fontWeight: CGFloat?
    var fontSize: Int?
    var width: Int?
    var height: Int?
    var padding: Int?
    var margin: Int?
    var tabEffect: Bool?
    var tabEffectTextColor: String?
    var tabEffectBackgroundColor: String?
    var tabEffectBorderColor: String?
    var perRowBackgroundColor: String?
    var paddingVertical: CGFloat?
    var paddingHorizontal: CGFloat?
    var backgroundColorSelected: String?

    private enum CodingKeys: String, CodingKey {
        case backgroundColor = "background-color"
        case borderColor = "border-color"
        case borderWidth = "border-width"
        case borderRadius = "border-radius"
        case fontColor = "font-color"
        case fontSize = "font-size"
        case fontWeight = "font-weight"
        case width
        case height
        case padding
        case margin
        case tabEffect = "tab-effect"
        case tabEffectTextColor = "tab-effect-text-color"
        case tabEffectBackgroundColor = "tab-effect-background-color"
        case tabEffectBorderColor = "tab-effect-border-color"
        case perRowBackgroundColor = "per-row-multi-selected-background-color"
        case paddingVertical = "padding-vertical"
        case paddingHorizontal = "padding-horizontal"
        case backgroundColorSelected = "background-color-selected"
    }

    func getTheme() -> AnswerBtnTheme {
        let themeObj = AnswerBtnTheme()

        themeObj.backgroundColor.code = backgroundColor ?? themeObj.backgroundColor.code
        themeObj.selectedBackgroundColor.code = backgroundColorSelected ?? themeObj.selectedBackgroundColor.code
        themeObj.borderColor.code = borderColor ?? themeObj.borderColor.code
        themeObj.borderWidth = borderWidth ?? themeObj.borderWidth
        themeObj.borderRadius = borderRadius ?? themeObj.borderRadius
        themeObj.fontColor.code = fontColor ?? themeObj.fontColor.code
        themeObj.fontWeight = fontWeight ?? themeObj.fontWeight
        themeObj.fontSize = fontSize ?? themeObj.fontSize
        themeObj.width = width ?? themeObj.width
        themeObj.height = height ?? themeObj.height
        themeObj.padding = padding ?? themeObj.padding
        themeObj.margin = margin ?? themeObj.margin
        themeObj.tabEffect = tabEffect ?? themeObj.tabEffect
        themeObj.tabEffectTextColor.code = tabEffectTextColor ?? themeObj.tabEffectTextColor.code
        themeObj.tabEffectBackgroundColor.code = tabEffectBackgroundColor ?? themeObj.tabEffectBackgroundColor.code
        themeObj.tabEffectBorderColor.code = tabEffectBorderColor ?? themeObj.tabEffectBorderColor.code
        themeObj.perRowBackgroundColor.code = perRowBackgroundColor ?? themeObj.perRowBackgroundColor.code
        themeObj.paddingHorizontal = paddingHorizontal ?? themeObj.paddingHorizontal
        themeObj.paddingVertical = paddingVertical ?? themeObj.paddingVertical

        return themeObj
    }
}
