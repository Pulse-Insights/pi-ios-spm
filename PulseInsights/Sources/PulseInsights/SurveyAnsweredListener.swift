//
//  SurveyAnsweredListener.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/5/29.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//

import Foundation

public protocol SurveyAnsweredListener {
    func onAnswered(_ answerId: String)
}
