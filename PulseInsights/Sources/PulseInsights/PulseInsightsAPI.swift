//
//  PulseInsightsAPI.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/19.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

class PulseInsightsAPI {

    class func commonPropSet() -> [String: String] {
        return [
            "udid": LocalConfig.instance.strUDID,
            "device_type": LocalConfig.instance.strDeviceType,
            "mobile_type": LocalConfig.instance.strMobileType,
            "identifier": LocalConfig.instance.strAccountID,
            "install_days": String(PIPreferencesManager.sharedInstance.getInstalledDays()),
            "launch_times": String(PIPreferencesManager.sharedInstance.getLaunchCount()),
            "preview_mode": String(LocalConfig.instance.previewMode),
            "view_name": LocalConfig.instance.strViewName,
        ]
    }

    class func composeUrlString(path: String = "", queryProps: [String: String] = [String: String]()) -> String {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = PIPreferencesManager.sharedInstance.getServerHost()
        if !path.isEmpty {
            urlComponent.path = path
        }
        if !queryProps.isEmpty {
            urlComponent.queryItems = queryProps.urlQueryItems
        }
        let urlStr = urlComponent.url?.absoluteString ?? ""
        DebugTool.debugPrintln("PulseInsightsAPI/URLComponents", strMsg: urlStr)
        return urlStr
    }

    class func serve(_ callback:@escaping (_ bResult: Bool) -> Void) {
        let clientKey: String = PIPreferencesManager.sharedInstance.getClientKey()
        var props = commonPropSet()

        var customData: [String: String] = LocalConfig.instance.customData
        if !clientKey.isEmpty {
            props["client_key"] = PIPreferencesManager.sharedInstance.getClientKey()
        }
        if !customData.isEmpty {
            props["custom_data"] = customData.stringify
        }

        let urlStr = composeUrlString(path: "/serve", queryProps: props)
        HttpCore.requestUrl(urlStr) { (data) -> Void in
            DebugTool.debugPrintln("PulseInsightsAPI/serve", strMsg: data)
            if data != "error"{
                JSONDataParser.parseSurveyPack(data) {
                    (success) -> Void in
                    if success && !LocalConfig.instance.surveyPack.survey.surveyId.isEmpty {
                        LocalConfig.instance.strCheckingSurveyID =
                            LocalConfig.instance.surveyPack.survey.surveyId
                    }
                    callback(success)
                }
            } else {
                callback(false)
            }
        }

    }

    class func setDeviceData(_ dictData:[String: String] = [String: String]()) {
        var mapData = dictData
        mapData["identifier"] = LocalConfig.instance.strAccountID

        let queryUrl = composeUrlString(path: "/devices/\(LocalConfig.instance.strUDID)/set_data", queryProps: mapData)
        HttpCore.requestUrl(queryUrl
        ) { (data) -> Void in
            DebugTool.debugPrintln("PulseInsightsAPI/setDeviceData", strMsg: data)
        }

    }

    class func getSurveyInformation(with id: String, _ callback:@escaping (_ bResult: Bool) -> Void) {
        // Ensure the id is not empty
        guard !id.isEmpty else {
            callback(false)
            return
        }
        let queryUrl = composeUrlString(path: "/surveys/\(id)", queryProps: commonPropSet())
        HttpCore.requestUrl(queryUrl
        ) { (data) -> Void in
            DebugTool.debugPrintln("PulseInsightsAPI/getSurveyInformation", strMsg: data)
            if data != "error"{
                JSONDataParser.parseSurveyPack(data) {
                    (success) -> Void in
                    callback(success)
                }
            } else {
                callback(false)
            }
        }

    }

    class func postAnswers( _ strPostAnswers: String, strQuestionID: String, strQuestiontype: String,
                            callback:@escaping (_ bResult: Bool) -> Void ) {
        var str_qidTagName: String = "answer_id"
        let checkType = strQuestiontype
        if checkType == Define.piSurveyTypeFreeTextQuestion {
            str_qidTagName = "text_answer"
        } else if checkType == Define.piSurveyTypeSingleChoiseQuestion {
            str_qidTagName = "answer_id"
        } else if checkType == Define.piSurveyTypeMultiChoiseQuestion {
            str_qidTagName = "check_boxes"
        }
        let props = [
            "identifier": LocalConfig.instance.strAccountID,
            "question_id": strQuestionID,
            str_qidTagName: strPostAnswers,
        ]
        let queryUrl = composeUrlString(path: "/submissions/\(LocalConfig.instance.strSubmitID)/answer", queryProps: props)
        HttpCore.requestUrl(queryUrl) { (data) -> Void in
            if data != "error"{
                if checkPollParserElement(checkType) {
                    JSONDataParser.parsePollResult(data, title: getTitleById(strQuestionID)) {
                        (success) -> Void in
                    }
                }
                callback(true)
            } else {
                callback(false)
            }
        }
    }
    class func postAllAtOnce( _ answers: [SurveyAnswer], callback:@escaping (_ bResult: Bool) -> Void ) {
        var props = commonPropSet()
        props["identifier"] = LocalConfig.instance.strAccountID

        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(answers) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                props["answers"] = jsonString
            }
        }
        
        let queryUrl = composeUrlString(path: "/submissions/\(LocalConfig.instance.strSubmitID)/all_answers", queryProps: props)

        HttpCore.requestUrl(queryUrl) { (data) -> Void in
            if data != "error"{
                callback(true)
            } else {
                callback(false)
            }
        }
    }
    class func checkPollParserElement(_ strQuestionType: String) -> Bool {
        var shouldParsePoll: Bool = false
        if strQuestionType == Define.piSurveyTypeSingleChoiseQuestion {
            shouldParsePoll = true
        } else if strQuestionType == Define.piSurveyTypeMultiChoiseQuestion {
            shouldParsePoll = true
        }
        return shouldParsePoll
    }
    class func getTitleById(_ questionId: String) -> String {
        var rtTitle = ""
        for  item: SurveyTicket in LocalConfig.instance.surveyTickets where questionId == item.surveyId {
                rtTitle = item.content
                break
        }
        return rtTitle
    }

    class func postClose(_ callback:@escaping (_ bResult: Bool) -> Void) {
        let queryUrl = composeUrlString(path: "/submissions/\(LocalConfig.instance.strSubmitID)/close")
        HttpCore.requestUrl(queryUrl) { (data) -> Void in
            if data != "error"{
                callback(true)
            } else {
                callback(false)
            }
        }
    }
    class func getQuestionDetail(_ callback:@escaping (_ bResult: Bool) -> Void) {

        let queryMap = [
            "identifier" : LocalConfig.instance.strAccountID
        ]
        let queryUrl = composeUrlString(path: "/surveys/\(LocalConfig.instance.strCheckingSurveyID)/questions", queryProps: queryMap)
        HttpCore.requestUrl(queryUrl) { (data: String) -> Void in
            if data != "error"{
                LocalConfig.instance.surveyTickets = [SurveyTicket]()
                LocalConfig.instance.pollResults = [PollResult]()

                JSONDataParser.parseSurveyTickets(data) {
                    (success) -> Void in
                    callback(success)
                }
            } else {
                callback(false)
            }
        }
    }
}
