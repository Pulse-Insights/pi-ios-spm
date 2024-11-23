//
//  CheckMarkStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class CheckMarkStyle: Decodable {

    var color: String?
    var fontSize: CGFloat?
    var width: CGFloat?
    var height: CGFloat?

    private enum CodingKeys: String, CodingKey {
        case color
        case fontSize = "font-size"
        case width
        case height
    }

    func getTheme() -> CheckMarkTheme {
        let themeObj = CheckMarkTheme()

        themeObj.color.code = color ?? themeObj.color.code
        themeObj.fontSize = fontSize ?? themeObj.fontSize
        themeObj.width = width ?? themeObj.width
        themeObj.height = height ?? themeObj.height

        return themeObj
    }
}
