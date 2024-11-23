//
//  BrandStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class BrandStyle: Decodable {

    var display: Bool?

    private enum CodingKeys: String, CodingKey {
        case display
    }

    func getTheme() -> BrandTheme {
        let themeObj = BrandTheme()

        themeObj.hide = hide

        return themeObj
    }
}

extension BrandStyle {
    var hide: Bool {
        return !(display ?? !BrandTheme().hide)
    }
}
