//
//  SurveyInlineResult.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/3/1.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//

import Foundation

public protocol SurveyInlineResult {
    func onServeResult()
    func onFinish()
    func onDisplay() -> Bool
}
