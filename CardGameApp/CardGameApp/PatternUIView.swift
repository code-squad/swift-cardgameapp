//
//  PatternUIView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class PatternUIView: UIView {
    private let cardStorageYValue = CGFloat(20)
    private let collectionYValue = CGFloat(20)
    private let defalutCardsYValue = CGFloat(100)
    private let defalutSize = CGFloat(100)
    private let cardStorageCount = 4
    private let cardStorageBorderWidth = CGFloat(1)
    private let cardStorageBorderColor = UIColor.white.cgColor
    private let cardCount = CGFloat(7)
    private let tenPercentOfFrame = CGFloat(0.1)
    private var freeSpace: CGFloat {
        let space = self.frame.width * tenPercentOfFrame
        let eachSpace = space / (cardCount + 1)
        return eachSpace
    }
    
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
        let image = "bg_pattern".formatPNG
        guard let backgroundPattern = UIImage(named: image) else { return }
        self.backgroundColor = UIColor(patternImage: backgroundPattern)
    }
    
    private func cardStorage() {
        var xValue = freeSpace
        for _ in 0..<cardStorageCount {
            let rect = CGRect(x: xValue, y: cardStorageYValue, width: defalutSize, height: defalutSize)
            let cardFrame = CardUIImageView(frame: rect)
            cardFrame.reSize(with: self.frame)
            cardFrame.layer.borderWidth = cardStorageBorderWidth
            cardFrame.layer.borderColor = cardStorageBorderColor
            self.addSubview(cardFrame)
            let newXValue = xValue + cardFrame.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    func defalutCards(with cardList: [Card]) {
        var xValue = freeSpace
        for card in cardList {
            card.switchCondition(with: .front)
            let cardUIImageView = addCardView(with: card, xValue: xValue, yValue: defalutCardsYValue)
            let newXValue = xValue + cardUIImageView.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    public func collection(with cardList: [Card]) {
        let freeSpaces = freeSpace * cardCount // 카드마다 사이 공간
        let cardsWidth = self.frame.width - self.frame.width * tenPercentOfFrame
        let cardWidth = cardsWidth / cardCount
        let anotherCardsWidth = cardWidth * (cardCount - 1) // 컬렉션 카드 앞에 계산되어야 할 카드 개수
        let xValue = freeSpaces + anotherCardsWidth
        for index in 0..<cardList.count {
            _ = addCardView(with: cardList[index], xValue: xValue, yValue: collectionYValue)
        }
    }
    
    private func addCardView(with card: Card, xValue: CGFloat, yValue: CGFloat) -> CardUIImageView {
        let cardImageView = CardUIImageView(card: card)
        cardImageView.reSize(with: self.frame)
        cardImageView.frame = CGRect(x: xValue, y: yValue, width: cardImageView.frame.width, height: cardImageView.frame.height)
        self.addSubview(cardImageView)
        return cardImageView
    }
}
