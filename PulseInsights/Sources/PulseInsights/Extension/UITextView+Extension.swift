//
//  UITextView+Extention.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/12/03.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}
