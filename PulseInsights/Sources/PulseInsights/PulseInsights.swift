//
//  PulseInsightLibrary.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/14.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

import CoreMotion
import UIKit

open class PulseInsights: NSObject {
    private var mNowViewController: UIViewController?
    var surveyInlineResult: SurveyInlineResult?
    var surveyAnsweredListener: SurveyAnsweredListener?

    open class var getInstance: PulseInsights {
        if LocalConfig.instance.mPulseInsightLibraryItem == nil {
            LocalConfig.instance.mPulseInsightLibraryItem
                = PulseInsights(LocalConfig.instance.strAccountID,
                                enableDebugMode: LocalConfig.instance.bIsDebugModeOn,
                                automaticStart: LocalConfig.instance.surveyWatcherEnable)
        }
        return LocalConfig.instance.mPulseInsightLibraryItem!
    }
    open func configAccountID(_ accountID: String) {
        LocalConfig.instance.bIsSurveyAPIRunning = true
        LocalConfig.instance.strAccountID = accountID
        if !accountID.isEmpty {
            getUdid()
            LocalConfig.instance.iSurveyEventCode = Define.piEventCodeAccountReseted
        }
        LocalConfig.instance.bIsSurveyAPIRunning = false
    }

    public init( _ accountID: String, enableDebugMode: Bool = false,
                 automaticStart: Bool = true, previewMode: Bool = false,
                 customData: [String: String] = [String: String]()) {
        super.init()
        setupMotionSensor()
        LocalConfig.instance.surveyWatcherEnable = automaticStart
        LocalConfig.instance.previewMode = previewMode
        LocalConfig.instance.customData = customData
        configAccountID(accountID)
        _ = PIPreferencesManager.init()
        _ = self.getAppInstallDays()
//        self.setScanFrequency(LocalConfig.instance.iTimerDurationInSecond)
        LocalConfig.instance.mPulseInsightLibraryItem = self
        self.setDebugMode(enableDebugMode)
//        Registe custom font
//        do {
//            try UIFont.register(fileNameString: "XFINITYMStandard-Bold", type: "otf")
//            try UIFont.register(fileNameString: "XfinityStandard-Medium", type: "otf")
//            try UIFont.register(fileNameString: "XfinityStandard-Regular", type: "otf")
//        } catch let error {
//            print(error)
//        }
    }

    open func isSurveyScanWorking() -> Bool {
        return LocalConfig.instance.surveyWatcherEnable
    }

    open func switchSurveyScan(_ enable: Bool) {
        LocalConfig.instance.surveyWatcherEnable = enable
    }

    open func finishInlineMode() {
        self.surveyInlineResult = nil
        self.setScanFrequency(LocalConfig.instance.iTimerDurationInSecond)
        LocalConfig.instance.iSurveyEventCode = Define.piEventCodeSurveyJustClosed
    }

    open func setScanFrequency(_ frequencyInSecond: NSInteger) {
        if LocalConfig.instance.mScanTimer != nil {
            LocalConfig.instance.mScanTimer!.invalidate()
            LocalConfig.instance.mScanTimer = nil
        }
        if frequencyInSecond>0 {
            LocalConfig.instance.iTimerDurationInSecond = frequencyInSecond
            LocalConfig.instance.mScanTimer =
                Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                     selector: #selector(PulseInsights.timerActivity(_:)), userInfo: nil, repeats: true)

        }
    }

    @objc fileprivate func timerActivity(_ timer: Timer) {
        var doServe: Bool = false
        if LocalConfig.instance.surveyWatcherEnable {
            doServe =  checkConditionRunServe()
            if LocalConfig.instance.iSurveyEventCode != Define.piEventCodeNormal {
                if LocalConfig.instance.iSurveyEventCode == Define.piEventCodeSurveyJustClosed {
                    closeSurvey()
                } else if LocalConfig.instance.iSurveyEventCode == Define.piEventCodeAccountReseted {
                    doServe = true
                }
                LocalConfig.instance.iSurveyEventCode = Define.piEventCodeNormal
            }
            if LocalConfig.instance.bIsSurveyAPIRunning {
                doServe = false
            }
            if doServe {
                serve()
            }
        }
    }
    open func setHost(_ hostName: String) {
        PIPreferencesManager.sharedInstance.changeHostUrl(hostName)
    }

