//
//  StyledImageView.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/12/20.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class StyledImageView: UIView {

    @IBOutlet weak var imageView: UIImageView!

    var imageStyle: ImageBaseTheme = ImageBaseTheme() {
        didSet {
            imageStyle.configHorizontalAlign(imageView)
        }
    }

    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeighConstraint: NSLayoutConstraint!

    var imageUrl: String = "" {
        didSet {
            if let url = URL(string: imageUrl) {
                imageStyle.downloadImage(url: url, imageView: imageView, containerView: self, heighConstrain: imageHeighConstraint, widthConstrain: imageWidthConstraint)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    @IBOutlet var containerView: UIView!

    func setup() {
        loadViewFromXib()

        containerView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
}
