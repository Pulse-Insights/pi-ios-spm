//
//  ThemeStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/14.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class ThemeStyles {
    var widget = WidgetTheme()
    var closeBtn = CloseBtnTheme()
    var ansBtn = AnswerBtnTheme()
    var radio = RadioBtnTheme()
    var submitBtn = SubmitBtnTheme()
    var checkBox = CheckboxTheme()
    var checkMark = CheckMarkTheme()
    var largeFont = FontLargeTheme()
    var mediumFont = FontMediumTheme()
    var smallFont = FontSmallTheme()
    var errorFont = FontErrorTheme()
    var freeText = FreeTextTheme()
    var brand = BrandTheme()
    var invite = InviteTextTheme()
    var question = QuestionTextTheme()
    var surveyImg = SurveyImageTheme()
    var ansImg = ResponseImageTheme()
    var pollBar = PollBarTheme()
    var helper = HelperTheme()
    var answersHelper = AnswersHelperTheme()

    func updateAssignTheme(_ fetchStyle: RemoteTheme) {
        widget.applyNewStyle(newStyle: fetchStyle.widget?.getTheme() ?? WidgetStyle().getTheme())
        closeBtn.applyNewStyle(newStyle: fetchStyle.closeBtn?.getTheme() ?? CloseBtnStyle().getTheme())
        ansBtn.applyNewStyle(newStyle: fetchStyle.ansBtn?.getTheme() ?? AnswerBtnStyle().getTheme())
        radio.applyNewStyle(newStyle: fetchStyle.radio?.getTheme() ?? RadioBtnStyle().getTheme())
        submitBtn.applyNewStyle(newStyle: fetchStyle.submitBtn?.getTheme() ?? SubmitBtnStyle().getTheme())
        checkBox.applyNewStyle(newStyle: fetchStyle.checkbox?.getTheme() ?? CheckBoxStyle().getTheme())
        checkMark.applyNewStyle(newStyle: fetchStyle.checkmark?.getTheme() ?? CheckMarkStyle().getTheme())
        largeFont.applyNewStyle(newStyle: fetchStyle.largeFont?.getTheme(FontLargeTheme()) ?? FontStyleBase().getTheme(FontLargeTheme()))
        mediumFont.applyNewStyle(newStyle: fetchStyle.mediumFont?.getTheme(FontMediumTheme()) ?? FontStyleBase().getTheme(FontMediumTheme()))
        smallFont.applyNewStyle(newStyle: fetchStyle.smallFont?.getTheme(FontSmallTheme()) ?? FontStyleBase().getTheme(FontSmallTheme()))
        errorFont.applyNewStyle(newStyle: fetchStyle.errorFont?.getTheme(FontErrorTheme()) ?? FontStyleBase().getTheme(FontErrorTheme()))
        freeText.applyNewStyle(newStyle: fetchStyle.freeText?.getTheme() ?? FreeTextStyle().getTheme())
        brand.applyNewStyle(newStyle: fetchStyle.branding?.getTheme() ?? BrandStyle().getTheme())
        invite.applyNewStyle(newStyle: fetchStyle.invite?.getTheme() ?? InviteTextStyle().getTheme())
        question.applyNewStyle(newStyle: fetchStyle.question?.getTheme() ?? QuestionTextStyle().getTheme())
        helper.applyNewStyle(newStyle: fetchStyle.helper?.getTheme() ?? HelperStyle().getTheme())
        surveyImg.applyNewStyle(newStyle: fetchStyle.surveyImg?.getTheme(SurveyImageTheme()) ?? ImageStyleBase().getTheme(SurveyImageTheme()))
        ansImg.applyNewStyle(newStyle: fetchStyle.ansImg?.getTheme(ResponseImageTheme()) ?? ImageStyleBase().getTheme(ResponseImageTheme()))
        pollBar.applyNewStyle(newStyle: fetchStyle.pollBar?.getTheme() ?? PollBarStyle().getTheme())
        if let style = fetchStyle.answersHelper {
            answersHelper.applyNewStyle(style)
        }
    }

    var hideLogo: Bool = false
    var textColor: ColorObject = ColorObject(textCode: ColorDefine.SurveyTextColorHex)
    var tableBorderColor: ColorObject = ColorObject(textCode: ColorDefine.TableBorderColorHex)
    var buttonColor: ColorObject = ColorObject(textCode: ColorDefine.ButtonColorHex)
    var buttonTextColor: ColorObject = ColorObject(textCode: ColorDefine.ButtonTextColorHex)
    var radioButtonColor: ColorObject = ColorObject(textCode: ColorDefine.RadioBtnBorderHex)
    var widgetButtonTextColor: ColorObject = ColorObject(textCode: ColorDefine.SurveyWidgetTextColorHex)
    var pollBarColor: ColorObject = ColorObject(textCode: ColorDefine.PollResultBarHex)

    func applyNewStyle(newStyle: ThemeStyles) {
        self.hideLogo = newStyle.hideLogo
        self.textColor.code = newStyle.textColor.code
        self.tableBorderColor.code = newStyle.tableBorderColor.code
        self.buttonColor.code = newStyle.buttonColor.code
        self.buttonTextColor.code = newStyle.buttonTextColor.code
        self.radioButtonColor.code = newStyle.radioButtonColor.code
        self.widgetButtonTextColor.code = newStyle.widgetButtonTextColor.code
        self.pollBarColor.code = newStyle.pollBarColor.code
    }
}
