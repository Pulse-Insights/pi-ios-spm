//
//  FontSmallTheme.swift
//  PulseInsights
//
//  Created by Shenlong on 2024/11/19.
//  Copyright © 2024 Pulse Insights. All rights reserved.
//

import Foundation

open class FontErrorTheme: FontBaseTheme {
    init() {
        super.init()
        let fontColor = ColorObject(textCode: "#FF0000")
        self.fontColor = fontColor
    }
}
