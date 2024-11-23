//
//  JSONDataParser.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/14.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

open class JSONDataParser {

    class func parseSurveyPack(_ data: String, callback:@escaping (_ strResult: Bool) -> Void) {
        do {
            let receivedPack = try JSONDecoder().decode(Survey.self, from:data.data(using: .utf8)!)
            LocalConfig.instance.surveyPack = receivedPack
            LocalConfig.instance.strSubmitID = receivedPack.submission.udid
            if let newTheme = receivedPack.survey.theme_native {
                LocalConfig.instance.themeStyle.updateAssignTheme(newTheme)
            } else {
                LocalConfig.instance.themeStyle.updateAssignTheme(RemoteTheme())
            }
            callback(true)
        } catch {
            print("caught: \(error)")
            callback(false)
        }
    }

    class func parseSurveyTickets(_ data: String, callback:@escaping (_ strResult: Bool) -> Void) {
        let m_data: String = ( data.hasPrefix("(") && (data.hasSuffix(")") || data.hasSuffix(");")) ) ?
            String(data[(
                data.index(data.startIndex, offsetBy: 1) ..< data.index(data.endIndex, offsetBy: -2))])
            :data
        do {
            LocalConfig.instance.surveyTickets = try JSONDecoder().decode([SurveyTicket].self, from:m_data.data(using: .utf8)!)
        } catch {
            print("caught: \(error)")
        }
        callback(true)
    }

    class func parsePollResult(_ data: String, title: String, callback:@escaping (_ strResult: Bool) -> Void) {
        let m_data: String = ( data.hasPrefix("(") && (data.hasSuffix(")") || data.hasSuffix(");")) ) ?
            String(data[(
                data.index(data.startIndex, offsetBy: 1) ..< data.index(data.endIndex, offsetBy: -2))])
            :data
        if (m_data != "{}")&&(m_data != "") {
            let pollResult = PollResult()
            pollResult.title = title
            do {
                pollResult.countAnswers = try JSONDecoder().decode([AnswerOption].self, from:m_data.data(using: .utf8)!)
            } catch {
                print("caught: \(error)")
            }
            LocalConfig.instance.pollResults.append(pollResult)
        }
    }

    class func parseArray<T: Decodable>(with jsonStr: String?, elementType: T.Type)  -> [T] {
        guard let text = jsonStr, !text.isEmpty else { return [] }

        if let data = text.data(using: .utf8),
           let array = try? JSONDecoder().decode([T].self, from: data) {
            return array
        }
        return []
    }
}
