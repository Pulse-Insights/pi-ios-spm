//
//  AllQuestionListItem.swift
//  PulseInsights
//
//  Created by long shen on 2024/5/20.
//  Copyright © 2024 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class SurveyItemTableViewCell: UITableViewCell {
    let surveyItemView = SurveyItemView()
    var delegate: SurveyItemTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(surveyItemView)
        
        surveyItemView.delegate = self
        surveyItemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            surveyItemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            surveyItemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            surveyItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            surveyItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SurveyItemTableViewCell: SurveyItemViewDelegate {
    func onAnswerSelected(_ surveyItemView: SurveyItemView, didUpdateAnswer answer: String) {
        delegate?.onItemAnswerSelected(self, didUpdateAnswer: answer)
    }
}

protocol SurveyItemTableViewCellDelegate {
    func onItemAnswerSelected(_ cell: SurveyItemTableViewCell, didUpdateAnswer answer: String)
}
