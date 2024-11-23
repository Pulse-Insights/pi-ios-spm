//
//  PollResult.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/22.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class PollResult {

    var title: String = ""
    var countAnswers = [AnswerOption]()
    var totalCount: NSInteger = -1

    open func getTotalCount() -> NSInteger {
        if totalCount < 0 {
            totalCount = 0
            for item in countAnswers {
                totalCount += item.count
            }
        }
        return totalCount
    }
}
