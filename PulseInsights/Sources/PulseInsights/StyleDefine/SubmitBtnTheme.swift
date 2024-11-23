//
//  SubmitBtnTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

open class SubmitBtnTheme {
    //Include the button on the invite widget
    var backgroundColor = ColorObject(textCode: "#1274B8")
    var backgroundColorHighlight = ColorObject(textCode: "#35353b")
    var borderColor = ColorObject(textCode: "#858585")
    var disableBackgroundColor = ColorObject(textCode: "#BABABA")
    var disableBorderColor = ColorObject(textCode: "#BABABA")
    var borderWidth = 0
    var fontFace = "sans-serif"
    var fontSize = 16
    var fontColor: ColorObject = ColorObject(textCode: "#FFFFFF")
    var fontStyle = "normal"
    var fontWeight = 400.0
    var disableFontColor: ColorObject = ColorObject(textCode: "#FFFFFF")
    var width = 0
    var height = 0
    var padding = 10
    var margin = 20
    var horizonAlign = "center"
    var borderRadius: CGFloat = 8.0
    var paddingVertical: CGFloat?
    var paddingHorizontal: CGFloat?

    func getFormater(enable: Bool = true) -> FontFormater {
        let formater = FontFormater()
        formater.alignment = horizonAlign
        formater.fontSize = fontSize
        formater.fontFace = fontFace
        formater.fontColor = ColorObject(textCode: (enable ? fontColor : disableFontColor).code)
        formater.fontStyle = fontStyle
        formater.fontWeight = fontWeight
        return formater
    }

    func applyNewStyle(newStyle: SubmitBtnTheme) {
        self.backgroundColor.code = newStyle.backgroundColor.code
        self.borderColor.code = newStyle.borderColor.code
        self.borderWidth = newStyle.borderWidth
        self.fontFace = newStyle.fontFace
        self.fontSize = newStyle.fontSize
        self.fontWeight = newStyle.fontWeight
        self.fontColor.code = newStyle.fontColor.code
        self.width = newStyle.width
        self.height = newStyle.height
        self.padding = newStyle.padding
        self.margin = newStyle.margin
        self.horizonAlign = newStyle.horizonAlign
        self.borderRadius = newStyle.borderRadius
        self.paddingHorizontal = newStyle.paddingHorizontal
        self.paddingVertical = newStyle.paddingVertical
    }

    func configMarginConstraint(_ constraint: NSLayoutConstraint?) {
        constraint?.constant = CGFloat(margin)
    }
    func configWidthConstraint(_ constraint: NSLayoutConstraint?) {
        if width > 0 {
            constraint?.constant = CGFloat(width)
        }
    }
    func configHeightConstraint(_ constraint: NSLayoutConstraint?) {
        if height > 0 {
            constraint?.constant = CGFloat(height)
        }
    }
}
