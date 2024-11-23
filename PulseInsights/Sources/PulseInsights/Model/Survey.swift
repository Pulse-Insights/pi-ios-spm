//
//  Survey.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/23.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class Survey: Decodable {
    var raw_survey: SurveyCover?
    var raw_submission: KeyInfoBase?
    var raw_device: KeyInfoBase?
    var device_data: String?

    private enum CodingKeys: String, CodingKey {
        case raw_survey = "survey"
        case raw_submission = "submission"
        case raw_device = "device"
        case device_data
    }
}
extension Survey {
    var survey: SurveyCover {
        return raw_survey ?? SurveyCover()
    }
    var submission: KeyInfoBase {
        return raw_submission ?? KeyInfoBase()
    }
    var device: KeyInfoBase {
        return raw_device ?? KeyInfoBase()
    }
    var deviceData: String {
        return device_data ?? ""
    }
}
