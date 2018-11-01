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
    private let reverseBoxYValue = CGFloat(20)
    private let defalutCardsYValue = CGFloat(100)
    private let defalutSize = CGFloat(100)
    private let cardStorageCount = 4
    private let cardStorageBorderWidth = CGFloat(1)
    private let cardStorageBorderColor = UIColor.white.cgColor
    private let cardCount = CGFloat(7)
    private let cardCountNumber = 7
    private let tenPercentOfFrame = CGFloat(0.1)
    private let widthRatio = CGFloat(1)
    private let heightRatio = CGFloat(1.27)
    private var freeSpace: CGFloat {
        let space = self.frame.width * tenPercentOfFrame
        let eachSpace = space / (cardCount + 1)
        return eachSpace
    }
    private var imageWidth: CGFloat {
        let viewWidthWithoutSpace = self.frame.width - self.frame.width * tenPercentOfFrame
        let imageWidth = viewWidthWithoutSpace / cardCount
        return imageWidth
    }
    private var cardContainer = [UIView]()
    
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
        self.addSubview(ReverseBoxView.shared)
        ReverseBoxView.shared.defaultSetting()
        self.addSubview(BoxView.shared)
        BoxView.shared.defaultSetting()
    }
    
    private func defalutBackground() {
        let image = "bg_pattern".formatPNG
        guard let backgroundPattern = UIImage(named: image) else { return }
        self.backgroundColor = UIColor(patternImage: backgroundPattern)
    }
    
    private func cardStorage() {
        var xValue = freeSpace
        for _ in 0..<cardStorageCount {
            let rect = CGRect(x: xValue, y: cardStorageYValue, width: imageWidth * widthRatio, height: imageWidth * heightRatio)
            let cardFrame = CardUIImageView(frame: rect)
            cardFrame.layer.borderWidth = cardStorageBorderWidth
            cardFrame.layer.borderColor = cardStorageBorderColor
            self.addSubview(cardFrame)
            let newXValue = xValue + cardFrame.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    func setCardStack() {
        var xValue = freeSpace
        for _ in 0..<cardCountNumber {
            let rect = CGRect(x: xValue, y: defalutCardsYValue, width: imageWidth * widthRatio, height: imageWidth * heightRatio)
            let container = UIView(frame: rect)
            container.layer.borderWidth = cardStorageBorderWidth
            container.layer.borderColor = cardStorageBorderColor
            self.addSubview(container)
            self.cardContainer.append(container)
            let newXValue = xValue + container.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    func defaultAddCardStack(with cardList: [Card]) {
        var yValue = defalutCardsYValue
        for card in cardList {
            let xValue = cardContainer[cardList.count - 1].frame.minX
            let rect = CGRect(x: xValue, y: yValue, width: imageWidth * widthRatio, height: imageWidth * heightRatio)
            let cardImageView = CardUIImageView(card: card, frame: rect)
            self.addSubview(cardImageView)
            self.cardContainer.append(cardImageView)
            yValue += 20
        }
    }
    
    func reverseBox(with cardList: [Card]) {
        for card in cardList {
            let rect = CGRect(x: 0, y: 0, width: ReverseBoxView.shared.frame.width, height: ReverseBoxView.shared.frame.height)
            let cardImageView = CardUIImageView(card: card, frame: rect)
            ReverseBoxView.shared.addSubview(cardImageView)
        }
    }
    
    func emptyBox() {
        for view in BoxView.shared.subviews {
            view.removeFromSuperview()
        }
    }
}
