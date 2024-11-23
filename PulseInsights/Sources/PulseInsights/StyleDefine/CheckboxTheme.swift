//
//  CheckboxTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class CheckboxTheme: ViewThemeBase {
    var backgroundColor = ColorObject(textCode: "#8BCC6B")
    var borderWidth = 5
    var borderColor = ColorObject(textCode: "#000000")

    override init() {
        super.init()
        width = 25
        height = 25
    }

    func applyNewStyle(newStyle: CheckboxTheme) {
        self.backgroundColor.code = newStyle.backgroundColor.code
        self.borderWidth = newStyle.borderWidth
        self.borderColor.code = newStyle.borderColor.code
        self.width = newStyle.width
        self.height = newStyle.height
    }
}
