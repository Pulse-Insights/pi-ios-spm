//
//  CheckButton.swift
//  Fitnext
//
//  Created by Summer on 4/26/16.
//  Remade by LeoChao on 12/28/16.
//  Copyright © 2016 Ekohe. All rights reserved.
//

import UIKit

class CheckButton: UIView {

    var tagValue: Int!
    lazy var button: HightlightButton = HightlightButton()
    lazy var containerView: UIView = UIView()
    lazy var canvasView: UIView = UIView()
    lazy var titleLabel: UILabel = UILabel()
    private let formatTool = FormatSetTool()
    var selected: Bool = false
    var shouldShowSelectedColor: Bool = false
    var answerImage = StyledImageView() {
        didSet {
            answerImage.imageStyle = LocalConfig.instance.themeStyle.ansImg
        }
    }

    var showCanvasConstraints: [NSLayoutConstraint]!
    var hideCanvasConstraints: [NSLayoutConstraint]!

    var radioMode: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func selectButton(_ selected: Bool) {
        self.selected = selected
        refreshImageOfButton()
    }
    
    func updateBackgroundColor(_ selected: Bool) {
        self.selected = selected
        button.backgroundColor = selected ? LocalConfig.instance.themeStyle.ansBtn.selectedBackgroundColor.color : LocalConfig.instance.themeStyle.ansBtn.backgroundColor.color
    }

    var btnInnerWidth = 20
    var btnInnerHeight = 20
    var innerStartX = 5
    var innerStartY = 5
    var perRowWidth = CGFloat(0)
    var btnWidth = 30 {
        didSet {
            innerStartX = btnWidth / 6
            btnInnerWidth = btnWidth - (innerStartX * 2)
        }
    }
    var btnHeight = 30 {
        didSet {
            innerStartY = btnHeight / 6
            btnInnerHeight = btnHeight - (innerStartY * 2)
        }
    }

    var labelTitile = ""

    func setupView(_ radioMode:Bool = false, optionDetail: SelectOption, perRowWidth: CGFloat = 0, shouldShowSelectedColor: Bool = false ) {
        self.perRowWidth = perRowWidth
        self.backgroundColor = UIColor.clear
        self.radioMode = radioMode
        self.shouldShowSelectedColor = shouldShowSelectedColor
        let mainThemeObj = LocalConfig.instance.themeStyle
        let padding = CGFloat(mainThemeObj.ansBtn.padding)
        let hPadding = mainThemeObj.ansBtn.paddingHorizontal ?? padding
        let vPadding = mainThemeObj.ansBtn.paddingVertical ?? padding
        let margin = mainThemeObj.ansBtn.margin
        var mainWidthCons = mainThemeObj.ansBtn.widthConStr()
        let mainHeightCons = mainThemeObj.ansBtn.heightConStr()
        let preViewTheme = radioMode ? mainThemeObj.radio : mainThemeObj.checkBox
        let showImage = !optionDetail.imageUrl.isEmpty
        labelTitile = optionDetail.content

        if preViewTheme.width > 0 {
            btnWidth = preViewTheme.width
        }
        if perRowWidth > 0 {
            mainWidthCons = "(\(perRowWidth - CGFloat(margin * 2)))"
        }
        if preViewTheme.height > 0 {
            btnHeight = preViewTheme.height
        }

        if radioMode && mainThemeObj.radio.hide || perRowWidth > 0 {
            btnWidth = 0
            canvasView.isHidden = true
        }

        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clear
        self.addSubview(containerView)
        button = HightlightButton()
        titleLabel = UILabel()
        if perRowWidth > 0 {
            titleLabel.numberOfLines = 1
        } else {
            titleLabel.numberOfLines = 0
        }
        button.tag = tagValue
        self.selected = false
        createButton(button)
        containerView.addSubview(canvasView)
        canvasView.isUserInteractionEnabled = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        button.highlightAction = { [weak self] isHightlighted in
            if isHightlighted {
                self?.touchDown()
            } else {
                self?.touchUp()
            }
        }

        refreshImageOfButton()

        answerImage = StyledImageView()
        answerImage.imageUrl = optionDetail.imageUrl
        answerImage.translatesAutoresizingMaskIntoConstraints = false

        let labelView = showImage ? answerImage : titleLabel

        containerView.addSubview(labelView)

        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-\(margin)-[view\(mainWidthCons)]-\(margin)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": containerView]))
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-\(margin)-[view\(mainHeightCons)]-\(margin)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": containerView]))
        containerView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": button]))
        containerView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": button]))
        containerView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|->=\(vPadding)-[view(\(btnHeight))]", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": canvasView]))
        let contraint = NSLayoutConstraint(item: canvasView, attribute: .centerY,
                                           relatedBy: .equal, toItem: containerView, attribute: .centerY,
                                           multiplier: 1.0, constant: 0)
        containerView.addConstraint(contraint)
        showCanvasConstraints = NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-\(hPadding)-[view(\(btnWidth))]-\(padding)-[label]-\(hPadding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": canvasView, "label": labelView])
        hideCanvasConstraints = NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-\(hPadding)-[label]-\(hPadding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["label": labelView])
        containerView.addConstraints(canvasView.isHidden ? hideCanvasConstraints : showCanvasConstraints)
        containerView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-\(vPadding)-[view]", options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                         views: ["view": labelView]))
        labelView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }

    func createButton(_ button: HightlightButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        applyButtonStyle(button)

        containerView.addSubview(button)
    }

    func applyButtonStyle(_ button: HightlightButton) {
        var overrideAlignment: String {
            if LocalConfig.instance.themeStyle.radio.hide && self.radioMode || perRowWidth > 0 {
                return "center"
            } else {
                return ""
            }
        }
        titleLabel.attributedText = formatTool.transferToHtmlFormatInAttribute(
            labelTitile,
            fontDetail: LocalConfig.instance.themeStyle.ansBtn.getFontDetail(),
            setTextAlign: overrideAlignment
        )

        titleLabel.backgroundColor = UIColor.clear

        button.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.ansBtn.borderWidth)
        button.layer.borderColor = LocalConfig.instance.themeStyle.ansBtn.borderColor.color.cgColor
        button.layer.cornerRadius = LocalConfig.instance.themeStyle.ansBtn.borderRadius ?? 0
        button.isSelected = false
        
