//
//  FoundationView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 6..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class FoundationView: UIView {
    
    init() {
        super.init(frame: CGRect(x: CGFloat(ScreenPoint.startXPoint),
                                 y: UIApplication.shared.statusBarFrame.height,
                                 width: (CardView.cardSize().width + CardView.marginBetweenCard()) * ScreenPoint.foundationIndex,
                                 height: CardView.cardSize().height))
        self.tag = SubViewTag.foundationView.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension FoundationView {
    func makeFoundation() {
        for column in 0..<4 {
            let cardPlace = CardView()
            cardPlace.arrangeCardView(xPoint: CGFloat(column), yPoint: CGFloat(ScreenPoint.startYPoint))
            self.addSubview(cardPlace)
        }
    }
}
