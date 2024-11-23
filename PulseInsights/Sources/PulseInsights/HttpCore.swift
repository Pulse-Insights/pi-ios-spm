//
//  httpCore.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/14.
//  Copyright © 2016年 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

open class HttpCore {

    class func requestUrl(_ urlString: String, callback:@escaping (_ strResult: String) -> Void) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            let systemVersion = UIDevice.current.systemVersion
            let systemModel = UIDevice.current.model
            request.setValue(systemModel + "HttpClient/UNAVAILABLE (" +
                systemModel + ", iOS " + systemVersion + ")", forHTTPHeaderField: "User-Agent")
            var strRtVal: String = ""
            let m_callback = callback
            DebugTool.debugPrintln("httpCore/RequestUrl", strMsg: urlString)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main,
                                                    completionHandler: { (_ response, data, error) -> Void in

                if (error) != nil {
                    //Handle Error here
                    DebugTool.debugPrintln("httpCore", strMsg: "Error")
                    m_callback("error")
                } else {
                    let mTmpData: Data = data!
                    strRtVal = String(data: mTmpData, encoding: String.Encoding.utf8)!
                    DebugTool.debugPrintln("httpCore", strMsg: strRtVal)
                    m_callback(strRtVal)
                    //Handle data in NSData type
                }
            })
        }
    }
}
