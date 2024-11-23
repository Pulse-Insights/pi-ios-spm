//
//  CGFloat+Extension.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/08/31.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

public extension CGFloat {
    /**
     Converts pixels to points based on the screen scale. For example, if you
     call CGFloat(1).pixelsToPoints() on an @2x device, this method will return
     0.5.

     - parameter pixels: to be converted into points

     - returns: a points representation of the pixels
     */
    func pixelsToPoints() -> CGFloat {
        return self / UIScreen.main.scale
    }

    /**
     Returns the number of points needed to make a 1 pixel line, based on the
     scale of the device's screen.

     - returns: the number of points needed to make a 1 pixel line
     */
    static func onePixelInPoints() -> CGFloat {
        return CGFloat(1).pixelsToPoints()
    }
}
