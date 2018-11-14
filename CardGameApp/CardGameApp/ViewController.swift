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
    private var stockView: StockView!
    private var wasteView: WasteView!
    private let refreshImageView = RefreshImageView(image: UIImage(named: "cardgameapp-refresh-app".formatPNG))
    private let cardDeck = CardDeck()
    private let tableauView = TableauView()
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
        
        stockView.addSubview(refreshImageView)
        refreshImageView.setting()
        
        addSubViewToTableau()
        addSubViewToFoundation()
        defaultSetting()
    
        createdObservers()
    }
    
    private func createdObservers() {
        let moveToWaste = Notification.Name(NotificationKey.name.moveToWaste)
        NotificationCenter.default.addObserver(self, selector: #selector(moveToWaste(_:)), name: moveToWaste, object: nil)
        let restore = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreCard), name: restore, object: nil)
    }
    
    @objc private func moveToWaste(_ notification: Notification) {
        guard let view = notification.userInfo?[NotificationKey.hash.view] as? UIView else { return }
        wasteView.addSubview(view)
    }
    
    @objc private func restoreCard() {
        var cardViewList = [CardImageView]()
        var index = 1
        for _ in 0..<wasteView.subviews.count {
            guard let cardView = wasteView.subviews[wasteView.subviews.count - index] as? CardImageView else { continue }
            cardView.turnOver()
            cardViewList.append(cardView)
            index += 1
        }
        
        for card in cardViewList {
            stockView.addSubview(card)
        }
    }
    
    private func viewFrameSetting() {
        let superWidth = Unit.iphone8plusWidth
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let stockXValue = space * Unit.fromLeftSpaceOfStock + width * Unit.fromLeftWidthOfStock
        let wasteXValue = space * Unit.fromLeftSpaceOfWaste + width * Unit.fromLeftWidthOfWaste
        
        self.stockView = StockView(frame: CGRect(x: stockXValue, y: Unit.stockYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio))
        self.wasteView = WasteView(frame: CGRect(x: wasteXValue, y: Unit.stockYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio))
    }
    
    private func addSubViewToTableau() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardCountNumber {
            let mold = cardMold(xValue: xValue, yValue: Unit.defalutCardsYValue)
            backgroundView.addSubview(mold)
            let container = tableauContainer(xValue: xValue, yValue: Unit.defalutCardsYValue)
            backgroundView.addSubview(container)
            self.tableauView.append(view: container)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    private func addSubViewToFoundation() {
        var xValue = freeSpace
        for _ in 0..<Unit.foundationCount {
            let mold = cardMold(xValue: xValue, yValue: Unit.foundationYValue)
            backgroundView.addSubview(mold)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    private func cardMold(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: imageWidth * Unit.widthRatio, height: imageWidth * Unit.heightRatio)
        let mold = UIView(frame: rect)
        mold.layer.borderWidth = Unit.foundationBorderWidth
        mold.layer.borderColor = Unit.foundationBorderColor
        return mold
    }
    
    private func tableauContainer(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: imageWidth * Unit.widthRatio, height: 400)
        let container = UIView(frame: rect)
        return container
    }
    
    private func defaultSetting() {
        backgroundView.addSubview(stockView)
        backgroundView.addSubview(wasteView)
        
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            defaultAddTableau(with: defalutCards)
        }
        stockAddSubView(with: cardDeck.list())
    }
    
    private func defaultAddTableau(with cardList: [Card]) {
        var yValue: CGFloat = 0
        for index in 0..<cardList.count {
            let rect = CGRect(x: 0, y: yValue, width: imageWidth * Unit.widthRatio, height: imageWidth * Unit.heightRatio)
            let cardImageView = CardImageView(card: cardList[index], frame: rect)
            if index == cardList.count - 1 {
                cardImageView.turnOver()
            }
            self.tableauView.addSubView(index: cardList.count - 1, view: cardImageView)
            yValue += 20
        }
    }
    
    private func stockAddSubView(with cardList: [Card]) {
        for card in cardList {
            let rect = CGRect(x: 0, y: 0, width: stockView.frame.width, height: stockView.frame.height)
            let cardImageView = CardImageView(card: card, frame: rect)
            stockView.addSubview(cardImageView)
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
        stockView.removeSubView()
        wasteView.removeSubView()
        tableauView.removeSubView()
        
        defaultSetting()
    }
}
