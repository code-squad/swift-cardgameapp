//
//  ViewController.swift
//  CardGameApp
//
//  Created by oingbong on 25/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var backgroundView: BackgroundView!
    private var reverseBoxView: ReverseBoxView!
    private var boxView: BoxView!
    private let refreshImageView = RefreshImageView(image: UIImage(named: "cardgameapp-refresh-app".formatPNG))
    private let cardDeck = CardDeck()
    private let cardStack = CardStack()
    private var freeSpace: CGFloat {
        let space = backgroundView.frame.width * Unit.tenPercentOfFrame
        let eachSpace = space / (Unit.cardCount + 1)
        return eachSpace
    }
    private var imageWidth: CGFloat {
        let viewWidthWithoutSpace = backgroundView.frame.width - backgroundView.frame.width * Unit.tenPercentOfFrame
        let imageWidth = viewWidthWithoutSpace / Unit.cardCount
        return imageWidth
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewFrameSetting()
        
        reverseBoxView.addSubview(refreshImageView)
        refreshImageView.setting()
        
        addSubViewToCardStack()
        addSubViewToCardStorage()
        defaultSetting()
    
        createdObservers()
    }
    
    private func createdObservers() {
        let moveToBox = Notification.Name(NotificationKey.name.moveToBox)
        NotificationCenter.default.addObserver(self, selector: #selector(moveToBox(_:)), name: moveToBox, object: nil)
        let restore = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreCard), name: restore, object: nil)
    }
    
    @objc private func moveToBox(_ notification: Notification) {
        guard let view = notification.userInfo?[NotificationKey.hash.view] as? UIView else { return }
        boxView.addSubview(view)
    }
    
    @objc private func restoreCard() {
        var cardViewList = [CardImageView]()
        var index = 1
        for _ in 0..<boxView.subviews.count {
            guard let cardView = boxView.subviews[boxView.subviews.count - index] as? CardImageView else { continue }
            cardView.turnOver()
            cardViewList.append(cardView)
            index += 1
        }
        
        for card in cardViewList {
            reverseBoxView.addSubview(card)
        }
    }
    
    private func viewFrameSetting() {
        let superWidth = Unit.iphone8plusWidth
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let reverseBoxXValue = space * Unit.fromLeftSpaceOfReverseBox + width * Unit.fromLeftWidthOfReverseBox
        let boxXValue = space * Unit.fromLeftSpaceOfBox + width * Unit.fromLeftWidthOfBox
        
        self.reverseBoxView = ReverseBoxView(frame: CGRect(x: reverseBoxXValue, y: Unit.reverseBoxYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio))
        self.boxView = BoxView(frame: CGRect(x: boxXValue, y: Unit.reverseBoxYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio))
    }
    
    private func addSubViewToCardStack() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardCountNumber {
            let mold = cardMold(xValue: xValue, yValue: Unit.defalutCardsYValue)
            backgroundView.addSubview(mold)
            let container = cardStackContainer(xValue: xValue, yValue: Unit.defalutCardsYValue)
            backgroundView.addSubview(container)
            self.cardStack.append(view: container)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    private func addSubViewToCardStorage() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardStorageCount {
            let mold = cardMold(xValue: xValue, yValue: Unit.cardStorageYValue)
            backgroundView.addSubview(mold)
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
    
    private func defaultSetting() {
        backgroundView.addSubview(reverseBoxView)
        backgroundView.addSubview(boxView)
        
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            defaultAddCardStack(with: defalutCards)
        }
        reverseBoxAddSubView(with: cardDeck.list())
    }
    
    private func defaultAddCardStack(with cardList: [Card]) {
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
    
    private func reverseBoxAddSubView(with cardList: [Card]) {
        for card in cardList {
            let rect = CGRect(x: 0, y: 0, width: reverseBoxView.frame.width, height: reverseBoxView.frame.height)
            let cardImageView = CardImageView(card: card, frame: rect)
            reverseBoxView.addSubview(cardImageView)
        }
    }
}

extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController {
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        resetCard()
    }
    
    private func resetCard() {
        reverseBoxView.removeSubView()
        boxView.removeSubView()
        cardStack.removeSubView()
        
        defaultSetting()
    }
}
