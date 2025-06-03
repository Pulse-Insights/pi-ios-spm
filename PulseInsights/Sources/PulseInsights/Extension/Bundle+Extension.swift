//
//  Bundle+Extension.swift
//  PulseInsights
//
//  Created for PulseInsights on 2023.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import Foundation

extension Bundle {
    static var pulseInsightsBundle: Bundle {
        // For SPM, try to use Bundle.module
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        // For CocoaPods, use the bundle for PulseInsights class
        return Bundle(for: PulseInsights.self)
        #endif
    }
    
    static func pulseInsightsBundle(for aClass: AnyClass) -> Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: aClass)
        #endif
    }
} 