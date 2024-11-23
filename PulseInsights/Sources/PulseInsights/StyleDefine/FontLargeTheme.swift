//
//  FontLargeTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class FontLargeTheme: FontBaseTheme {
    override init(_ fontSzie: Int = 18) {
        super.init()
        self.fontSize = fontSize
    }
    
    override func getFormater() -> FontFormater {
        let formater = FontFormater()
        formater.alignment = alignment
        formater.fontSize = fontSize
        formater.fontFace = "XfinityStandard"
        formater.fontColor = fontColor
        formater.fontStyle = style
        formater.fontWeight = 700
        return formater
        
    }
}
