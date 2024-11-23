//
//  AutoButton.swift
//  PulseInsights
//
//  Created by Chao Shih-Chuan on 2017/2/2.
//  Copyright © 2017年 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class AutoButton: UIButton {

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width  += 20
        contentSize.height += self.titleLabel!.frame.size.height
        return contentSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel!.preferredMaxLayoutWidth = self.titleLabel!.frame.size.width
        self.titleLabel?.textColor = LocalConfig.instance.themeStyle.textColor.color
        super.layoutSubviews()
    }

}
