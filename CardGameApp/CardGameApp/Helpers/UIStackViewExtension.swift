//
//  UIStackViewExtension.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 5..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

extension UIStackView {
    func setupStacks(innerStacks: [UIStackView]) {
        innerStacks.forEach { (innerStack) in
            self.addArrangedSubview(innerStack)
        }
    }

    func stackSettings(_ stackInfo: StackViewInfo?) {
        guard let stackInfo = stackInfo else { return }
        self.axis = stackInfo.axis
        self.distribution = stackInfo.distribution
        self.spacing = stackInfo.spacing
        self.setBottomMargin(stackInfo.bottomMargin)
    }

    private func setBottomMargin(_ bottomMargin: CGFloat) {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: bottomMargin, right: 0)
    }
}
