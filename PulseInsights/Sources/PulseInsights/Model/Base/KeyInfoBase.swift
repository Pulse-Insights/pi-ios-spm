//
//  DeviceInfoBase.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/22.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class KeyInfoBase: Decodable {
    var raw_udid: String?

    private enum CodingKeys: String, CodingKey {
        case raw_udid = "udid"
    }
}
extension KeyInfoBase {
    var udid: String {
        return raw_udid ?? ""
    }
}
