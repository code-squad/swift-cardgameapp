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
        defalutSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defalutSetting()
    }
    
    private func defalutSetting() {
        defalutBackground()
        cardStorage()
    }
    
    private func defalutBackground() {
        guard let backgroundPattern = UIImage(named: "bg_pattern.png") else { return }
        self.backgroundColor = UIColor(patternImage: backgroundPattern)
    }
    
    private func cardStorage() {
        var xValue = freeSpace()
        let yValue = CGFloat(20)
        let cardStorageCount = 4
        for _ in 0..<cardStorageCount {
            let rect = CGRect(x: xValue, y: yValue, width: 100, height: 100)
            let cardFrame = CardUIImageView(frame: rect)
            cardFrame.reSize(with: self.frame)
            cardFrame.layer.borderWidth = 1
            cardFrame.layer.borderColor = UIColor.white.cgColor
            self.addSubview(cardFrame)
            let newXValue = xValue + cardFrame.frame.width + freeSpace()
            xValue = newXValue
        }
    }
    
    public func defalutCards(with cardList: [Card]) {
        var xValue = freeSpace()
        let yValue = CGFloat(100)
        
        for card in cardList {
            card.turnOver(with: .front)
            let image = card.image()
            let cardBack = CardUIImageView(image: image)
            cardBack.reSize(with: self.frame)
            cardBack.frame = CGRect(x: xValue, y: yValue, width: cardBack.frame.width, height: cardBack.frame.height)
            self.addSubview(cardBack)
            let newXValue = xValue + cardBack.frame.width + freeSpace()
            xValue = newXValue
        }
    }
    
    public func collection(with cardList: [Card]) {
        let freeSpaces = freeSpace() * 7 // 카드마다 사이 공간
        let cardsWidth = self.frame.width - self.frame.width * 0.1
        let cardWidth = cardsWidth / 7
        let anotherCardsWidth = cardWidth * 6 // 컬렉션 카드 앞에 계산되어야 할 카드 개수
        let xValue = freeSpaces + anotherCardsWidth
        let yValue = CGFloat(20)
        
        for index in 0..<cardList.count {
            guard let image = cardList[index].image() else { return }
            let cardBack = CardUIImageView(image: image)
            cardBack.reSize(with: self.frame)
            cardBack.frame = CGRect(x: xValue, y: yValue, width: cardBack.frame.width, height: cardBack.frame.height)
            self.addSubview(cardBack)
        }
    }
    
    private func freeSpace() -> CGFloat {
        let space = self.frame.width * 0.1
        let eachSpace = space / 8
        return eachSpace
    }
}
