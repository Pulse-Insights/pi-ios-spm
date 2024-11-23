//
//  FormatSetTool.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/20.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class FormatSetTool {
    
    private let targetIdBold: NSInteger = 0
    private let targetIdItalic: NSInteger = 1
    private let aryStringPreFix: [String] = ["<b>", "<em>"]
    private let aryStringPostFix: [String] = ["</b>", "</em>"]
    private var aryMarkCount: [NSInteger] = [0, 0]
    private var listRecord: [NSInteger] = []
    
    func transferToHtmlFormatInAttribute(_ strOriString: String, fontDetail: FontFormater, pressEffect: Bool = false, setTextAlign: String = "") -> NSAttributedString {
        let textColor: UIColor = pressEffect ? LocalConfig.instance.themeStyle.ansBtn.tabEffectTextColor.color : fontDetail.fontColor.color
        let textAlign: String = setTextAlign.isEmpty ? fontDetail.alignment : setTextAlign

        return transferToHtmlFormatInAttribute(strOriString,
                                               fontSize: fontDetail.fontSize,
                                               textColor: textColor,
                                               fontFamily: fontDetail.fontFace,
                                               textAlign: textAlign,
                                               fontWeight: fontDetail.fontWeight,
                                               fontStyle: fontDetail.fontStyle)
    }
    
    func transferToHtmlFormatInAttribute(_ strOriString: String,
                                             fontSize: NSInteger = 18,
                                             textColor: UIColor = LocalConfig.instance.themeStyle.textColor.color,
                                             fontFamily: String = "sans-serif",
                                             textAlign: String = "left",
                                             fontWeight: CGFloat = 300.0,
                                             fontStyle: String = "normal") -> NSAttributedString {

        let strHtmlFormatHead = """
        <html><head><meta charset="UTF-8"><style type="text/css">body {font-size: \(fontSize)pt; font-family: \(fontFamily); text-align: \(textAlign); font-style: \(fontStyle); font-weight: \(fontWeight)}</style></head><body>
        """
        let strHtmlFormatFooter = "</body></html>"
        let fullRawText = "\(strHtmlFormatHead)\(strOriString)\(strHtmlFormatFooter)"
        
        guard let data = fullRawText.data(using: .unicode, allowLossyConversion: true),
              let attrStr = try? NSMutableAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil) else {
            return NSAttributedString()
        }

        if fontStyle.caseInsensitiveCompare("italic") == .orderedSame || fontStyle.caseInsensitiveCompare("oblique") == .orderedSame {
            attrStr.addAttributes([.obliqueness: 0.2], range: NSRange(location: 0, length: attrStr.string.utf16.count))
        }

        let systemFont = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight == 700 ? .bold : .regular)
        attrStr.addAttributes([.font: systemFont], range: NSRange(location: 0, length: attrStr.string.utf16.count))

        let style = NSMutableParagraphStyle()
        style.alignment = textAlign == "center" ? .center : (textAlign == "right" ? .right : .left)
        style.lineBreakMode = .byWordWrapping
        style.lineSpacing = 1
        // Sould measure the length in utf16 because the input cases might have the emoji
        // According this thread: https://stackoverflow.com/a/56471065
        // If not, the displyed emoji might broken/hided
        attrStr.addAttributes([.paragraphStyle: style, .foregroundColor: textColor], range: NSRange(location: 0, length: attrStr.string.utf16.count))

        return attrStr
    }

    func transferToHtmlFormat(_ strOriString: String) -> String {
        var strRtItem = ""
        var iCountMarkBold = countMatch(strOriString, strTarget: "*")
        iCountMarkBold = (iCountMarkBold > 0) ? ((iCountMarkBold % 2 == 0) ? iCountMarkBold : (iCountMarkBold - 1)) : 0
        var iCountMarkItalic = countMatch(strOriString, strTarget: "_")
        iCountMarkItalic = (iCountMarkItalic > 0) ? ((iCountMarkItalic % 2 == 0) ? iCountMarkItalic : (iCountMarkItalic - 1)) : 0

        aryMarkCount[targetIdBold] = iCountMarkBold
        aryMarkCount[targetIdItalic] = iCountMarkItalic

        if iCountMarkBold + iCountMarkItalic > 0 {
            for cTemp in strOriString {
                if cTemp == "*" || cTemp == "_" {
                    let iTargetID = (cTemp == "*") ? targetIdBold : targetIdItalic
                    if aryMarkCount[iTargetID] > 0 {
                        strRtItem += (aryMarkCount[iTargetID] % 2 == 0) ? aryStringPreFix[iTargetID] : getPostFixTag(iTargetID)
                        aryMarkCount[iTargetID] -= 1
                    } else {
                        strRtItem += String(cTemp)
                    }
                } else {
                    strRtItem += String(cTemp)
                }
            }
        } else {
            strRtItem = strOriString
        }
        return strRtItem
    }
    
    private func getPostFixTag(_ iOnCloseType: NSInteger) -> String {
        var strRt = ""
        var strContinuePreFix = ""
        var listAdditional: [NSInteger] = []

        while !listRecord.isEmpty {
            let iLastTypeID = listRecord.removeLast()
            strRt += aryStringPostFix[iLastTypeID]
            if iOnCloseType == iLastTypeID {
                break
            } else {
                strContinuePreFix = aryStringPreFix[iLastTypeID] + strContinuePreFix
                listAdditional.append(iLastTypeID)
            }
        }

        if !listAdditional.isEmpty {
            listRecord.append(contentsOf: listAdditional.reversed())
        }

        return strRt
    }

    private func countMatch(_ strSource: String, strTarget: String) -> NSInteger {
        guard !strTarget.isEmpty, strSource.count > strTarget.count else { return 0 }
        return (strSource.count - strSource.replacingOccurrences(of: strTarget, with: "").count) / strTarget.count
    }
}
