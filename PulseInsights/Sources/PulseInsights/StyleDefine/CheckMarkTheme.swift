//
//  CheckMarkTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class CheckMarkTheme {
    var color = ColorObject(textCode: "#FFFFFF")
    var fontSize: CGFloat = 16
    var width: CGFloat = 25
    var height: CGFloat = 25

    func applyNewStyle(newStyle: CheckMarkTheme) {
        self.color.code = newStyle.color.code
        self.fontSize = newStyle.fontSize
        self.width = newStyle.width
        self.height = newStyle.height
    }
}
