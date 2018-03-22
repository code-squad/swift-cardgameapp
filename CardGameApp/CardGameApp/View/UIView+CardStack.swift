//
//  UIImageView+CardStack.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 31..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIView {
    func makeStackView(cardsRow: Int) {
        self.makeCardView(yPoint: CGFloat(cardsRow) * 20)
    }
    
    func makeStackView(column: Int) {
        let xPoint = ((UIView.cardSize().width + UIView.marginBetweenCard()) * CGFloat(column)) + UIView.marginBetweenCard()
        
        self.frame = CGRect(x: xPoint, y: 0,
                             width: UIView.cardSize().width,
                             height: UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - 80)
    }
}
