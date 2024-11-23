//
//  ColorObject.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

open class ColorObject {

    var code: String = "#FFFFFF"
    
    var color: UIColor {
        return UIColor(hexString: code)
    }

    init(textCode: String = "#FFFFFF") {
        self.code = textCode
    }
}
