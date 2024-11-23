//
//  QuestionTextTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class QuestionTextTheme {
    var margin = 0
    var topMargin = 0
    var bottomMargin = 0

    func applyNewStyle(newStyle: QuestionTextTheme) {
        self.topMargin = newStyle.topMargin
        self.bottomMargin = newStyle.bottomMargin
        self.margin = newStyle.margin
    }

    func applyMargin(labelView: PaddingLabel?) {
        let leftCGMargin = CGFloat(margin)
        let rightCGMargin = CGFloat(margin)
        let topCGMargin = CGFloat( (topMargin>0) ? topMargin : margin )
        let bottomCGMargin = CGFloat( (bottomMargin>0) ? bottomMargin : margin )
        labelView?.setPadding(left: leftCGMargin, right: rightCGMargin, top: topCGMargin, bottom: bottomCGMargin)
    }
}
