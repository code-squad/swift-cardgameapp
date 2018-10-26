//
//  PatternUIView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class PatternUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        defalutBackground()
        listCards()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defalutBackground()
        listCards()
    }
    
    private func defalutBackground() {
        guard let backgroundPattern = UIImage(named: "bg_pattern.png") else { return }
        self.backgroundColor = UIColor(patternImage: backgroundPattern)
    }
    
    private func listCards() {
        var xValue = freeSpace()
        let yValue = CGFloat(40)
        let cardCount = 7
        
        for _ in 0..<cardCount {
            let image = UIImage(named: "card-back.png")
            let cardBack = CardBackUIImageView(image: image)
            cardBack.reSize(with: self.frame)
            cardBack.frame = CGRect(x: xValue, y: yValue, width: cardBack.frame.width, height: cardBack.frame.height)
            self.addSubview(cardBack)
            let newXValue = xValue + cardBack.frame.width + freeSpace()
            xValue = newXValue
        }
    }
    
    private func freeSpace() -> CGFloat {
        let space = self.frame.width * 0.1
        let eachSpace = space / 8
        return eachSpace
    }
}
