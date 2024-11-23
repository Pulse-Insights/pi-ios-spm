//
//  Dictionary+Extention.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/17.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            let rowValue: String = String("\(value)")
            var str = rowValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? rowValue
            str = str.replacingOccurrences(of: ",", with: "%2C")
            str = str.replacingOccurrences(of: ":", with: "%3A")
            output +=  "\(key)=\(str)&"
        }
        output = String(output.dropLast())
        return output
    }

    var urlQueryItems: [URLQueryItem] {
        var queryArray = [URLQueryItem]()
        for (key,value) in self {
            queryArray.append(URLQueryItem(name: "\(key)", value: "\(value)"))
        }
        return queryArray
    }
    
    var stringify: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\"\(key)\":\"\(value)\","
        }
        output = String(output.dropLast())
        return "{\(output)}"
    }
}