    open func inlineServe<InlineCallback: SurveyInlineResult>(_ callback: InlineCallback) {
        surveyInlineResult = callback
        serve()
    }

    open func setPreviewMode(_ enable: Bool) {
        if enable {
            UIApplication.shared.keyWindow?.showToast(text: "PreviewMode enable")
        } else {
            UIApplication.shared.keyWindow?.showToast(text: "PreviewMode disable")
        }
        LocalConfig.instance.previewMode = enable
    }

    open func isPreviewModeOn() -> Bool {
        return LocalConfig.instance.previewMode
    }

    open func setSurveyAnsweredListener(_ callback: SurveyAnsweredListener) {
        surveyAnsweredListener = callback
    }

    open func logAnswered(_ surveyId: String ) {
        PIPreferencesManager.sharedInstance.logAnsweredSurvey( surveyId )
        if surveyAnsweredListener != nil {
            surveyAnsweredListener?.onAnswered( surveyId )
        }
    }

    open func setDeviceData(_ dictData:[String: String] = [String: String]()) {
        PulseInsightsAPI.setDeviceData(dictData)
    }

    open func serve() {

        LocalConfig.instance.bIsSurveyAPIRunning = true
        LocalConfig.instance.iInstallDays = getAppInstallDays()
        PulseInsightsAPI.serve { (bSuccess) -> Void in
            if bSuccess {
                if !LocalConfig.instance.surveyPack.survey.surveyId.isEmpty {
                    self.getQuestionDetail()
                } else {
                    self.surveyInlineResult?.onFinish()
                    LocalConfig.instance.bIsSurveyAPIRunning = false
                }
            } else {
                self.surveyInlineResult?.onFinish()
                LocalConfig.instance.bIsSurveyAPIRunning = false
            }

        }

    }
    fileprivate func getQuestionDetail() {
        PulseInsightsAPI.getQuestionDetail { (bSucess) -> Void in
            if bSucess {
                let trackId = LocalConfig.instance.surveyPack.survey.inlineTrackId
                let noInlineTrigView = LocalConfig.instance.surveyPack.survey.surveyType != SurveyType.inline
                var doInline = false
                if !noInlineTrigView {
                    if let resultCb = LocalConfig.instance.inlineLink[trackId] {
                        if resultCb.onDisplay() {
                            doInline = true
                            self.surveyInlineResult = resultCb
                        }
                    }
                }
                if noInlineTrigView || doInline {
                    self.delayDisplaySurvey()
                } else {
                    LocalConfig.instance.bIsSurveyAPIRunning = false
                }
            } else {
                self.surveyInlineResult?.onFinish()
                LocalConfig.instance.bIsSurveyAPIRunning = false
            }
        }
    }
    open func present(_ surveyID: String) {
        LocalConfig.instance.strCheckingSurveyID = surveyID
        LocalConfig.instance.bIsSurveyAPIRunning = true
        PulseInsightsAPI.getSurveyInformation(with: surveyID) { (_ bSuccess) -> Void in
            if !LocalConfig.instance.surveyPack.survey.surveyId.isEmpty {
                self.getQuestionDetail()
            } else {
                self.surveyInlineResult?.onFinish()
                LocalConfig.instance.bIsSurveyAPIRunning = false
            }

        }
    }

    open func setDebugMode(_ enable: Bool) {
        PIPreferencesManager.sharedInstance.changeDebugModeSetting(enable)
    }
    open func resetUdid() {
//        if !LocalConfig.instance.bIsSurveyAPIRunning {
            LocalConfig.instance.bIsSurveyAPIRunning = true
            PIPreferencesManager.sharedInstance.resetDeviceUdid()
            getUdid()
            LocalConfig.instance.iSurveyEventCode = Define.piEventCodeAccountReseted
            LocalConfig.instance.bIsSurveyAPIRunning = false
//        } else {
//            DebugTool.debugPrintln("resetUdid", strMsg: "Can not reset UDID because the active survey not end yet")
//        }

    }

