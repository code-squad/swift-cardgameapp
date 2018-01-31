//
//  UIImageView+CardStack.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 31..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeStackView(column: Int, cardsRow: Int) {
        let playCardYPoint = CGFloat(80)
        self.makeCardView(index: CGFloat(column),
                          yPoint: playCardYPoint
                            + UIApplication.shared.statusBarFrame.height
                            + CGFloat(cardsRow) * 20)
    }
}
