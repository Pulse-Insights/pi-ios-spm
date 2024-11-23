//
//  UIFont+Extension.swift
//  PulseInsights
//
//  Created by long shen on 2024/10/16.
//  Copyright © 2024 Pulse Insights. All rights reserved.
//

import UIKit

enum RegisterFontError: Error {
  case invalidFontFile
  case fontPathNotFound
  case initFontError
  case registerFailed
}

extension UIFont {
    static func register(fileNameString: String, type: String) throws {
        let frameworkBundle = Bundle(for: PulseInsights.self)
        guard let resourceBundleURL = frameworkBundle.path(forResource: fileNameString, ofType: type) else {
            throw RegisterFontError.fontPathNotFound
        }
        guard let fontData = NSData(contentsOfFile: resourceBundleURL),    let dataProvider = CGDataProvider.init(data: fontData) else {
            throw RegisterFontError.invalidFontFile
        }
        guard let fontRef = CGFont.init(dataProvider) else {
            throw RegisterFontError.initFontError
        }
        var errorRef: Unmanaged<CFError>? = nil
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else   {
            throw RegisterFontError.registerFailed
        }
     }
}
