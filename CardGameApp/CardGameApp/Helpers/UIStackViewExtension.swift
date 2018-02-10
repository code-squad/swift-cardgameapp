//
//  UIStackViewExtension.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 5..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

extension UIStackView {
    func configureSettings(with values: StackPresentable?) {
        guard let values = values else { return }
        self.axis = values.axis
        self.distribution = values.distribution
        self.spacing = values.spacing
        self.setBottomMargin(values.bottomMargin)
    }

    func setBottomMargin(_ bottomMargin: CGFloat) {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: bottomMargin, right: 0)
    }

    func addArrangedSubviews(view: [UIView]) {
        view.forEach {
            self.addArrangedSubview($0)
        }
    }
}
