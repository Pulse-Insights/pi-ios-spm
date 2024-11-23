//
//  PaddingLabel.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/12/10.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class PaddingLabel: HeightSetableUIView {
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.numberOfLines = 0
            textLabel.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet weak var paddingRight: NSLayoutConstraint!
    @IBOutlet weak var paddingBottom: NSLayoutConstraint!
    @IBOutlet weak var paddingTop: NSLayoutConstraint!
    @IBOutlet weak var paddingLeft: NSLayoutConstraint!
    private let formatTool = FormatSetTool()
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
        self.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.clear
    }

    func setPadding(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        paddingRight.constant = right
        paddingBottom.constant = bottom
        paddingTop.constant = top
        paddingLeft.constant = left
    }

    func setTitle(_ title: String, themeFont: FontFormater) {
        textLabel.attributedText = formatTool.transferToHtmlFormatInAttribute(title, fontDetail: themeFont)
    }

}