    open func getViewController() -> UIViewController {
        return mNowViewController!
    }

    open func setViewController(_ controller: UIViewController) {
        mNowViewController = controller
    }

    open func setViewName(_ viewName: String, controller: UIViewController) {
        setViewController(controller)
        LocalConfig.instance.strRunningViewName = viewName
        LocalConfig.instance.strViewName = viewName
    }

    open func setClientKey(_ clientId: String) {
        PIPreferencesManager.sharedInstance.setClientKey( clientId )
    }

    open func getClientKey() -> String {
        return PIPreferencesManager.sharedInstance.getClientKey()
    }

    open func checkSurveyAnswered(_ surveyId: String ) -> Bool {
        return PIPreferencesManager.sharedInstance.isSurveyAnswered( surveyId )
    }

    fileprivate func getAppInstallDays() -> NSInteger {
        var iResult: NSInteger = 0
        iResult = PIPreferencesManager.sharedInstance.getInstalledDays()
        return iResult
    }
    fileprivate func getUdid() {
        LocalConfig.instance.strUDID = PIPreferencesManager.sharedInstance.getDeviceUdid()

        if LocalConfig.instance.strUDID.isEmpty {
            LocalConfig.instance.strUDID = Udid.getUdid()
            PIPreferencesManager.sharedInstance.setAccountData( LocalConfig.instance.strUDID )
        }

    }
    fileprivate func checkConditionRunServe() -> Bool {
        var bResult: Bool = false

//        let iTmpInstallDays: NSInteger = getAppInstallDays()
        let iTmpInstallDays: NSInteger = 1
        if LocalConfig.instance.iInstallDays != iTmpInstallDays {
            bResult = true
        }
        LocalConfig.instance.iInstallDays = iTmpInstallDays
        let strTmpViewName: String = LocalConfig.instance.strRunningViewName
        if strTmpViewName != LocalConfig.instance.strViewName && !strTmpViewName.isEmpty {
            bResult = true
        }
        if !strTmpViewName.isEmpty {
            LocalConfig.instance.strViewName = strTmpViewName
        }
        if LocalConfig.instance.strAccountID.isEmpty {
            bResult = false
        }
        return bResult
    }
    fileprivate func closeSurvey() {
        LocalConfig.instance.bIsSurveyAPIRunning = true
        cleanUpInitViews()
        PulseInsightsAPI.postClose { (_ bSuccess) -> Void in
            self.surveyInlineResult?.onFinish()
            LocalConfig.instance.bIsSurveyAPIRunning = false
        }

    }

    var motionManager:CMMotionManager?

    var xInPositiveDirection = 0.0
    var xInNegativeDirection = 0.0
    var shakeCount = 0
    var motionResetTimer: Timer?

    @objc fileprivate func timerResetMotionSenser(_ timer: Timer) {
        resetMotionSenser()
    }

