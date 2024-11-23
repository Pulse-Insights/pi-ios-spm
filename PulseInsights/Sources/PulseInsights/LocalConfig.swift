//
//  LocalConfig.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/19.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

class LocalConfig {

    static let instance = LocalConfig()

    //Local Operate
    var strUDID: String = ""
    var strSubmitID: String = ""
    var strAccountID: String = ""
    var strCheckingSurveyID: String = ""
    var strDeviceType: String = "native_mobile"
    var strMobileType: String = "ios"
    var iInstallDays: NSInteger = 0
    var strViewName: String = ""
    var strRunningViewName: String = ""
    var surveyWatcherEnable: Bool = true
    var bIsAPPStarted: Bool = false
    var bIsSurveyAPIRunning: Bool = false
    var iSurveyEventCode: NSInteger = 0
    var iTimerDurationInSecond: NSInteger = 1
    var bIsDebugModeOn: Bool = false
    var previewMode: Bool = false
    var customData = [String : String]()
    var themeStyle: ThemeStyles = ThemeStyles()
    var inlineLink = [String : SurveyInlineResult]()

    var mScanTimer: Timer?
    var delayTriggerTimer: Timer?
    var bTestModeEnable: Bool = false;//For Test only, but need to set back as false when release
    var mPulseInsightLibraryItem: PulseInsights?

    var surveyPack = Survey()
    var surveyTickets = [SurveyTicket]()
    var pollResults = [PollResult]()

    init() {

    }

}
