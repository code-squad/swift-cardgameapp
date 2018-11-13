//
//  PatternUIView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    private var cardStack = CardStack()
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
        addSubViewToCardStorage()
        addSubViewToCardStack()        
    }
    
    private func defalutBackground() {
        let image = "bg_pattern".formatPNG
        guard let backgroundPattern = UIImage(named: image) else { return }
        self.backgroundColor = UIColor(patternImage: backgroundPattern)
    }
    
    private func addSubViewToCardStorage() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardStorageCount {
            let mold = cardMold(xValue: xValue, yValue: Unit.cardStorageYValue)
            self.addSubview(mold)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    private func addSubViewToCardStack() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardCountNumber {
            let mold = cardMold(xValue: xValue, yValue: Unit.defalutCardsYValue)
            self.addSubview(mold)
            let container = cardStackContainer(xValue: xValue, yValue: Unit.defalutCardsYValue)
            self.addSubview(container)
            self.cardStack.append(view: container)
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
    
    private func cardStackContainer(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: imageWidth * Unit.widthRatio, height: 400)
        let container = UIView(frame: rect)
        return container
    }
    
    func defaultAddCardStack(with cardList: [Card]) {
        var yValue: CGFloat = 0
        for index in 0..<cardList.count {
            let rect = CGRect(x: 0, y: yValue, width: imageWidth * Unit.widthRatio, height: imageWidth * Unit.heightRatio)
            let cardImageView = CardImageView(card: cardList[index], frame: rect)
            if index == cardList.count - 1 {
                cardImageView.turnOver()
            }
            self.cardStack.addSubView(index: cardList.count - 1, view: cardImageView)
            yValue += 20
        }
    }
    
    func resetCard() {
        cardStack.removeSubView()
    }
}
