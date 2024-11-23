//
//  OptionBase.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/22.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class OptionBase: Decodable {

    var rawContent: String?
    var image_url: String?

    private enum CodingKeys: String, CodingKey {
        case rawContent = "content"
        case image_url
    }
}
extension OptionBase {
    var imageUrl: String {
        let readyUrl = image_url ?? ""
        return readyUrl.hasPrefix("//") ? "https:\(readyUrl)" : readyUrl
    }
    var content: String {
        return rawContent ?? ""
    }
}
