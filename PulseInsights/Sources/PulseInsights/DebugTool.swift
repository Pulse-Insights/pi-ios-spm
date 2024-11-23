//
//  DebugTool.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/14.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

open class DebugTool {

    class func debugPrintln(_ strPreFix: String, strMsg: String) {
        if LocalConfig.instance.bIsDebugModeOn { print(" ");print("<Debug>PI/"+strPreFix + ": ");print(strMsg)}
    }

    class func debugPrintln(_ strMsg: String) {
        if LocalConfig.instance.bIsDebugModeOn { print(" ");print("<Debug>PI/DebugMsg: ");print(strMsg)}
    }

}
