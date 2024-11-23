//
//  CustomTextView.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2017/1/11.
//  Copyright © 2017 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UIView, UITextViewDelegate {

    var placeholderLabel: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initUITextView()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        initUITextView()
    }

    func initUITextView() {
        let textView = UITextView.init()
        textView.frame = CGRect(x: 60, y: 160, width: 200, height: 200)
        self.addSubview(textView)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.keyboardType = UIKeyboardType.emailAddress
        textView.returnKeyType = UIReturnKeyType.done
        textView.delegate = self
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false

        //placeholder
        self.placeholderLabel = UILabel.init()
        self.placeholderLabel.frame = CGRect(x: 5, y: 5, width: 100, height: 20)
        self.placeholderLabel.font = UIFont.systemFont(ofSize: 13)
        self.placeholderLabel.text = "Hint text"
        textView.addSubview(self.placeholderLabel)
        self.placeholderLabel.textColor = UIColor(red: 72/256, green: 82/256, blue: 93/256, alpha: 1)
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing")
        self.placeholderLabel.isHidden = true //set hidden
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldEndEditing")
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.placeholderLabel.isHidden = false  //set display
        } else {
            self.placeholderLabel.isHidden = true  //set hidden
        }
        print("textViewDidEndEditing")
    }
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        /*
        print("shouldChangeTextInRange")
        if text == "\n"{
            textView.resignFirstResponder() //hide the keyboard when new line
        }*/
        return true
    }
}
