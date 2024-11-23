//
//  WidgetTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class WidgetTheme {

    // Common style for all of the views ( include the invite widget )
    var backgroundColor = ColorObject(textCode: "#FFFFFF")
    var padding = 0
    var borderColor = ColorObject(textCode: "#858585")
    var borderWidth = 0

    func applyNewStyle(newStyle: WidgetTheme) {
        self.backgroundColor.code = newStyle.backgroundColor.code
        self.padding = newStyle.padding
        self.borderColor.code = newStyle.borderColor.code
        self.borderWidth = newStyle.borderWidth
    }

}
