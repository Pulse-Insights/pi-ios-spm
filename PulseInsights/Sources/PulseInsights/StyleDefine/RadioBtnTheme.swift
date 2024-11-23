//
//  RadioBtnTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class RadioBtnTheme: ViewThemeBase {
    var backgroundColor = ColorObject(textCode: "#FFFFFF")
    var borderColor = ColorObject(textCode: "#858585")
    var borderWidth = 5
    var hide = false

    override init() {
        super.init()
        width = 20
        height = 20
        padding = 0
        margin = 0
        hide = false
    }

    func applyNewStyle(newStyle: RadioBtnTheme) {
        self.backgroundColor.code = newStyle.backgroundColor.code
        self.borderColor.code = newStyle.borderColor.code
        self.borderWidth = newStyle.borderWidth
        self.width = newStyle.width
        self.height = newStyle.height
        self.padding = newStyle.padding
        self.margin = newStyle.margin
        self.hide = newStyle.hide
    }
}
