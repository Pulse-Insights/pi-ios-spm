//
//  HightlightButton.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/09/23.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class HightlightButton: UIButton {
    var highlightAction : ((Bool) -> Void)?
    override var isHighlighted: Bool {
        didSet {
            highlightAction?(isHighlighted)
        }
    }
}
