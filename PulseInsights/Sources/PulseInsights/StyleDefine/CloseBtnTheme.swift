//
//  CloseBtnTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class CloseBtnTheme {
    var fontColor = ColorObject(textCode: "#000000")
    var margin = 20
    var display = true

    func applyNewStyle(newStyle: CloseBtnTheme) {
        self.fontColor.code = newStyle.fontColor.code
        self.margin = newStyle.margin
        self.display = newStyle.display
    }
}
