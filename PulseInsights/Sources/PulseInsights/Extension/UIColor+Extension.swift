//
//  UIColor+Extension.swift
//  PulseInsights
//
//  Created by long shen on 2024/10/17.
//  Copyright © 2024 Pulse Insights. All rights reserved.
//

import UIKit

extension UIColor {
    var coloredImage: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
