//
//  Equatable+Extension.swift
//  PulseInsights
//
//  Created by Lu Hao on 2021/6/24.
//  Copyright © 2021 Pulse Insights. All rights reserved.
//

import Foundation

extension Equatable {
    /// Update self if the new value is not `nil` and not equal to self
    mutating func updateIfNeed(newValue: Self?) {
        if let newValue = newValue, newValue != self {
            self = newValue
        }
    }

    /// Update self if the new value is not equal to self
    mutating func updateIfNeed(newValue: Self) {
        if newValue != self {
            self = newValue
        }
    }
}
