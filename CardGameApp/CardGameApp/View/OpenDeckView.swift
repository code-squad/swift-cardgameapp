//
//  OpenDeckView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 12..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class OpenDeckView: UIView, CardGameView {
    
    init() {
        let xPoint = (CardView.cardSize().width + CardView.marginBetweenCard()) * CGFloat(ScreenPoint.openCardXPoint)
        let yPoint = UIApplication.shared.statusBarFrame.height + (CardView.cardSize().height * CGFloat(ScreenPoint.startYPoint))
        super.init(frame: CGRect(origin: CGPoint(x: xPoint, y: yPoint), size: CardView.cardSize()))
        self.tag = SubViewTag.openDeckView.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func removeStackViewLast(index: Int) {
        guard let lastView = self.subviews[0].subviews.last else { return }
        lastView.removeFromSuperview()
    }
    
    func makeBasicSubView() {
        let basicView = CardView()
        self.addSubview(basicView)
    }
}
