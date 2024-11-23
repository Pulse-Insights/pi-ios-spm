//
//  WidgetStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class WidgetStyle: Decodable {

    var backgroundColor: String?
    var padding: Int?
    var borderColor: String?
    var borderWidth: Int?

    private enum CodingKeys: String, CodingKey {
        case backgroundColor = "background-color"
        case padding
        case borderColor = "border-color"
        case borderWidth = "border-width"
    }

    func getTheme() -> WidgetTheme {
        let themeObj = WidgetTheme()

        themeObj.backgroundColor.code = backgroundColor ?? themeObj.backgroundColor.code
        themeObj.padding = padding ?? themeObj.padding
        themeObj.borderColor.code = borderColor ?? themeObj.borderColor.code
        themeObj.borderWidth = borderWidth ?? themeObj.borderWidth

        return themeObj
    }
}
