//
//  SurveyTicket.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/22.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class SurveyTicket: Decodable {

    var id: Int?
    var rawContent: String?
    var rawPosition: Int?
    var question_type: String?
    var submit_label: String?
    var answers_per_row_mobile: Int?
    var possible_answers: [SelectOption]?
    var maximum_selection: Int?
    var hint_text: String?
    var max_length: Int?
    var next_question_id: Int?
    var rawFullscreen: String?
    var background_color: String?
    var rawOpacity: String?
    var autoclose_enabled: String?
    var autoclose_delay: Int?
    var autoredirect_enabled: String?
    var autoredirect_delay: Int?
    var autoredirect_url: String?
    var before_question_text: String?
    var after_question_text: String?
    var rawNps: String?
    var before_answers_items: String?
    var after_answers_items: String?
    var isOptional: String?
    var empty_error_text: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case rawContent = "content"
        case rawPosition = "position"
        case question_type
        case submit_label
        case answers_per_row_mobile
        case possible_answers
        case maximum_selection
        case hint_text
        case max_length
        case next_question_id
        case rawFullscreen = "fullscreen"
        case background_color
        case rawOpacity = "opacity"
        case autoclose_enabled
        case autoclose_delay
        case autoredirect_enabled
        case autoredirect_delay
        case autoredirect_url
        case before_question_text
        case after_question_text
        case rawNps = "nps"
        case before_answers_items
        case after_answers_items
        case isOptional = "optional"
        case empty_error_text
    }
}
extension SurveyTicket {
    var surveyId: String {
        if let id = id {
            return String(id)
        } else {
            return ""
        }
    }
    var nps: Bool {
        return rawNps == "t"
    }
    var answersPerRow: Int {
        return answers_per_row_mobile ?? 1
    }
    var questionType: String {
        return question_type ?? ""
    }
    var position: String {
        if let rtPos = rawPosition {
            return String(rtPos)
        } else {
            return ""
        }
    }
    var content: String {
        return rawContent ?? ""
    }
    var possibleAnswers: [SelectOption] {
        return possible_answers ?? [SelectOption]()
    }
    var submitLabel: String {
        return submit_label ?? ""
    }
    var maximumSelection: Int {
        return maximum_selection ?? -1
    }
    var hintText: String {
        return hint_text ?? ""
    }
    var maxLength: Int {
        return max_length ?? 0
    }
    var nextQuestionId: String {
        if let qusId = next_question_id {
            return String(qusId)
        } else {
            return ""
        }
    }
    var fullscreen: String {
        return rawFullscreen ?? ""
    }
    var backgroundColor: String {
        return background_color ?? ""
    }
    var opacity: String {
        if let opac = rawOpacity {
            return String(opac)
        } else {
            return ""
        }
    }
    var autoCloseEnabled: Bool {
        autoclose_enabled == "t"
    }
    var autoCloseDelay: Int {
        return Int(autoclose_enabled ?? "0") ?? 0
    }
    var autoRedirectEnabled: Bool {
        autoredirect_enabled == "t"
    }
    var autoRedirectDelay: Int {
        return autoredirect_delay ?? 0
    }
    var autoRedirectUrl: String {
        return autoredirect_url ?? ""
    }
    var beforeHelper: String {
        return before_question_text ?? ""
    }
    var afterHelper: String {
        return after_question_text ?? ""
    }

    var beforeAnswersItems: [String] {
        return JSONDataParser.parseArray(with: before_answers_items, elementType: String.self)
    }

    var afterAnswersItems: [String] {
        return JSONDataParser.parseArray(with: after_answers_items, elementType: String.self)
    }
    
    var isQuestionOptional: Bool {
        return isOptional == "t"
    }
}