//        let normalColor = LocalConfig.instance.themeStyle.ansBtn.backgroundColor.color
//        button.setBackgroundImage(normalColor.coloredImage, for: .normal)

        button.backgroundColor = LocalConfig.instance.themeStyle.ansBtn.backgroundColor.color
        
        if !self.radioMode && selected && self.perRowWidth > 0 {
            // need to check if it's show all questions, if so, use selectedBackgroundColor instead
            button.backgroundColor = shouldShowSelectedColor ? LocalConfig.instance.themeStyle.ansBtn.selectedBackgroundColor.color : LocalConfig.instance.themeStyle.ansBtn.perRowBackgroundColor.color
            titleLabel.textColor = selected ? UIColor.white : LocalConfig.instance.themeStyle.ansBtn.fontColor.color
        } else if(self.radioMode && shouldShowSelectedColor) {
            button.backgroundColor = selected ? LocalConfig.instance.themeStyle.ansBtn.selectedBackgroundColor.color : LocalConfig.instance.themeStyle.ansBtn.backgroundColor.color
        } else  if(self.radioMode && !shouldShowSelectedColor) {
            let highlightColor = LocalConfig.instance.themeStyle.ansBtn.backgroundColorHighlight.color
            button.setBackgroundImage(highlightColor.coloredImage, for: .highlighted)
        }
    }

    func applyPressedButtonStyle(_ button: HightlightButton) {
        var overrideAlignment: String {
            if LocalConfig.instance.themeStyle.radio.hide && self.radioMode || perRowWidth > 0 {
                return "center"
            } else {
                return ""
            }
        }
        button.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.ansBtn.borderWidth)
        button.layer.borderColor = LocalConfig.instance.themeStyle.ansBtn.tabEffectBorderColor.color.cgColor
        button.layer.cornerRadius = 0
        button.isSelected = false
        button.backgroundColor = LocalConfig.instance.themeStyle.ansBtn.tabEffectBackgroundColor.color
        titleLabel.attributedText = formatTool.transferToHtmlFormatInAttribute(labelTitile, fontDetail: LocalConfig.instance.themeStyle.mediumFont.getFormater(), pressEffect: true, setTextAlign: overrideAlignment)
        titleLabel.backgroundColor = UIColor.clear
    }

    func touchDown() {
        if LocalConfig.instance.themeStyle.ansBtn.tabEffect {
            applyPressedButtonStyle(button)
        }
        if(self.radioMode) {
            titleLabel.textColor = .white
        }
        print("touchDown")
    }

    func touchUp() {
        applyButtonStyle(button)
        if(self.radioMode) {
            titleLabel.textColor = LocalConfig.instance.themeStyle.ansBtn.fontColor.color
        }
        print("touchUp")
    }

    func refreshImageOfButton() {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: btnWidth, height: btnHeight))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.layer.backgroundColor = UIColor.clear.cgColor
        if btnHeight * btnWidth == 0 {
            return
        }
        if self.radioMode {
            shapeLayer.fillColor = LocalConfig.instance.themeStyle.radio.backgroundColor.color.cgColor
            shapeLayer.strokeColor = LocalConfig.instance.themeStyle.radio.borderColor.color.cgColor
            shapeLayer.lineWidth = CGFloat(LocalConfig.instance.themeStyle.radio.borderWidth)
            canvasView.layer.addSublayer(shapeLayer)

            if selected {
                let circleInPath = UIBezierPath(ovalIn: CGRect(x: innerStartX,y: innerStartY, width: btnInnerWidth, height: btnInnerHeight))
                let inShapeLayer = CAShapeLayer()
                inShapeLayer.path = circleInPath.cgPath
                inShapeLayer.fillColor = UIColor.black.cgColor
                canvasView.layer.addSublayer(inShapeLayer)
            }
            if LocalConfig.instance.themeStyle.radio.hide {
                canvasView.isHidden = true
                containerView.removeConstraints(showCanvasConstraints)
                containerView.addConstraints(hideCanvasConstraints)
            }

        } else {
            let rectPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: btnWidth, height: btnHeight))
            shapeLayer.path = rectPath.cgPath
            shapeLayer.fillColor = LocalConfig.instance.themeStyle.checkBox.backgroundColor.color.cgColor
            shapeLayer.strokeColor = LocalConfig.instance.themeStyle.checkBox.borderColor.color.cgColor
            shapeLayer.lineWidth = CGFloat(LocalConfig.instance.themeStyle.checkBox.borderWidth)
            canvasView.layer.addSublayer(shapeLayer)

            if selected {
                let textLayer = LCTextLayer()
                textLayer.frame = CGRect(x: innerStartX, y: innerStartY, width: btnInnerWidth, height: btnInnerHeight)
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.string = "\u{2713}"
                textLayer.foregroundColor = LocalConfig.instance.themeStyle.checkMark.color.color.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.fontSize = LocalConfig.instance.themeStyle.checkMark.fontSize
                canvasView.layer.addSublayer(textLayer)
            }
        }
    }
}