    fileprivate func resetMotionSenser() {
        self.shakeCount = 0
        self.xInPositiveDirection = 0.0
        self.xInNegativeDirection = 0.0
    }
    fileprivate func setupMotionSensor() {
        if motionManager == nil {
            motionManager = CMMotionManager()
        }

        if motionManager!.isDeviceMotionActive {
            print("DeviceMotion on")
        } else {
            motionManager!.startDeviceMotionUpdates()
            print("DeviceMotion off")
        }
        //motionManager!.deviceMotionUpdateInterval = 0.02
        motionManager!.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
            (data, error) in

            if data!.userAcceleration.x > 1.0 || data!.userAcceleration.x < -1.0 {

                if data!.userAcceleration.x > 1.0 {
                    self.xInPositiveDirection = data!.userAcceleration.x
                }

                if data!.userAcceleration.x < -1.0 {
                    self.xInNegativeDirection = data!.userAcceleration.x
                }

                if self.xInPositiveDirection != 0.0 && self.xInNegativeDirection != 0.0 {
                    if self.shakeCount == 0 {
                        self.motionResetTimer =
                            Timer.scheduledTimer(timeInterval: 3.0, target: self,
                                                 selector: #selector(PulseInsights.timerResetMotionSenser(_:)), userInfo: nil, repeats: false)
                    }
                    self.shakeCount += 1
                    self.xInPositiveDirection = 0.0
                    self.xInNegativeDirection = 0.0
                }

                if self.shakeCount > 10 {
                    UIApplication.shared.keyWindow?.showToast(text: "Shaked")

                    self.setPreviewMode(!self.isPreviewModeOn())
                    self.resetMotionSenser()

                }

            }
        })

    }

    fileprivate func delayDisplaySurvey() {
        if LocalConfig.instance.delayTriggerTimer != nil {
            LocalConfig.instance.delayTriggerTimer!.invalidate()
            LocalConfig.instance.delayTriggerTimer = nil
        }
        let enableDelayTrigger: Bool = LocalConfig.instance.surveyPack.survey.enablePendingStart
        let assignDelayTime: NSInteger = (enableDelayTrigger) ? LocalConfig.instance.surveyPack.survey.pendingStartTime : 0
        DebugTool.debugPrintln("delayDisplaySurvey", strMsg: "Setup timer with the assign interval: \(assignDelayTime)")
        LocalConfig.instance.delayTriggerTimer =
            Timer.scheduledTimer(timeInterval: TimeInterval(assignDelayTime), target: self,
                                 selector: #selector(PulseInsights.delayTriggerActivity(_:)), userInfo: nil, repeats: false)
    }

    @objc fileprivate func delayTriggerActivity(_ timer: Timer) {
        DebugTool.debugPrintln("delayDisplaySurvey", strMsg: "Triggered timer")
        self.displaySurvey()
    }
    private var surveyController: SurveyMainViewController?

    func cleanUpInitViews(forceClean: Bool = false) {
        if surveyController != nil {
            if forceClean {
                surveyController?.dismiss(animated: true, completion: nil)
            }
            surveyController = nil
        }
    }

    fileprivate func displaySurvey() {
        PulseInsightsAPI.viewedAt { bResult in
            DebugTool.debugPrintln("viewedAt request", strMsg: "result: \(bResult)")
        }
        if surveyInlineResult != nil {
            surveyInlineResult?.onServeResult()
        } else {
            cleanUpInitViews(forceClean: true)
            openServeyView()
        }
    }
    open func openServeyView() {
        if mNowViewController != nil {
            surveyController = SurveyMainViewController()
            if let vcSurveyMain = surveyController {
                vcSurveyMain.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
                mNowViewController!.present(vcSurveyMain, animated: true, completion: nil)
            }
        }
    }

    open func cleanup() {
        // Clear controllers and views
        if let controller = surveyController {
            controller.cleanup()
        }
        surveyController = nil
        mNowViewController = nil
        
        // Clear delegates and listeners
        surveyInlineResult = nil
        surveyAnsweredListener = nil
        
        // Clear timers
        if LocalConfig.instance.mScanTimer != nil {
            LocalConfig.instance.mScanTimer!.invalidate()
            LocalConfig.instance.mScanTimer = nil
        }
        
        if LocalConfig.instance.delayTriggerTimer != nil {
            LocalConfig.instance.delayTriggerTimer?.invalidate()
            LocalConfig.instance.delayTriggerTimer = nil
        }
        
        // Clear motion manager
        motionManager?.stopDeviceMotionUpdates()
        motionManager = nil
        motionResetTimer?.invalidate()
        motionResetTimer = nil
        
        // Reset local config
        LocalConfig.instance.reset()
    }
}

extension PulseInsights: SurveyViewResult {
    public func onFinish() {
        // Clean up all resources
        cleanup()
    }
}
extension PulseInsights: WidgetViewResult {
    public func onTouch(_ doClose: Bool) {
        if doClose {

        } else {
            openServeyView()
        }
    }
}
