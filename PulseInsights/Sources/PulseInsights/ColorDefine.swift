//
//  ColorDefine.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/8/28.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

struct ColorDefine {
    static let ButtonTextColorHex: String = "#FFFFFF"
    static let ButtonColorHex: String = "#1274B8"
    static let TableBorderColorHex: String = "#858585"
    static let RadioBtnBorderHex: String = "#000000"
    static let SurveyHintColorHex: String = "#808080"
    static let SurveyTextColorHex: String = "#000000"
    static let SurveyWidgetTextColorHex: String = "#000000"
    static let PollResultBarHex: String = "#676767"
    static let PollResultBarBase: UIColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.0)
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3:
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }

}
