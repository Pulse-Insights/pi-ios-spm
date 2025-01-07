//
//  SurveyCustomContentType.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2017/1/16.
//  Copyright © 2017 Pulse Insights. All rights reserved.
//

import Foundation
import WebKit

class SurveyCustomContentType: UIView, WKUIDelegate, WKNavigationDelegate {
    lazy var webView = WKWebView()
    let strHtmlFormatBody: String = "<html><head></head><style type='text/css'>@font-face { \n" +
    "    font-family: \"HelveticaNeue\"; \n" +
    "    src: url('fonts/HelveticaNeue-Light.otf');} \n" +
    "p { font-family: 'HelveticaNeue', Helvetica, Arial, sans-serif; " +
    "text-align: justify; font-size: 16px; color:\(LocalConfig.instance.themeStyle.textColor); }" +
    "span {color:\(LocalConfig.instance.themeStyle.textColor);} " +
    "body { margin: 25px 25px 25px 25px;} " +
    "a { color:\(LocalConfig.instance.themeStyle.textColor); text-decoration:none;} </style>" +
    "<body>"
    let strHtmlFormatFooter: String = "</body></html>"

    var timerRedirect: Timer?
    var timerClose: Timer?
    var mCBClolse:(() -> Void)?

    var strRedirectUrl: String=""

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    func setup() {
        loadViewFromXib()
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": webView]))
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view(>=100)]-0-|", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": webView]))
    }

    // MARK: - load the assign url
    private func load(withURL urlStr:String) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    // MARK: - resize after did load
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
        let customVisFormat = String(format: "V:|-0-[view(>=%d)]-0-|", Int(webView.scrollView.contentSize.height))
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: customVisFormat, options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": webView]))
    }

    // MARK: - redirect to safari after the link in HTML been clicked
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil || navigationAction.targetFrame?.isMainFrame == false {
            if let urlToLoad = navigationAction.request.url, UIApplication.shared.canOpenURL(urlToLoad) {
                print(urlToLoad.absoluteString)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(urlToLoad, options: [:], completionHandler: nil)
                } else {
                    load(withURL: urlToLoad.absoluteString)
                }
            }
        }
        return nil
    }

    func setupContent(_ mContent: SurveyTicket, mCallback:@escaping () -> Void) {
        mCBClolse = mCallback
        timerRedirect = nil
        timerClose = nil
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.isUserInteractionEnabled = true
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.loadHTMLString(strHtmlFormatBody+mContent.content+strHtmlFormatFooter, baseURL: nil)
        let iCloseSec: NSInteger = mContent.autoCloseDelay
        let iRedirectSec: NSInteger = mContent.autoRedirectDelay
        strRedirectUrl = mContent.autoRedirectUrl
        if mContent.autoCloseEnabled && iCloseSec>0 {
            timerClose = Timer.scheduledTimer(timeInterval: Double(iCloseSec), target: self,
                                              selector: #selector(self.timerClose(_:)), userInfo: nil, repeats: false)
        }
        if mContent.autoRedirectEnabled && iRedirectSec>0 && (iRedirectSec<iCloseSec || iCloseSec==0 ) {
            timerRedirect = Timer.scheduledTimer(timeInterval: Double(iRedirectSec), target: self,
                                                 selector: #selector(self.timerRedirect(_:)),
                                                 userInfo: nil, repeats: false)
        }
    }
    @objc fileprivate func timerRedirect(_ timer: Timer) {
        load(withURL: strRedirectUrl)
    }
    @objc fileprivate func timerClose(_ timer: Timer) {
        if mCBClolse != nil {mCBClolse!()}
    }
    
    func cleanup() {
        // Clear timers
        timerRedirect?.invalidate()
        timerRedirect = nil
        timerClose?.invalidate()
        timerClose = nil
        
        // Clear callback
        mCBClolse = nil
        
        // Clear webview
        webView.stopLoading()
        webView.loadHTMLString("", baseURL: nil)
    }
}
