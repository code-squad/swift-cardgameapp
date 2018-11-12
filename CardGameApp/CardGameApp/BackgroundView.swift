//
//  PatternUIView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    private let reverseBoxView = ReverseBoxView()
    private let boxView = BoxView()
    private var cardContainer = [UIView]()
    private var freeSpace: CGFloat {
        let space = self.frame.width * Unit.tenPercentOfFrame
        let eachSpace = space / (Unit.cardCount + 1)
        return eachSpace
    }
    private var imageWidth: CGFloat {
        let viewWidthWithoutSpace = self.frame.width - self.frame.width * Unit.tenPercentOfFrame
        let imageWidth = viewWidthWithoutSpace / Unit.cardCount
        return imageWidth
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
        self.addSubview(reverseBoxView)
        reverseBoxView.defaultSetting()
        self.addSubview(boxView)
        boxView.defaultSetting()
    }
    
    private func defalutBackground() {
        let image = "bg_pattern".formatPNG
        guard let backgroundPattern = UIImage(named: image) else { return }
        self.backgroundColor = UIColor(patternImage: backgroundPattern)
    }
    
    private func cardStorage() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardStorageCount {
            let mold = cardMold(xValue: xValue, yValue: Unit.cardStorageYValue)
            self.addSubview(mold)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    func setCardStack() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardCountNumber {
            let mold = cardMold(xValue: xValue, yValue: Unit.defalutCardsYValue)
            self.addSubview(mold)
            self.cardContainer.append(mold)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    private func cardMold(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: imageWidth * Unit.widthRatio, height: imageWidth * Unit.heightRatio)
        let mold = UIView(frame: rect)
        mold.layer.borderWidth = Unit.cardStorageBorderWidth
        mold.layer.borderColor = Unit.cardStorageBorderColor
        return mold
    }
    
    func defaultAddCardStack(with cardList: [Card]) {
        var yValue = Unit.defalutCardsYValue
        for index in 0..<cardList.count {
            let xValue = cardContainer[cardList.count - 1].frame.minX
            let rect = CGRect(x: xValue, y: yValue, width: imageWidth * Unit.widthRatio, height: imageWidth * Unit.heightRatio)
            let cardImageView = CardImageView(card: cardList[index], frame: rect)
            if index == cardList.count - 1 {
                cardImageView.turnOver()
            }
            self.addSubview(cardImageView)
            yValue += 20
        }
    }
    
    func reverseBox(with cardList: [Card]) {
        for card in cardList {
            let rect = CGRect(x: 0, y: 0, width: reverseBoxView.frame.width, height: reverseBoxView.frame.height)
            let cardImageView = CardImageView(card: card, frame: rect)
            reverseBoxView.addSubview(cardImageView)
        }
    }
    
    func resetCard() {
        boxView.removeSubView()
        reverseBoxView.removeSubView()
        self.removeSubView()
    }
    
    private func removeSubView() {
        // container view가 없는 cardStack 들을 지우기 위해 Y값을 이용
        for view in self.subviews where view.frame.minY >= 100 {
            view.removeFromSuperview()
        }
    }
}
