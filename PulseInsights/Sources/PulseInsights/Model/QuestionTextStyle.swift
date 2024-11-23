//
//  QuestionTextStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class QuestionTextStyle: Decodable {

    var margin: Int?
    var topMargin: Int?
    var bottomMargin: Int?

    private enum CodingKeys: String, CodingKey {
        case margin
        case topMargin = "top-margin"
        case bottomMargin = "bottom-margin"
    }

    func getTheme() -> QuestionTextTheme {
        let themeObj = QuestionTextTheme()

        themeObj.margin = margin ?? themeObj.margin
        themeObj.topMargin = topMargin ?? themeObj.topMargin
        themeObj.bottomMargin = bottomMargin ?? themeObj.bottomMargin

        return themeObj
    }
}
