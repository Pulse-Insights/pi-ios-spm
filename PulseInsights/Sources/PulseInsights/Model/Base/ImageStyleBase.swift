//
//  ImageStyleBase.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class ImageStyleBase: Decodable {

    var width: Int?
    var height: Int?
    var margin: Int?
    var horizonAlign: String?

    private enum CodingKeys: String, CodingKey {
        case width
        case height
        case margin
        case horizonAlign = "horizontal-align"
    }

    func getTheme(_ defaultStyle: ImageBaseTheme) -> ImageBaseTheme {
        let themeObj = ImageBaseTheme()

        themeObj.width = width ?? defaultStyle.width
        themeObj.height = height ?? defaultStyle.height
        themeObj.margin = margin ?? defaultStyle.margin
        themeObj.horizonAlign = horizonAlign ?? defaultStyle.horizonAlign

        return themeObj
    }
}
