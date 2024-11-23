//
//  FreeTextTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class FreeTextTheme {
    var borderColor = ColorObject(textCode: "#808080")
    var borderWidth = 3
    var backgroundColor = ColorObject(textCode: "#FFFFFF")
    var hideLogo = false
    var fontColor = ColorObject(textCode: "#000000")
    var maxLines = 0
    var placeholderFontColor = ColorObject(textCode: "#989898")

    func applyNewStyle(newStyle: FreeTextTheme) {
        self.borderColor.code = newStyle.borderColor.code
        self.borderWidth = newStyle.borderWidth
        self.backgroundColor.code = newStyle.backgroundColor.code
        self.hideLogo = newStyle.hideLogo
        self.fontColor.code = newStyle.fontColor.code
        self.maxLines = newStyle.maxLines
        self.placeholderFontColor.code = newStyle.placeholderFontColor.code
    }
}
