//
//  CloseBtnStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class CloseBtnStyle: Decodable {

    var fontColor: String?
    var margin: Int?
    var display: Bool?

    private enum CodingKeys: String, CodingKey {
        case fontColor = "font-color"
        case margin
        case display
    }

    func getTheme() -> CloseBtnTheme {
        let themeObj = CloseBtnTheme()

        themeObj.fontColor.code = fontColor ?? themeObj.fontColor.code
        themeObj.margin = margin ?? themeObj.margin
        themeObj.display = display ?? themeObj.display

        return themeObj
    }
}
