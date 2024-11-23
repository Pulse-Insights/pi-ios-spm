//
//  AnswerBeforeAfterView.swift
//  PulseInsights
//
//  Created by Lu Hao on 2021/6/1.
//  Copyright © 2021 Pulse Insights. All rights reserved.
//

import UIKit

/// A view before or after the answer area
class AnswerBeforeAfterView: HeightSetableUIView {

    let stackView = UIStackView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private var paddings = [NSLayoutConstraint]()
    private let formatTool = FormatSetTool()

    private func setup() {

        backgroundColor = .clear

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)

        addSubview(stackView)

        updatePadding(.zero)
    }

    func show(items: [String]) {
        // Remove all subviews from the stack view
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        items.forEach {
            let label = UILabel()
            label.attributedText = formatTool.transferToHtmlFormatInAttribute(
                $0,
                fontDetail: LocalConfig.instance.themeStyle.answersHelper.font.getFormater()
            )
            stackView.addArrangedSubview(label)
        }

        unHide()
    }

    func hide() {
        if !stackView.arrangedSubviews.isEmpty {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        }
        goneHide()
    }

    func autoDisplay(with items: [String]?) {
        guard let items = items, !items.isEmpty else {
            hide()
            return
        }
        show(items: items)
    }

    func updateTheme(_ theme: AnswersHelperTheme) {
        updatePadding(
            .init(top: theme.paddingTop, left: theme.paddingLeft,
                  bottom: theme.paddingBottom, right: theme.paddingRight)
        )
    }

    private func updatePadding(_ insets: UIEdgeInsets) {
        if !paddings.isEmpty {
            removeConstraints(paddings)
        }

        paddings =
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-\(insets.left)-[stack]-\(insets.right)-|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["stack": stackView]
            )
            +
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-\(insets.top)-[stack]-\(insets.bottom)-|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["stack": stackView]
            )
        
        addConstraints(paddings)
    }
}
