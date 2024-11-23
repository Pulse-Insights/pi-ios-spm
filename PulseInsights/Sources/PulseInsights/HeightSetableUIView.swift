//
//  SetHeightUIView.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/11/03.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class HeightSetableUIView: UIView {
    var heightConstranint: NSLayoutConstraint?
    func goneHide() {
        self.isHidden = true
        heightConstranint?.isActive = false
        if let conttraint = heightConstranint {
            conttraint.constant = 0
        } else {
            heightConstranint = self.heightAnchor.constraint(equalToConstant: 0)
        }
        heightConstranint?.isActive = true
        self.layoutIfNeeded()
    }
    func unHide( height: CGFloat = -1 ) {
        self.isHidden = false
        heightConstranint?.isActive = false
        if(height > -1) {
            if let conttraint = heightConstranint {
                conttraint.constant = height
            } else {
                heightConstranint = self.heightAnchor.constraint(equalToConstant: height)
            }
            heightConstranint?.isActive = true
        }
        self.layoutIfNeeded()
    }
}
