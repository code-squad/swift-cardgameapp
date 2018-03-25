//
//  UIImageView+CardStack.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 31..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIView {
    func makeStackView(column: Int) {
        let xPoint = ((CardView.cardSize().width + CardView.marginBetweenCard()) * CGFloat(column)) + CardView.marginBetweenCard()
        self.frame = CGRect(x: xPoint, y: 0,
                             width: CardView.cardSize().width,
                             height: UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - 80)
    }
}
