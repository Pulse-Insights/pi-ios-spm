//
//  SelectOption.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/22.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class SelectOption: OptionBase {
    var id: Int?
    var next_question_id: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case next_question_id
    }

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        next_question_id = try container.decodeIfPresent(Int.self, forKey: .next_question_id)
    }
}

extension SelectOption {
    var nextQuestionId: String {
        return String(next_question_id ?? 0)
    }
    var itemId: String {
        return String(id ?? 0)
    }
}
