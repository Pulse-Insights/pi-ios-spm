//
//  udid.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/14.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation

open class Udid {
    class func getUdid() -> String {
        var strRtVal: String=""
        var outPart: String=""

        let strFormat: String = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
        let time = UInt32(Date().timeIntervalSinceReferenceDate)
        srand48(Int(time))
        for strTmpChar in strFormat {
            if strTmpChar == "x" || strTmpChar ==  "y" {
                let iTmpBit: NSInteger = (NSInteger)(drand48()*16)|0
                var generateBit: NSInteger = 0
                if strTmpChar == "x" {
                    generateBit = iTmpBit
                } else {
                    generateBit = iTmpBit&0x3|0x8
                }
                outPart = String(format: "%1X", generateBit%16)

            } else {
                outPart = String(strTmpChar)
            }
            strRtVal += outPart
        }
        DebugTool.debugPrintln("Udid generated: "+strRtVal)

        return strRtVal
    }
}
