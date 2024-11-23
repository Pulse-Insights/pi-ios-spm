//
//  SurveyPollResult.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/3/14.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class SurveyPollResultView: UIView {

    @IBOutlet weak var resultList: UIView!

    var pollResultItems: [PollResultItem] = [PollResultItem]()
    var totalCount: NSInteger = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    func setup() {
        loadViewFromXib()
        self.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 0)
        resultList.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": resultList]))
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": resultList]))

    }

    open func setResultItems(_ results: PollResult) {
        for subItem in resultList.subviews {
            subItem.removeFromSuperview()
        }
        pollResultItems = [PollResultItem]()
        totalCount = results.countAnswers.count

        for addItem: AnswerOption in results.countAnswers {
            let answerItem = PollResultItem()
            resultList.addSubview(answerItem)
            answerItem.placeResultContent(addItem, totalCount: results.getTotalCount())
            pollResultItems.append(answerItem)
            answerItem.translatesAutoresizingMaskIntoConstraints = false
            addItemConstrains(pollResultItems.count-1)
        }

    }
    func addItemConstrains(_ index: Int) {

        let verticalSpacing: CGFloat = 20
        if index == 0 {
            resultList.addConstraints(NSLayoutConstraint
                .constraints(withVisualFormat: "V:|-10-[selectionItem]", options: NSLayoutConstraint.FormatOptions(),
                             metrics: nil, views: ["selectionItem": pollResultItems[index]]))
        } else if index == totalCount-1 {
            resultList.addConstraints(NSLayoutConstraint
                .constraints(withVisualFormat: "V:[previousSelectionItem]-padding-[selectionItem(>=5)]-10-|",
                             options: NSLayoutConstraint.FormatOptions(), metrics: ["padding": verticalSpacing],
                             views: ["previousSelectionItem": pollResultItems[index-1],
                                     "selectionItem": pollResultItems[index]]))
        } else {
            resultList.addConstraints(NSLayoutConstraint
                .constraints(withVisualFormat: "V:[previousSelectionItem]-padding-[selectionItem(>=5)]",
                             options: NSLayoutConstraint.FormatOptions(), metrics: ["padding": verticalSpacing],
                             views: ["previousSelectionItem": pollResultItems[index-1],
                                     "selectionItem": pollResultItems[index]]))
        }
        self.resultList.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-10-[selectionItem(>=0)]-10-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["selectionItem": pollResultItems[index]]))

    }

}
