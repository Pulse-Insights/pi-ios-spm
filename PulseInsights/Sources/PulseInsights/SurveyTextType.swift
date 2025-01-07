//
//  SurveyTextType.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2017/1/10.
//  Copyright © 2017 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class SurveyTextType: UIView, UITextViewDelegate {
    @IBOutlet weak var txtHintPart: UITextView!

    @IBOutlet weak var txtInputPart: UITextView!

    @IBOutlet weak var counterLabel: UILabel!
    private let formatTool = FormatSetTool()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    var maxTextLength = 0 {
        didSet {
            composeCountText()
        }
    }

    var inputSize = 0 {
        didSet {
            composeCountText()
        }
    }

    @IBOutlet var containerView: UIView!

    var onChangeListener = Delegate<Void, Void>()

    func composeCountText() {
        let counterMsg = "\(inputSize) / \(maxTextLength)"
        counterLabel.attributedText = formatTool.transferToHtmlFormatInAttribute(counterMsg, fontDetail: LocalConfig.instance.themeStyle.smallFont.getFormater())
    }

    func setup() {
        loadViewFromXib()
        self.backgroundColor = UIColor.clear
        txtInputPart.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.freeText.borderWidth)
        txtInputPart.layer.cornerRadius = 0
        txtInputPart.layer.borderColor = LocalConfig.instance.themeStyle.freeText.borderColor.color.cgColor
//        txtInputPart.layer.backgroundColor = LocalConfig.instance.themeStyle.freeText.backgroundColor.color.cgColor
        txtHintPart.layer.backgroundColor = LocalConfig.instance.themeStyle.freeText.backgroundColor.color.cgColor
        txtHintPart.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        txtInputPart.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        txtHintPart.layer.borderWidth =  CGFloat(LocalConfig.instance.themeStyle.freeText.borderWidth)
//        txtHintPart.layer.borderColor = LocalConfig.instance.themeStyle.freeText.borderColor.color.cgColor
        txtInputPart.textColor = LocalConfig.instance.themeStyle.freeText.fontColor.color
        txtInputPart.delegate = self
        txtInputPart.translatesAutoresizingMaskIntoConstraints = false
        txtHintPart.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.translatesAutoresizingMaskIntoConstraints = false

        // Horizontal constraints for txtInputPart
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-(>=0)-[view]-(>=0)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                         metrics: nil, views: ["view": txtInputPart]))
        // Vertical constraints for txtInputPart and counterLabel
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-16-[view(120)]-8-[label]", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": txtInputPart, "label": counterLabel]))
        // Horizontal constraints for txtHintPart
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-(>=0)-[view]-(>=0)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                         metrics: nil, views: ["view": txtHintPart]))
        // hardcode
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-(>=0)-[view]-16-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                         metrics: nil, views: ["view": counterLabel]))
        // Vertical constraints for txtHintPart
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-16-[view(120)]", options: NSLayoutConstraint.FormatOptions(),
                         metrics: nil, views: ["view": txtHintPart]))
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        containerView.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        txtInputPart.endEditing(true)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SurveyTextType", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return UIView()
        }
        return view
    }

    func setHintText(_ strSetText: String) {
        txtHintPart.attributedText = formatTool.transferToHtmlFormatInAttribute(strSetText,
                                                                                   fontSize: 14,
                                                                                   textColor:  LocalConfig.instance.themeStyle.freeText.placeholderFontColor.color)
    }
    func getInputString() -> String {
        var strRtString: String = ""

        strRtString = txtInputPart.text

        //We mask the encoding statement in case we need it in the future
        //return strRtString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return strRtString
    }

    var clearToSubmit: Bool {
        return txtInputPart.text?.count ?? 0 <= maxTextLength
    }

    func textViewDidChange(_ textField: UITextView) {
        inputSize = txtInputPart.text!.count
        onChangeListener.call()
        if !textField.text!.isEmpty {
            txtHintPart.isHidden = true
        } else {
            txtHintPart.isHidden = false
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count // for Swift use count(newText)
        return numberOfChars <= max(maxTextLength, 0)
    }
    
    func cleanup() {
        // Clear text and callbacks
        txtInputPart.text = ""
    }
}
