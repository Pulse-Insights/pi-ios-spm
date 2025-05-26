//
//  InlineSurveyView.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/06.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

open class InlineSurveyView: SurveyView {
    @objc public var viewOnDisplay = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        switchInlineType(true)
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        switchInlineType(true)
    }

    convenience public init(identifier: String) {
        self.init(frame: CGRect.zero)
        self.setIdentifier(identifier)
    }

    override open func removeFromSuperview() {
        super.removeFromSuperview()
        viewOnDisplay = false
        PulseInsights.getInstance.finishInlineMode()
    }

    override open func addSubview(_ view: UIView) {
        super.addSubview(view)
        viewOnDisplay = true
        closeView()
    }

    @IBInspectable var identifier : String = ""{
        didSet {
            self.setIdentifier(identifier)
        }
    }

    open func setIdentifier(_ className: String) {
        if !trackClassName.isEmpty {
            LocalConfig.instance.inlineLink.removeValue(forKey: trackClassName)
        }
        trackClassName = className
        self.inlineEnable = !self.trackClassName.isEmpty
        if inlineType && inlineEnable {
            LocalConfig.instance.inlineLink[trackClassName] = self
        }
    }

}
extension InlineSurveyView: SurveyInlineResult {
    public func onServeResult() {
        setupSurveyContent(LocalConfig.instance.surveyTickets)
    }

    public func onFinish() {
        // Post notification for React Native bridge
        NotificationCenter.default.post(name: NSNotification.Name("PulseInsightsInlineSurveyFinished"), object: nil)
        
        finish()
    }

    public func onDisplay() -> Bool {
        return viewOnDisplay
    }
}
