//
//  BrandTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class BrandTheme {
    var hide = false

    func applyNewStyle(newStyle: BrandTheme) {
        self.hide = newStyle.hide
    }
}
