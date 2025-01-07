//
//  ServeySelectionType.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2017/1/12.
//  Copyright © 2017 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class SurveySelectionType: UIView {

    @IBOutlet weak var counterLabel: UILabel!

    @IBOutlet weak var buttonsStack: UIStackView!
    var callBackBtnClicked: ((String, String) -> Void)?
    var selectAnswers: [SelectOption] = [SelectOption]()
    var answerButtons: [CheckButton] = [CheckButton]()
    private let formatTool = FormatSetTool()
    var strMutiSelectedRes: String = ""
    var multiOptionNext = ""
    var bIsTypeSingle: Bool = true
    var iMaxSelection: NSInteger = -1
    var iTotalCount: NSInteger = 0
    var selectedCount = 0 {
        didSet {
            counterText = !bIsTypeSingle && (iMaxSelection > -1) && (selectedCount>iMaxSelection) ? "\(selectedCount) / \(iMaxSelection) " : ""
        }
    }
    var counterText = "" {
        didSet {
            counterLabel.isHidden = counterText.isEmpty
            counterLabel.attributedText = formatTool.transferToHtmlFormatInAttribute(counterText, fontDetail: LocalConfig.instance.themeStyle.smallFont.getFormater())
        }
    }
    var currentTicket: SurveyTicket?

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
    }

    @objc func btnDoClickedSingle(_ sender: UIView!) {
        let bStatusNext: Bool = !(answerButtons[sender.tag].selected)
        for (index, button) in answerButtons.enumerated() {
            if index != sender.tag {
                button.updateBackgroundColor(false)
            }
        }
        answerButtons[sender.tag].selectButton(bStatusNext)
        var answer = ""
        if LocalConfig.instance.surveyPack.survey.displayAllQuestions {
            answer = answerButtons[sender.tag].selected ? selectAnswers[sender.tag].itemId : ""
            callBackBtnClicked?(answer, currentTicket!.surveyId)
        } else {
            answer = selectAnswers[sender.tag].itemId
            callBackBtnClicked?(answer, selectAnswers[sender.tag].nextQuestionId)
        }
    }
    @objc func btnDoClickedMuti(_ sender: CheckButton!) {
        let bStatusNext: Bool = !(answerButtons[sender.tag].selected)
        answerButtons[sender.tag].selectButton(bStatusNext)
        selectedCount = getSelectedCount()
        callBackBtnClicked?(getMultiAnswer(), "")
    }
    func getSelectedCount() -> NSInteger {
        var iRtCount: NSInteger = 0

        for tmpBtn: CheckButton in answerButtons where tmpBtn.selected {
            iRtCount += 1
        }

        return iRtCount
    }

    var clearToSubmit: Bool {
        return (selectedCount>0) && ((iMaxSelection == -1) || (selectedCount <= iMaxSelection))
    }

    func setupItem(_ singleType: Bool, surveyContent: SurveyTicket,
                   callback:@escaping (_ strSelectedID: String, _ strNextID: String) -> Void) {
        for subItem in buttonsStack.subviews {
            subItem.removeFromSuperview()
        }
        iTotalCount = surveyContent.possibleAnswers.count
        selectedCount = 0
        currentTicket = surveyContent
        bIsTypeSingle = singleType
        selectAnswers = [SelectOption]()
        answerButtons = [CheckButton]()
        callBackBtnClicked = callback
        iMaxSelection = Int(surveyContent.maximumSelection) ?? -1
        buttonsStack.backgroundColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0)
        var innerStack = UIStackView()
        innerStack.axis = .horizontal
        var innerStackCount = 0
        var perRowWidth = CGFloat(0)
        if surveyContent.answersPerRow > 1 || surveyContent.nps {
            perRowWidth = buttonsStack.frame.width / CGFloat(max(surveyContent.answersPerRow, 1))
        }
        print("buttonsStack width: \(buttonsStack.frame.width)")
        for possibleAnswer in surveyContent.possibleAnswers {
            let answerButton = CheckButton()
            answerButton.tagValue = selectAnswers.count
            answerButton.tag = selectAnswers.count
            answerButton.setupView(singleType, optionDetail: possibleAnswer, perRowWidth: perRowWidth, shouldShowSelectedColor: LocalConfig.instance.surveyPack.survey.displayAllQuestions)
            answerButton.translatesAutoresizingMaskIntoConstraints = false
            if singleType {
                answerButton.button.addTarget(self, action: #selector(SurveySelectionType.btnDoClickedSingle),
                                               for: UIControl.Event.touchUpInside)
            } else {
                answerButton.button.addTarget(self, action: #selector(SurveySelectionType.btnDoClickedMuti),
                                               for: UIControl.Event.touchUpInside)
            }
            selectAnswers.append(possibleAnswer)
            answerButtons.append(answerButton)
            innerStack.distribution = .fillProportionally
            innerStack.addArrangedSubview(answerButton)

            innerStackCount += 1
            if innerStackCount == surveyContent.answersPerRow {
                innerStackCount = 0
                buttonsStack.addArrangedSubview(innerStack)
                innerStack = UIStackView()
                innerStack.axis = .horizontal
            }
        }
        if innerStackCount > 0 {
            innerStack.distribution = .fillProportionally
        }
        buttonsStack.addArrangedSubview(innerStack)
        DebugTool.debugPrintln("Height with items: " + String(describing: self.bounds.height))

    }
    func getMultiAnswer() -> String {
        strMutiSelectedRes = ""
        multiOptionNext = ""
        for index in 0...answerButtons.count - 1 {
            let tmpItem: CheckButton = answerButtons[index]
            if tmpItem.selected {
                let answerData = selectAnswers[index]
                if !strMutiSelectedRes.isEmpty {strMutiSelectedRes += "&"}
                if multiOptionNext.isEmpty && index + 1 == selectAnswers.count && answerData.nextQuestionId != "0" {
                    multiOptionNext = answerData.nextQuestionId
                }
                strMutiSelectedRes += answerData.itemId
            }
        }
        return strMutiSelectedRes
    }

    func cleanup() {
        // Clear callbacks
        callBackBtnClicked = nil
        
        // Clear data
        multiOptionNext = ""
    }
}
