//
//  InviteTextStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class InviteTextStyle: Decodable {

    var margin: Int?
    var fontColor: String?
    var fontFace: String?
    var fontSize: Int?
    var fontStyle: String?

    private enum CodingKeys: String, CodingKey {
        case margin
        case fontFace = "font-face"
        case fontSize = "font-size"
        case fontColor = "font-color"
        case fontStyle = "font-style"
    }

    func getTheme() -> InviteTextTheme {
        let themeObj = InviteTextTheme()

        themeObj.margin = margin ?? themeObj.margin
        themeObj.fontColor.code = fontColor ?? themeObj.fontColor.code

        return themeObj
    }
}
