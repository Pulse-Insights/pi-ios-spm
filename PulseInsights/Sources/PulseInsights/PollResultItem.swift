//
//  PollResultItem.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/3/14.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class PollResultItem: UIView {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var valueResult: UILabel!
    @IBOutlet weak var resultBarConstraint: NSLayoutConstraint!

    @IBOutlet weak var resultBarBase: UIView!
    @IBOutlet weak var resultbar: UIView!
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
    }

    open func placeResultContent(_ item: AnswerOption, totalCount: NSInteger) {
        itemTitle.attributedText = formatTool.transferToHtmlFormatInAttribute(item.content, fontDetail: LocalConfig.instance.themeStyle.mediumFont.getFormater())
        let resultText = composeValueString(item.getPercentage(totalCount), count: item.count)
        valueResult.attributedText = formatTool.transferToHtmlFormatInAttribute(resultText, fontDetail: LocalConfig.instance.themeStyle.mediumFont.getFormater())
        resultbar.translatesAutoresizingMaskIntoConstraints = false
        resultbar.backgroundColor = LocalConfig.instance.themeStyle.pollBar.barColor.color
        resultBarBase.backgroundColor = UIColor.clear
        displayPercentage(Float(item.getPercentage(totalCount)))
    }
    fileprivate func displayPercentage(_ value: Float) {
        var inputValue = (value == 0) ? 0.001 : value
        inputValue = (inputValue > 100) ? 100 : inputValue
        addConstraintFromView(subview: resultbar, multiplier: CGFloat( (value == 0) ? 0.001 : inputValue/100 ),
                              identifier: "t1")
    }
    fileprivate func composeValueString(_ percentage: NSInteger, count: NSInteger) -> String {
        let showAbs = LocalConfig.instance.themeStyle.pollBar.displayAbs
        let showPercentage = LocalConfig.instance.themeStyle.pollBar.displayPercentage
        let multi = (count > 1) ? "s" : ""
        let abs = showAbs ? String(format: showPercentage ? " (%d response%@)" : "%d response%@", count, multi) : ""
        return (showPercentage ? String(format: "%d%%", percentage) : "") + abs
    }
    func addConstraintFromView(subview: UIView?,
                               multiplier: CGFloat,
                               identifier: String) {
        if let subview = subview {
            let constraint = NSLayoutConstraint(item: subview,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: containerView,
                                                attribute: .width,
                                                multiplier: multiplier,
                                                constant: 0)
            constraint.identifier = identifier
            containerView.addConstraint(constraint)
        }

    }

}
