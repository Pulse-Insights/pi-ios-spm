//
//  AnswersHelperTheme.swift
//  PulseInsights
//
//  Created by Lu Hao on 2021/6/3.
//  Copyright © 2021 Pulse Insights. All rights reserved.
//

import Foundation

class AnswersHelperTheme {
    var paddingLeft: CGFloat = 0
    var paddingRight: CGFloat = 0
    var paddingTop: CGFloat = 0
    var paddingBottom: CGFloat = 0

    lazy var font: FontBaseTheme = {
        let fontTheme = FontBaseTheme()
        fontTheme.fontSize = 16
        fontTheme.alignment = "center"
        return fontTheme
    }()

    func applyNewStyle(_ style: AnswersHelperStyle) {
        if let horizontalPadding = style.paddingHorizontal ?? style.padding {
            paddingLeft = horizontalPadding
            paddingRight = horizontalPadding
        }
        if let verticalPadding = style.paddingVertical ?? style.padding {
            paddingTop = verticalPadding
            paddingBottom = verticalPadding
        }
        if let fontStyle = style.fontStyle {
            font.updateWithStyle(fontStyle)
        }
    }
}
