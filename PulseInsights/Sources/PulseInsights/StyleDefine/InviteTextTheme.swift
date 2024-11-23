//
//  InviteTextTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class InviteTextTheme: FontBaseTheme {
    var margin = 20

    func applyNewStyle(newStyle: InviteTextTheme) {
        self.margin = newStyle.margin
        self.fontColor.code = newStyle.fontColor.code
    }

    func applyMargin(labelView: PaddingLabel?) {
        let cgMargin = CGFloat(margin)
        labelView?.setPadding(left: cgMargin, right: cgMargin, top: cgMargin, bottom: cgMargin)
        labelView?.textLabel.textColor = fontColor.color
    }
}
