//
//  RemoteTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class RemoteTheme: Decodable {

    var widget: WidgetStyle?
    var closeBtn: CloseBtnStyle?
    var ansBtn: AnswerBtnStyle?
    var radio: RadioBtnStyle?
    var submitBtn: SubmitBtnStyle?
    var checkbox: CheckBoxStyle?
    var checkmark: CheckMarkStyle?
    var largeFont: FontStyleBase?
    var mediumFont: FontStyleBase?
    var smallFont: FontStyleBase?
    var errorFont: FontStyleBase?
    var freeText: FreeTextStyle?
    var branding: BrandStyle?
    var invite: InviteTextStyle?
    var question: QuestionTextStyle?
    var helper: HelperStyle?
    var surveyImg: ImageStyleBase?
    var ansImg: ImageStyleBase?
    var pollBar: PollBarStyle?
    var answersHelper: AnswersHelperStyle?

    private enum CodingKeys: String, CodingKey {
        case widget
        case closeBtn = "close-button"
        case ansBtn = "answer-button"
        case radio = "radio-button"
        case submitBtn = "submit-button"
        case checkbox
        case checkmark
        case largeFont = "font-large"
        case mediumFont = "font-medium"
        case smallFont = "font-small"
        case errorFont = "question-error-text"
        case freeText = "free-text"
        case branding
        case invite = "invitation-text"
        case question = "question-text"
        case helper
        case surveyImg = "survey-image"
        case ansImg = "response-image"
        case pollBar = "poll-bar"
        case answersHelper = "answers-helper"
    }

}
