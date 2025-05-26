//
//  SurveyView.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/3/2.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//
// swiftlint:disable type_body_length

import Foundation
import UIKit

open class SurveyView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var piSurveyThanksmsg: UILabel!
    @IBOutlet weak var beforeHelperView: PaddingLabel! {
        didSet {
            LocalConfig.instance.themeStyle.helper.applyMargin(labelView: beforeHelperView)
        }
    }
    @IBOutlet weak var surveyTitle: PaddingLabel! {
        didSet {
            LocalConfig.instance.themeStyle.question.applyMargin(labelView: surveyTitle)
        }
    }
    @IBOutlet weak var afterHelperView: PaddingLabel! {
        didSet {
            LocalConfig.instance.themeStyle.helper.applyMargin(labelView: afterHelperView)

        }
    }

    @IBOutlet weak var beforeAnswerView: AnswerBeforeAfterView! {
        didSet {
            beforeAnswerView.updateTheme(LocalConfig.instance.themeStyle.answersHelper)
        }
    }
    @IBOutlet weak var afterAnswerView: AnswerBeforeAfterView! {
        didSet {
            afterAnswerView.updateTheme(LocalConfig.instance.themeStyle.answersHelper)
        }
    }

    func displayBeforeHelper(_ display: Bool) {
        if(display) {
            beforeHelperView.unHide()
        } else {
            beforeHelperView.goneHide()
        }
    }

    func displayTitleLabel(_ display: Bool) {
        if(display) {
            surveyTitle.unHide()
        } else {
            surveyTitle.goneHide()
        }
    }

    func displayAfterHelper(_ display: Bool) {
        if(display) {
            afterHelperView.unHide()
        } else {
            afterHelperView.goneHide()
        }
    }

    @IBOutlet weak var innerInviteView: HeightSetableUIView!
    @IBOutlet weak var piSurveyInsideScrollview: HeightSetableUIView!
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.submitBtn.padding)
            let horizontalPadding =
                LocalConfig.instance.themeStyle.submitBtn.paddingHorizontal ?? padding
            let verticalPadding =
                LocalConfig.instance.themeStyle.submitBtn.paddingVertical ?? padding
            submitButton.contentEdgeInsets =  UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
            let normalColor = LocalConfig.instance.themeStyle.submitBtn.backgroundColor.color
            submitButton.setBackgroundImage(normalColor.coloredImage, for: .normal)
            let highlightColor = LocalConfig.instance.themeStyle.submitBtn.backgroundColorHighlight.color
            submitButton.setBackgroundImage(highlightColor.coloredImage, for: .highlighted)
            submitButton.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.submitBtn.borderWidth)
            submitButton.layer.borderColor = LocalConfig.instance.themeStyle.submitBtn.borderColor.color.cgColor
            submitButton.layer.cornerRadius = LocalConfig.instance.themeStyle.submitBtn.borderRadius
            submitButton.layer.masksToBounds = true
        }
    }
    var submitTitle = "send"
    var enableSubmitBtn = true {
        didSet {
            if enableSubmitBtn {
                submitButton.layer.backgroundColor = UIColor.clear.cgColor
                submitButton.layer.borderColor = LocalConfig.instance.themeStyle.submitBtn.borderColor.color.cgColor
            } else {
                submitButton.layer.backgroundColor = LocalConfig.instance.themeStyle.submitBtn.disableBackgroundColor.color.cgColor
                submitButton.layer.borderColor = LocalConfig.instance.themeStyle.submitBtn.disableBorderColor.color.cgColor
            }
            setSubmitBtn(submitTitle, enable: enableSubmitBtn)
            submitButton.isEnabled = enableSubmitBtn
        }
    }
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var btnMarginLeft: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginLeft)
        }
    }
    @IBOutlet weak var btnMarginTop: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginTop)
        }
    }
    @IBOutlet weak var btnMarginBottom: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginBottom)
        }
    }
    @IBOutlet weak var btnMarginRight: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginRight)
        }
    }
    @IBOutlet weak var submitBtnWidth: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configWidthConstraint(submitBtnWidth)
        }
    }
    @IBOutlet weak var submitBtnHeight: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configHeightConstraint(submitBtnHeight)
        }
    }
    @IBOutlet weak var mainPaddingBottom: NSLayoutConstraint! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.widget.padding)
            mainPaddingBottom.constant = padding
        }
    }
    @IBOutlet weak var mainPaddingRight: NSLayoutConstraint! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.widget.padding)
            mainPaddingRight.constant = padding
        }
    }
    @IBOutlet weak var mainPaddingTop: NSLayoutConstraint! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.widget.padding)
            mainPaddingTop.constant = padding
        }
    }
    @IBOutlet weak var mainPaddingLeft: NSLayoutConstraint! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.widget.padding)
            mainPaddingLeft.constant = padding
        }
    }
    @IBOutlet weak var outContainer: UIView! {
        didSet {
            outContainer.backgroundColor = LocalConfig.instance.themeStyle.widget.backgroundColor.color
            outContainer.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.widget.borderWidth)
            outContainer.layer.borderColor = LocalConfig.instance.themeStyle.widget.borderColor.color.cgColor
        }
    }
    @IBOutlet weak var piSurveyLayout: HeightSetableUIView! {
        didSet {
            piSurveyLayout.backgroundColor = UIColor.clear
            piSurveyLayout.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.widget.borderWidth)
            piSurveyLayout.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBOutlet weak var zeroHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var standHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("\u{2715}", for: .normal)
            closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            closeButton.setTitleColor(LocalConfig.instance.themeStyle.closeBtn.fontColor.color, for: .normal)
            let padding = CGFloat(LocalConfig.instance.themeStyle.closeBtn.margin)
            closeButton.contentEdgeInsets = UIEdgeInsets(top: padding,left: padding,bottom: 0,right: padding)
            closeButton.isHidden = !LocalConfig.instance.themeStyle.closeBtn.display
        }
    }
    lazy var chooseContentView = SurveySelectionType()
    lazy var customContentView = SurveyCustomContentType()
    lazy var freeTextView = SurveyTextType()
    lazy var pollResultView = SurveyPollResultView()
    var listSurveyItem = [SurveyTicket]()
    var closeTimer: Timer?
    var inlineEnable: Bool = false
    var inlineType: Bool = false
    var trackClassName: String = ""
    var pulseInsights: PulseInsights?
    private let formatTool = FormatSetTool()
    @IBOutlet weak var logoView: UIImageView! {
        didSet {
            logoView.isHidden = LocalConfig.instance.themeStyle.brand.hide
        }
    }

    @IBOutlet weak var styledImage: StyledImageView! {
        didSet {
            styledImage.imageStyle = LocalConfig.instance.themeStyle.surveyImg
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    @IBOutlet var containerView: UIView!
    func setup() {
        pulseInsights = PulseInsights.getInstance
        loadViewFromXib(nibName: "SurveyView")
        self.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 0.0)
        viewDidLoad()
    }

    open func switchInlineType(_ enable: Bool) {
        inlineType = enable
        closeView()
    }

    var delegateViewResult: SurveyViewResult?

    var heightConstraint: NSLayoutConstraint?

    func viewDidLoad() {
        displayInviteView(false)
        innerInviteView.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.onInviteClicked)))
        inviteButton.addTarget(self, action: #selector(self.onInviteClicked), for: .touchUpInside)

        self.containerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        UIApplication.shared.isStatusBarHidden = true
        let actTapSurveyAround = UITapGestureRecognizer(target: self, action: #selector(self.tapSurveyAround(_:)))
        piSurveyLayout.addGestureRecognizer(actTapSurveyAround)
        chooseContentView = SurveySelectionType()
        piSurveyInsideScrollview.addSubview(chooseContentView)
        customContentView = SurveyCustomContentType()
        piSurveyInsideScrollview.addSubview(customContentView)
        freeTextView = SurveyTextType()
        piSurveyInsideScrollview.addSubview(freeTextView)
        pollResultView = SurveyPollResultView()
        piSurveyInsideScrollview.addSubview(pollResultView)
        piSurveyInsideScrollview.goneHide()
        buttonContainer.isHidden = true
        displayBeforeHelper(false)
        displayAfterHelper(false)
        beforeAnswerView.hide()
        afterAnswerView.hide()
        displayTitleLabel(false)
        chooseContentView.isHidden = true
        customContentView.isHidden = true
        freeTextView.isHidden = true
        pollResultView.isHidden = true
        piSurveyThanksmsg.isHidden = true
        chooseContentView.translatesAutoresizingMaskIntoConstraints = false
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        freeTextView.translatesAutoresizingMaskIntoConstraints = false
        pollResultView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        self.adjustItemFrameInScrollView()
    }
    
    private func applyCornerRadiusMask(to button: UIButton) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        button.layer.mask = maskLayer
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
    }

    func closeView() {
        if inlineType {
            piSurveyLayout.goneHide()
        }
    }

    fileprivate func openView() {
        if inlineEnable && inlineType {
            var fullWindow = UIScreen.main.bounds.height
            // process safe-area padding
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                let topPadding = window?.safeAreaInsets.top ?? 0
                let bottomPadding = window?.safeAreaInsets.bottom ?? 0
                fullWindow -= ( topPadding + bottomPadding )
            }
            let inputWidgetHeight = LocalConfig.instance.surveyPack.survey.widgetHeight
            var setheight = CGFloat(fullWindow/2)
            if inputWidgetHeight > 0 {
                let heightPercentage = min( inputWidgetHeight, 100 )
                setheight = fullWindow * CGFloat(heightPercentage) / 100
            }
            piSurveyLayout.unHide(height: setheight)
        }
    }

    func finish() {
        if inlineEnable && inlineType {
            PulseInsights.getInstance.finishInlineMode()
            closeView()
        } else {
            if delegateViewResult != nil {
                delegateViewResult?.onFinish()
            }
        }
    }
    @IBOutlet weak var innerCover: UIView!

    func setupSurveyContent(_ surveyContent: [SurveyTicket]) {
        let imgUrl: String = LocalConfig.instance.surveyPack.survey.background
        styledImage.imageUrl = imgUrl
        listSurveyItem = [SurveyTicket]()
        for mTmpItem: SurveyTicket in LocalConfig.instance.surveyTickets {
            listSurveyItem.append(mTmpItem)
        }
        if inlineEnable && inlineType && ( !listSurveyItem.isEmpty ) {
            let inviteText = LocalConfig.instance.surveyPack.survey.invitation
            openView()
            if inviteText.isEmpty {
                showSurvey(0)
            } else {
                displayInviteView(true)
            }
        } else {
            showSurvey(0)
        }
    }

    lazy var constraintSelection = [NSLayoutConstraint]()
    lazy var constraintCustom = [NSLayoutConstraint]()
    lazy var constraintText = [NSLayoutConstraint]()
    lazy var constraintPollResult = [NSLayoutConstraint]()
    @IBOutlet weak var helperTopMargin: NSLayoutConstraint! 
    @IBOutlet weak var helperBottomMargin: NSLayoutConstraint!
    fileprivate func adjustItemFrameInScrollView() {
        let strConstraintsWithVisualFormatInHorizon = "H:|-0-[view]-0-|"
        piSurveyInsideScrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
            strConstraintsWithVisualFormatInHorizon, options: NSLayoutConstraint.FormatOptions(),
                                                     metrics: nil, views: ["view": chooseContentView]))
        constraintSelection = NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view(>=10)]-0-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": chooseContentView])
        piSurveyInsideScrollview.addConstraints(constraintSelection)
        piSurveyInsideScrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
            strConstraintsWithVisualFormatInHorizon, options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                                                    metrics: nil, views: ["view": customContentView]))
        constraintCustom = NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view(>=10)]-0-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": customContentView])
        piSurveyInsideScrollview.addConstraints(constraintCustom)
        piSurveyInsideScrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
            strConstraintsWithVisualFormatInHorizon, options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                                                     metrics: nil, views: ["view": freeTextView]))
        constraintText = NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view(>=10)]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                         metrics: nil, views: ["view": freeTextView])
        piSurveyInsideScrollview.addConstraints(constraintText)
        piSurveyInsideScrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
            strConstraintsWithVisualFormatInHorizon, options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                         metrics: nil, views: ["view": pollResultView]))
        constraintPollResult = NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view(>=10)]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                         metrics: nil, views: ["view": pollResultView])
        piSurveyInsideScrollview.addConstraints(constraintPollResult)
    }
    @IBAction func dismissSurvey(_ sender: UIView) {
        closeKeyboard()
        disableSurvey()
    }
    @IBAction func doSubmit(_ sender: UIView) {
        var strReadyAnswer: String = ""
        var strSubmitType: String = ""
        var clearToSubmit = false
        closeKeyboard()
        if nowRunningSurveyItem != nil {
            strSubmitType = nowRunningSurveyItem!.questionType
            var nextTicketId = self.nowRunningSurveyItem!.nextQuestionId
            if strSubmitType == "multiple_choices_question" {
                strReadyAnswer = chooseContentView.getMultiAnswer()
                clearToSubmit = chooseContentView.clearToSubmit
                let optionNext = chooseContentView.multiOptionNext
                nextTicketId = !optionNext.isEmpty ? optionNext : nextTicketId
            } else if strSubmitType == "free_text_question" {
                strReadyAnswer = freeTextView.getInputString()
                clearToSubmit = freeTextView.clearToSubmit
            }
            if clearToSubmit {
                PulseInsightsAPI.postAnswers(strReadyAnswer, strQuestionID: nowRunningSurveyItem!.surveyId,
                                             strQuestiontype: nowRunningSurveyItem!.questionType) { (_ bool)in
                    if strSubmitType == "multiple_choices_question" {
                        self.goNext(nextTicketId)
                    }
                }
                if strSubmitType == "free_text_question" {
                    self.goNext(nextTicketId)
                }
            }
        }
    }
    func closeKeyboard() {
        freeTextView.txtInputPart.endEditing(true)
    }
    @objc func tapSurveyAround(_ sender: UITapGestureRecognizer) {
        closeKeyboard()
    }
    fileprivate func disableSurvey() {
        LocalConfig.instance.iSurveyEventCode = Define.piEventCodeSurveyJustClosed
        
        // For inline surveys, post notification that will be captured by React Native bridge
        if inlineEnable && inlineType {
            NotificationCenter.default.post(name: NSNotification.Name("PulseInsightsInlineSurveyFinished"), object: nil)
            closeView()
        }
        
        if delegateViewResult != nil {
            delegateViewResult?.onFinish()
        }
    }
    fileprivate func surveyEnd() {
        displayBeforeHelper(false)
        displayAfterHelper(false)
        displayTitleLabel(false)
        buttonContainer.isHidden = true
        displayInviteView(false)

        pulseInsights?.logAnswered( LocalConfig.instance.surveyPack.survey.surveyId )
        let strThanks: String = LocalConfig.instance.surveyPack.survey.thankYouMsg
        if strThanks.isEmpty || strThanks=="null" {
            disableSurvey()
        } else if !LocalConfig.instance.pollResults.isEmpty {
            showPollResult()
        } else {
            openThanksArea(strThanks)
        }
    }
    @objc fileprivate func timerClose(_ downTime: Timer) {
        disableSurvey()
    }
    @IBOutlet weak var inviteLabel: PaddingLabel! {
        didSet {
            LocalConfig.instance.themeStyle.invite.applyMargin(labelView: inviteLabel)
        }
    }
    @IBOutlet weak var inviteButton: UIButton! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.submitBtn.padding)
            inviteButton.contentEdgeInsets =  UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            inviteButton.layer.backgroundColor =
                LocalConfig.instance.themeStyle.submitBtn.backgroundColor.color.cgColor
            inviteButton.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.submitBtn.borderWidth)
            inviteButton.layer.borderColor = LocalConfig.instance.themeStyle.submitBtn.borderColor.color.cgColor
            inviteButton.layer.cornerRadius = 8
        }
    }


    @IBOutlet weak var inviteBtnMarginBottom: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginBottom)
        }
    }

    @IBOutlet weak var inviteBtnMarginLeft: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginLeft)
        }
    }

    @IBOutlet weak var inviteBtnMarginTop: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(inviteBtnMarginTop)
        }
    }

    @IBOutlet weak var inviteBtnMarginRight: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(inviteBtnMarginRight)
        }
    }
    @IBOutlet weak var inviteBtnHeight: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configWidthConstraint(inviteBtnHeight)
        }
    }
    
    @IBOutlet weak var inviteBtnWidth: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configWidthConstraint(inviteBtnWidth)
        }
    }
    @IBOutlet weak var inviteBtnContainer: UIView!

    fileprivate func displayInviteView(_ display: Bool) {
        if display {
            innerInviteView.unHide()
            let inviteMsg = LocalConfig.instance.surveyPack.survey.invitation
            inviteLabel.setTitle(inviteMsg, themeFont: LocalConfig.instance.themeStyle.largeFont.getFormater())
            inviteBtnContainer.isHidden = LocalConfig.instance.surveyPack.survey.invitationButtonDisable
        } else {
            innerInviteView.goneHide()
        }
    }

    @objc func onInviteClicked(_ sender: UITapGestureRecognizer) {
        displayInviteView(false)
        showSurvey(0)
    }

    fileprivate func openThanksArea(_ strThanksText: String) {
        piSurveyThanksmsg.isHidden = false
        scrollView.isHidden = true
        piSurveyInsideScrollview.goneHide()
        piSurveyThanksmsg.attributedText = formatTool.transferToHtmlFormatInAttribute(strThanksText, fontDetail: LocalConfig.instance.themeStyle.largeFont.getFormater())
        piSurveyThanksmsg.textAlignment = .center

        closeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerClose(_:)),
                                          userInfo: nil, repeats: false)
    }
    fileprivate var nowRunningSurveyItem: SurveyTicket?
    fileprivate func goNext(_ strNextID: String) {
        if nowRunningSurveyItem != nil {nowRunningSurveyItem = nil}
        let iIDinList: NSInteger = getListIDbyQuestionID(strNextID)
        if iIDinList == -1 {
            surveyEnd()
        } else {
            showSurvey(iIDinList)
        }
    }
    fileprivate func showSurvey(_ iListID: NSInteger) {
        if iListID < listSurveyItem.count {
            let mShowItem: SurveyTicket = listSurveyItem[iListID]
            changeToSurveyItem(mShowItem)
        }
    }
    fileprivate func  getListIDbyQuestionID(_ strQuestionID: String) -> NSInteger {
        var iRtVal: NSInteger = -1

        for index in 0...listSurveyItem.count-1 where listSurveyItem[index].surveyId == strQuestionID {
            iRtVal = index
            break
        }
        return iRtVal
    }
    fileprivate func setSurveyTitle(_ strTitle: String) {
        surveyTitle.setTitle(strTitle, themeFont: LocalConfig.instance.themeStyle.largeFont.getFormater())
    }
    fileprivate func setBeforeHelper(_ helper: String) {
        beforeHelperView.setTitle(helper, themeFont: LocalConfig.instance.themeStyle.mediumFont.getFormater())
    }
    fileprivate func setAfterHelper(_ helper: String) {
        afterHelperView.setTitle(helper, themeFont: LocalConfig.instance.themeStyle.mediumFont.getFormater())
    }
    fileprivate func setSubmitBtn(_ strTitle: String, enable: Bool = true) {
        submitTitle = strTitle
        submitButton.setAttributedTitle(formatTool
            .transferToHtmlFormatInAttribute(strTitle, fontDetail: LocalConfig.instance.themeStyle.submitBtn.getFormater(enable: enable)), for: UIControl.State())
    }
    fileprivate func activeSelectionPart(_ enable: Bool) {
        chooseContentView.isHidden = !enable
        if enable {
            NSLayoutConstraint.activate(constraintSelection)
        } else {
            NSLayoutConstraint.deactivate(constraintSelection)
        }
    }
    fileprivate func activeCustomPart(_ enable: Bool) {
        customContentView.isHidden = !enable
        if enable {
            NSLayoutConstraint.activate(constraintCustom)
        } else {
            NSLayoutConstraint.deactivate(constraintCustom)
        }
    }
    fileprivate func activeTextPart(_ enable: Bool) {
        freeTextView.isHidden = !enable
        if enable {
            NSLayoutConstraint.activate(constraintText)
        } else {
            NSLayoutConstraint.deactivate(constraintText)
        }
    }
    fileprivate func activePollResultPart(_ enable: Bool) {
        pollResultView.isHidden = !enable
        if enable {
            NSLayoutConstraint.activate(constraintPollResult)
        } else {
            NSLayoutConstraint.deactivate(constraintPollResult)
        }
    }
    fileprivate func showPollResult() {
        activeSelectionPart(false)
        activeTextPart(false)
        activeCustomPart(false)
        activePollResultPart(true)
        buttonContainer.isHidden = true
        displayBeforeHelper(false)
        displayAfterHelper(false)
        displayTitleLabel(false)
        if !LocalConfig.instance.pollResults.isEmpty {
            let showResult = LocalConfig.instance.pollResults[0]
            setSurveyTitle(showResult.title)
            pollResultView.setResultItems(showResult)
        }
    }
    fileprivate func changeToSurveyItem(_ surveyItem: SurveyTicket) {
        piSurveyInsideScrollview.unHide()
        displayInviteView(false)
        let strItemType: String = surveyItem.questionType
        activeSelectionPart(false)
        activeCustomPart(false)
        activeTextPart(false)
        activePollResultPart(false)
        displayTitleLabel(true)
        displayBeforeHelper(!surveyItem.beforeHelper.isEmpty)
        displayAfterHelper(!surveyItem.afterHelper.isEmpty)
        buttonContainer.isHidden = true
        nowRunningSurveyItem = surveyItem
        freeTextView.onChangeListener = Delegate<Void, Void>()
        chooseContentView.callBackBtnClicked = nil
        enableSubmitBtn = true
        self.setBeforeHelper(surveyItem.beforeHelper)
        self.setAfterHelper(surveyItem.afterHelper)
        beforeAnswerView.autoDisplay(with: surveyItem.beforeAnswersItems)
        afterAnswerView.autoDisplay(with: surveyItem.afterAnswersItems)
        if strItemType == "single_choice_question" {
            self.setSurveyTitle(surveyItem.content)
            activeSelectionPart(true)
            buttonContainer.isHidden = true
            chooseContentView.setupItem(true, surveyContent: surveyItem) { (strSelectedID, strNextID) -> Void in
                PulseInsightsAPI.postAnswers(strSelectedID, strQuestionID: surveyItem.surveyId,
                                             strQuestiontype: strItemType) { (_ bool)in
                    self.goNext(strNextID)
                    DebugTool.debugPrintln("strSelectedID, strNextID -> " + strSelectedID + " " + strNextID)
                }
            }
        } else if strItemType == "multiple_choices_question" {
            self.setSurveyTitle(surveyItem.content)
            activeSelectionPart(true)
            buttonContainer.isHidden = false
            self.setSubmitBtn(surveyItem.submitLabel)
            enableSubmitBtn = chooseContentView.clearToSubmit
            chooseContentView.setupItem(false, surveyContent: surveyItem) { (strSelectedID, strNextID) -> Void in
                self.enableSubmitBtn = self.chooseContentView.clearToSubmit
                DebugTool.debugPrintln("strSelectedID, strNextID -> " + strSelectedID + " " + strNextID)
            }
        } else if strItemType == "free_text_question" {
            self.setSurveyTitle(surveyItem.content)
            activeTextPart(true)
            freeTextView.setHintText(surveyItem.hintText)
            freeTextView.maxTextLength = surveyItem.maxLength
            enableSubmitBtn = freeTextView.clearToSubmit
            freeTextView.onChangeListener.delegate(on: self) { (self, void) ->
                Void in
                self.enableSubmitBtn = self.freeTextView.clearToSubmit
            }
            buttonContainer.isHidden = false
            self.setSubmitBtn(surveyItem.submitLabel)
        } else if strItemType == "custom_content_question" {
            displayTitleLabel(false)
            activeCustomPart(true)
            buttonContainer.isHidden = true
            customContentView.setupContent(surveyItem) {
                ()in
                self.goNext(surveyItem.nextQuestionId)
            }
        }
    }
    
    func cleanup() {
        // Clear timers
        closeTimer?.invalidate()
        closeTimer = nil
        
        // Clear delegates and callbacks
        delegateViewResult = nil
        pulseInsights = nil
        
        // Clear survey items
        nowRunningSurveyItem = nil
        listSurveyItem.removeAll()
        
        // Clear content views
        chooseContentView.cleanup()
        customContentView.cleanup()
        freeTextView.cleanup()
        
        // Hide views
        piSurveyInsideScrollview.goneHide()
        buttonContainer.isHidden = true
        piSurveyThanksmsg.isHidden = true
    }
}
