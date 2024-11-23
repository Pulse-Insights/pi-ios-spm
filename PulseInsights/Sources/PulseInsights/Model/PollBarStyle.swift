//
//  PollBarStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class PollBarStyle: Decodable {

    var displayPercentage: Bool?
    var displayAbs: Bool?
    var barColor: String?

    private enum CodingKeys: String, CodingKey {
        case displayPercentage = "display-percentage"
        case displayAbs = "display-abs"
        case barColor = "bar-color"
    }

    func getTheme() -> PollBarTheme {
        let themeObj = PollBarTheme()

        themeObj.displayPercentage = displayPercentage ?? themeObj.displayPercentage
        themeObj.displayAbs = displayAbs ?? themeObj.displayAbs
        themeObj.barColor.code = barColor ?? themeObj.barColor.code

        return themeObj
    }
}
