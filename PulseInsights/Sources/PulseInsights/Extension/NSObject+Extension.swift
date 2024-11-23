//
//  NSObject+Extention.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/12/26.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    static var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
