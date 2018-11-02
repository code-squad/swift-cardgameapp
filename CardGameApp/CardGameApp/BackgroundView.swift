//
//  PatternUIView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
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
            let cardImageView = CardUIImageView(card: cardList[index], frame: rect)
            if index == cardList.count - 1 {
                cardImageView.turnOver()
            }
            self.addSubview(cardImageView)
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
