//
//  HelperStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class HelperStyle: Decodable {

    var margin: Int?
    var topMargin: Int?
    var bottomMargin: Int?

    private enum CodingKeys: String, CodingKey {
        case margin = "container-margin"
        case topMargin = "container-top-margin"
        case bottomMargin = "container-bottom-margin"
    }

    func getTheme() -> HelperTheme {
        let themeObj = HelperTheme()

        themeObj.margin = margin ?? themeObj.margin
        themeObj.topMargin = topMargin ?? themeObj.topMargin
        themeObj.bottomMargin = bottomMargin ?? themeObj.bottomMargin

        return themeObj
    }
}
