//
//  PollBarTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class PollBarTheme {
    var displayAbs = false
    var displayPercentage = true
    var barColor = ColorObject(textCode: "#676767")

    func applyNewStyle(newStyle: PollBarTheme) {
        self.displayAbs = newStyle.displayAbs
        self.barColor.code = newStyle.barColor.code
    }
}
