//
//  PIPreferencesManager.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/16.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

let piDeviceUdid: String = "DEVICE_UDID"
let piIsDebugModeEnable: String = "IS_DEBUG_MODE_ENABLE"
let piServerHost: String = "SERVER_HOST"
let piLaunchCount: String = "LAUNCH_COUNT"
let piClientKey: String = "CLIENT_KEY"
let piFirstLaunchTime: String = "FIRST_LAUNCH_TIME"
let piSurveyHistory: String = "SURVEY_HISTORY"

class PIPreferencesManager {
    
    static let sharedInstance = PIPreferencesManager()
    
    private var iLaunchCount: NSInteger = 0
    private var strHostUrl: String = ""
    private var strClientKey: String = ""
    private var bIsDebugModeOn: Bool = false
    private var mFirstLaunchTime: Date?

    init() {

        iLaunchCount = UserDefaults.standard.integer(forKey: piLaunchCount)
        if !LocalConfig.instance.bIsAPPStarted {
            LocalConfig.instance.bIsAPPStarted = true
            addLaunchCount()
        }
        DebugTool.debugPrintln("PIPreferencesManager/init/Launch count", strMsg: String(iLaunchCount))
        bIsDebugModeOn = UserDefaults.standard.bool(forKey: piIsDebugModeEnable)
        LocalConfig.instance.bIsDebugModeOn = bIsDebugModeOn
        DebugTool.debugPrintln("PIPreferencesManager/init/Debug Mode", strMsg: String(bIsDebugModeOn))
        let mTmpObjCliKey = UserDefaults.standard.object(forKey: piClientKey)
        if let tmpKey = ( mTmpObjCliKey != nil && mTmpObjCliKey is String ) ? ( mTmpObjCliKey as? String ) : "" {
            strClientKey = tmpKey
        }
        let mTmpObjUrl = UserDefaults.standard.object(forKey: piServerHost)
        if let tmpUrl = ( mTmpObjUrl != nil && mTmpObjUrl is String ) ? ( mTmpObjUrl as? String ) : "" {
            strHostUrl = tmpUrl
        }
        strHostUrl = ( strHostUrl != "" ) ? strHostUrl : "survey.pulseinsights.com"
        DebugTool.debugPrintln("PIPreferencesManager/init/Host url", strMsg: String(strHostUrl))
        let mTmpObjDate = UserDefaults.standard.object(forKey: piFirstLaunchTime)
        if mTmpObjDate != nil && mTmpObjDate is NSDate {
            mFirstLaunchTime = mTmpObjDate as? Date
        } else {
            mFirstLaunchTime = Date()
            UserDefaults.standard.set(mFirstLaunchTime, forKey: piFirstLaunchTime)
            UserDefaults.standard.synchronize()
        }
        DebugTool.debugPrintln("PIPreferencesManager/init/First launch time",
                               strMsg: String(describing: mFirstLaunchTime))

    }
    func logAnsweredSurvey(_ surveyId: String) {
        var logs = UserDefaults.standard.stringArray(forKey: piSurveyHistory) ?? [String]()
        if !logs.contains( surveyId ) {
            logs.append( surveyId )
            UserDefaults.standard.set(logs, forKey: piSurveyHistory)
            UserDefaults.standard.synchronize()
        }
    }
    func isSurveyAnswered(_ surveyId: String) -> Bool {
        let logs = UserDefaults.standard.stringArray(forKey: piSurveyHistory) ?? [String]()
        let rtRes = logs.contains( surveyId )
        return rtRes
    }
    func getInstalledDays() -> NSInteger {
        let iDiffSec = Date().timeIntervalSince(mFirstLaunchTime!)
        DebugTool.debugPrintln("PIPreferencesManager/getInstalledDays/iDiffsec",
                               strMsg: String(describing: mFirstLaunchTime))
        let iDiffDays: NSInteger = Int(iDiffSec)/( 60*60*24 )
        DebugTool.debugPrintln("PIPreferencesManager/getInstalledDays/return days",
                               strMsg: String(describing: mFirstLaunchTime))
        return iDiffDays
    }
    func changeHostUrl(_ strSetHost: String) {
        strHostUrl = strSetHost
        UserDefaults.standard.set(strHostUrl, forKey: piServerHost)
        UserDefaults.standard.synchronize()
        DebugTool.debugPrintln("PIPreferencesManager/changeHostUrl/new applied", strMsg: String(strHostUrl))
    }
    func getLaunchCount() -> NSInteger {
        DebugTool.debugPrintln("PIPreferencesManager/getLaunchCount/returned count", strMsg: String(iLaunchCount))
        return iLaunchCount
    }
    func addLaunchCount() {
        iLaunchCount+=1
        UserDefaults.standard.set(iLaunchCount, forKey: piLaunchCount)
        UserDefaults.standard.synchronize()
        DebugTool.debugPrintln("PIPreferencesManager/addLaunchCount/updated count", strMsg: String(iLaunchCount))
    }
    func setClientKey(_ clientKet: String) {
        strClientKey = clientKet
        UserDefaults.standard.set(strClientKey, forKey: piClientKey)
        UserDefaults.standard.synchronize()
    }
    func getClientKey() -> String {
        DebugTool.debugPrintln("PIPreferencesManager/getServerHost/returned client key", strMsg: String(strClientKey))
        return strClientKey
    }
    func getServerHost() -> String {
        DebugTool.debugPrintln("PIPreferencesManager/getServerHost/returned url", strMsg: String(strHostUrl))
        return strHostUrl
    }
    func changeDebugModeSetting( _ bModeEnable: Bool ) {
        bIsDebugModeOn = bModeEnable
        LocalConfig.instance.bIsDebugModeOn = bIsDebugModeOn
        DebugTool.debugPrintln("PIPreferencesManager/changeDebugModeSetting", strMsg: String(bIsDebugModeOn))
        UserDefaults.standard.set(bIsDebugModeOn, forKey: piIsDebugModeEnable)
        UserDefaults.standard.synchronize()
        DebugTool.debugPrintln("PIPreferencesManager/changeDebugModeSetting", strMsg: String(bIsDebugModeOn))
    }
    func isDebugModeEnable() -> Bool {
        return bIsDebugModeOn
    }
    func setAccountData(_ strDevUDID: String ) {
        DebugTool.debugPrintln("PIPreferencesManager/setAccountData/strDevUDID", strMsg: String(strDevUDID))
        UserDefaults.standard.set(strDevUDID, forKey: piDeviceUdid)
        UserDefaults.standard.synchronize()
    }
    func getDeviceUdid() -> String {
        //var strRtResult: String = ""
        let mTmpObj = UserDefaults.standard.object(forKey: piDeviceUdid)
        guard let strRtResult = (mTmpObj != nil && mTmpObj is String) ? (mTmpObj as? String) : "" else {
            return ""
        }

        DebugTool.debugPrintln("PIPreferencesManager/getDeviceUdid", strMsg: String(piDeviceUdid))
        return strRtResult
    }
    func resetDeviceUdid() {
        DebugTool.debugPrintln("PIPreferencesManager/resetDeviceUdid", strMsg: String(piDeviceUdid))
        UserDefaults.standard.set([String](), forKey: piSurveyHistory)
        UserDefaults.standard.set("", forKey: piDeviceUdid)
        UserDefaults.standard.synchronize()
    }
}
