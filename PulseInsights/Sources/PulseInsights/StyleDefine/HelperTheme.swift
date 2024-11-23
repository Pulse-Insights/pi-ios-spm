//
//  HelperTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/12/10.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class HelperTheme: ViewThemeBase {
    override init() {
        super.init()
        margin = 0
        topMargin = -1
        bottomMargin = -1
    }

    func applyNewStyle(newStyle: HelperTheme) {
        margin = newStyle.margin
        topMargin = newStyle.topMargin
        bottomMargin = newStyle.bottomMargin
    }

    func configTopMargin(_ constraint: NSLayoutConstraint?) {
        if topMargin > 0 {
            constraint?.constant = CGFloat(topMargin)
        }
    }

    func configBottomMargin(_ constraint: NSLayoutConstraint?) {
        if bottomMargin > 0 {
            constraint?.constant = CGFloat(bottomMargin)
        }
    }

    func applyMargin(labelView: PaddingLabel?) {
        let leftCGMargin = CGFloat(margin)
        let rightCGMargin = CGFloat(margin)
        let topCGMargin = CGFloat( (topMargin > -1) ? topMargin : margin )
        let bottomCGMargin = CGFloat( (bottomMargin > -1) ? bottomMargin : margin )
        labelView?.setPadding(left: leftCGMargin, right: rightCGMargin, top: topCGMargin, bottom: bottomCGMargin)
    }
}
