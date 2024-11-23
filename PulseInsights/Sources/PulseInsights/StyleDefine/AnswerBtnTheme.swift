//
//  AnswerBtnTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class AnswerBtnTheme {
    var backgroundColor = ColorObject(textCode: "#FFFFFF")
    var backgroundColorHighlight = ColorObject(textCode: "#0d0d0f")
    var borderColor = ColorObject(textCode: "#858585")
    var borderWidth = 3
    var borderRadius: CGFloat?
    var fontColor = ColorObject(textCode: "#000000")
    var fontStyle = "bold"
    var fontSize = 16
    var fontWeight = 400.0
    var width = 0
    var height = 0
    var padding = 20
    var margin = 0
    var tabEffect = false
    var tabEffectTextColor = ColorObject(textCode: "#FF000000")
    var tabEffectBackgroundColor = ColorObject(textCode: "#FFFFFFFF")
    var tabEffectBorderColor = ColorObject(textCode: "#FF000000")
    var perRowBackgroundColor = ColorObject(textCode: "#0d0d0f")
    var paddingVertical: CGFloat?
    var paddingHorizontal: CGFloat?
    var selectedBackgroundColor = ColorObject(textCode: "#FFFFFF")

    func applyNewStyle(newStyle: AnswerBtnTheme) {
        self.backgroundColor.code = newStyle.backgroundColor.code
        self.borderColor.code = newStyle.borderColor.code
        self.borderWidth = newStyle.borderWidth
        self.borderRadius = newStyle.borderRadius
        self.fontColor.code = newStyle.fontColor.code
        self.fontSize = newStyle.fontSize
        self.fontWeight = newStyle.fontWeight
        self.width = newStyle.width
        self.height = newStyle.height
        self.padding = newStyle.padding
        self.margin = newStyle.margin
        self.tabEffect = newStyle.tabEffect
        self.tabEffectTextColor.code = newStyle.tabEffectTextColor.code
        self.tabEffectBackgroundColor.code = newStyle.tabEffectBackgroundColor.code
        self.tabEffectBorderColor.code = newStyle.tabEffectBorderColor.code
        self.perRowBackgroundColor.code = newStyle.perRowBackgroundColor.code
        self.paddingVertical = newStyle.paddingVertical
        self.paddingHorizontal = newStyle.paddingHorizontal
        self.selectedBackgroundColor = newStyle.selectedBackgroundColor
    }

    func widthConStr() -> String {
        return width > 0 ? "(\(width))" : ""
    }
    func heightConStr() -> String {
        return height > 0 ? "(>=\(height))" : ""
    }

    func getFontDetail() -> FontFormater {
        let formatter = FontFormater()
        formatter.fontColor = fontColor
        formatter.fontStyle = fontStyle
        formatter.fontWeight = fontWeight
        return formatter
    }
}
