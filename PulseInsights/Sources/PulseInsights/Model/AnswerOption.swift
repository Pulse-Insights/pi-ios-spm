//
//  AnswerOption.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/22.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class AnswerOption: OptionBase {
    var id: String?
    var rawCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case rawCount = "count"
    }

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        rawCount = try container.decodeIfPresent(Int.self, forKey: .rawCount)
    }
}

extension AnswerOption {
    var count: Int {
        return rawCount ?? 0
    }
    var itemId: String {
        return id ?? ""
    }

    func getPercentage(_ totalCount: NSInteger) -> NSInteger {
        if totalCount <= 0 {
            return 0
        } else {
            return count * 100 / totalCount
        }
    }
}
