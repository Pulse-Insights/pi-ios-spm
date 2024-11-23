//
//  AnswersHelperStyle.swift
//  PulseInsights
//
//  Created by Lu Hao on 2021/6/3.
//  Copyright © 2021 Pulse Insights. All rights reserved.
//

import Foundation

struct AnswersHelperStyle: Decodable {
    let padding: CGFloat?
    let paddingHorizontal: CGFloat?
    let paddingVertical: CGFloat?

    var fontStyle: FontStyleBase?

    enum CodingKeys: String, CodingKey {
        case padding
        case paddingHorizontal = "padding-horizontal"
        case paddingVertical = "padding-vertical"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Self.CodingKeys.self)
        padding = try container.decodeIfPresent(CGFloat.self, forKey: .padding)
        paddingHorizontal = try container.decodeIfPresent(CGFloat.self, forKey: .paddingHorizontal)
        paddingVertical = try container.decodeIfPresent(CGFloat.self, forKey: .paddingVertical)
        fontStyle = try FontStyleBase.init(from: decoder)
    }
}
