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
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        let frameworkBundle = Bundle(for: PulseInsights.self)
        if let resourceBundleURL = frameworkBundle.url(forResource: "PulseInsightsSPM", withExtension: "bundle"),
           let resourceBundle = Bundle(url: resourceBundleURL) {
            return resourceBundle
        }
        if let resourceBundleURL = Bundle.main.url(forResource: "PulseInsightsSPM", withExtension: "bundle"),
           let resourceBundle = Bundle(url: resourceBundleURL) {
            return resourceBundle
        }
        return frameworkBundle
        #endif
    }
}
