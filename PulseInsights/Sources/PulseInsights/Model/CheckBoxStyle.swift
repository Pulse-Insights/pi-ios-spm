//
//  CheckBoxStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class CheckBoxStyle: Decodable {

    var backgroundColor: String?
    var borderColor: String?
    var borderWidth: Int?
    var width: Int?
    var height: Int?

    private enum CodingKeys: String, CodingKey {
        case backgroundColor = "background-color"
        case borderColor = "border-color"
        case borderWidth = "border-width"
        case width
        case height
    }

    func getTheme() -> CheckboxTheme {
        let themeObj = CheckboxTheme()

        themeObj.backgroundColor.code = backgroundColor ?? themeObj.backgroundColor.code
        themeObj.borderColor.code = borderColor ?? themeObj.borderColor.code
        themeObj.borderWidth = borderWidth ?? themeObj.borderWidth
        themeObj.width = width ?? themeObj.width
        themeObj.height = height ?? themeObj.height

        return themeObj
    }
}
