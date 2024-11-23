//
//  SurveyCover.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/23.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

// MARK: SurveyType
// Base on the defination in the backend logic, possible value are [0, 4]
// https://gitlab.ekohe.com/ekohe/pi/-/blob/staging/app/models/survey.rb#L15
// docked_widget: 0,
// inline: 1,
// top_bar: 2,
// bottom_bar: 3,
// fullscreen: 4,
// In SDK logic, we render the ticket as inline when value return 1 and pop-up the docked widget when other value return
enum SurveyType {
    case docked_widget
    case inline
    case bottom_bar
}

class SurveyCover: Decodable {
    var id: Int?
    var survey_type: Int?
    var sdk_widget_height: Int?
    var raw_invitation: String?
    var invitation_button: String?
    var invitation_button_disabled: String?
    var thank_you: String?
    var raw_background: String?
    var render_after_x_seconds_enabled: String?
    var render_after_x_seconds: Int?
    var sdk_inline_target_selector: String?
    var theme_native: RemoteTheme?
    var display_all_questions: String?
    var all_at_once_empty_error_enabled: String?
    var all_at_once_submit_label: String?
    var all_at_once_error_text: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case survey_type
        case sdk_widget_height
        case raw_invitation = "invitation"
        case invitation_button
        case invitation_button_disabled
        case thank_you
        case raw_background = "background"
        case render_after_x_seconds_enabled
        case render_after_x_seconds
        case sdk_inline_target_selector
        case theme_native
        case display_all_questions
        case all_at_once_empty_error_enabled
        case all_at_once_submit_label
        case all_at_once_error_text
    }
}
extension SurveyCover {
    var surveyId: String {
        if let id = id {
            return String(id)
        } else {
            return ""
        }
    }
    var widgetHeight: Int {
        return sdk_widget_height ?? 0
    }
    var surveyType: SurveyType {
        // For now, we have the 5 different types from the backend into the three group
        // Group A: Docked Widget ( survey_type = 0 ), Fullscreen ( survey_type = 4 )
        // Group B: Inline ( survey_type = 1 )
        // Group C: Top Bar ( survey_type = 2 ), Bottom Bar ( survey_type = 3 )
        let type = survey_type ?? 0
        if type == 0 || type == 4 {
            return SurveyType.docked_widget
        } else if type == 1 {
            return SurveyType.inline
        } else {
            return SurveyType.bottom_bar
        }
    }
    var invitation: String {
        return raw_invitation ?? ""
    }
    var invitationButton: String {
        return invitation_button ?? ""
    }
    var invitationButtonDisable: Bool {
        let disable = invitation_button_disabled ?? "f"
        return disable.lowercased() == "t"
    }
    var thankYouMsg: String {
        return thank_you ?? ""
    }
    var background: String {
        let url = raw_background ?? ""
        return url.hasPrefix("//") ? "https:\(url)" : url
    }
    var enablePendingStart: Bool {
        let enable = render_after_x_seconds_enabled ?? "f"
        return enable.lowercased() == "t"
    }
    var pendingStartTime: Int {
        return render_after_x_seconds ?? 0
    }
    var inlineTrackId: String {
        return sdk_inline_target_selector ?? ""
    }
    var displayAllQuestions: Bool {
        let enable = display_all_questions ?? "f"
        return enable.lowercased() == "t"
    }
    var allAtOnceEmptyErrorEnabled: Bool {
        let enable = all_at_once_empty_error_enabled ?? "f"
        return enable.lowercased() == "t"
    }
    var allAtOnceSubmitLabel: String {
        return all_at_once_submit_label ?? "Submit all"
    }
    var allAtOnceErrorText: String {
        return all_at_once_error_text ?? ""
    }
}
