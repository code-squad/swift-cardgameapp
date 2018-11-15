//
//  ViewController.swift
//  CardGameApp
//
//  Created by oingbong on 25/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cardDeck = CardDeck()
    @IBOutlet var backgroundView: BackgroundView!
    private var stockView: StockView!
    private var wasteView: WasteView!
    private var foundationContainerView: FoundationContainerView!
    private var tableauContainerView: TableauContainerView!
    private var stockViewModel = StockViewModel()
    private var wasteViewModel = WasteViewModel()
    private var foundationViewModel = FoundationViewModel()
    private var tableauViewModel = TableauViewModel()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfigure()
        createdObservers()
        cardConfigure()
    }
    
    private func viewConfigure() {
        self.stockView = StockView(frame: CGRect(x: Unit.stockXValue, y: Unit.stockYValue, width: Unit.cardWidth * Unit.widthRatio, height: Unit.cardWidth * Unit.heightRatio))
        self.wasteView = WasteView(frame: CGRect(x: Unit.wasteXValue, y: Unit.stockYValue, width: Unit.cardWidth * Unit.widthRatio, height: Unit.cardWidth * Unit.heightRatio))
        self.tableauContainerView = TableauContainerView(frame: CGRect(x: 0, y: Unit.defalutCardsYValue, width: backgroundView.frame.width, height: backgroundView.frame.height - Unit.defalutCardsYValue))
        self.foundationContainerView = FoundationContainerView(frame: CGRect(x: 0, y: Unit.foundationYValue, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio))
        backgroundView.addSubview(stockView)
        backgroundView.addSubview(wasteView)
        backgroundView.addSubview(tableauContainerView)
        backgroundView.addSubview(foundationContainerView)
    }
    
    private func cardConfigure() {
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            for index in 0..<defalutCards.count {
                let containerLocation = defalutCards.count - 1
                tableauViewModel.push(defalutCards[index], index: containerLocation)
                let rect = CGRect(x: 0, y: 0, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio)
                let cardView = CardImageView(card: defalutCards[index], frame: rect)
                tableauContainerView.addTopSubView(index: containerLocation, view: cardView)
            }
        }
        
        for card in cardDeck.list() {
            stockViewModel.push(card)
            let rect = CGRect(x: 0, y: 0, width: stockView.frame.width, height: stockView.frame.height)
            card.switchCondition(with: .back)
            let cardView = CardImageView(card: card, frame: rect)
            stockView.addTopSubView(cardView)
        }
    }

    private func createdObservers() {
        let moveToWaste = Notification.Name(NotificationKey.name.moveToWaste)
        NotificationCenter.default.addObserver(self, selector: #selector(moveCardToWaste), name: moveToWaste, object: nil)
        let restore = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreCard), name: restore, object: nil)
        let doubleTap = Notification.Name(NotificationKey.name.doubleTap)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapWaste), name: doubleTap, object: WasteView.self)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapTableau), name: doubleTap, object: TableauContainerView.self)
    }
    
    @objc private func moveCardToWaste() {
        guard let card = stockViewModel.pop() else { return }
        stockView.removeTopSubView()
        
        wasteViewModel.push(card)
        let rect = CGRect(x: 0, y: 0, width: wasteView.frame.width, height: wasteView.frame.height)
        card.switchCondition(with: .front)
        let cardView = CardImageView(card: card, frame: rect)
        wasteView.addTopSubView(cardView)
    }
    
    @objc private func restoreCard() {
        for _ in 0..<wasteViewModel.list().count {
            guard let card = wasteViewModel.pop() else { return }
            wasteView.removeTopSubView()
            
            stockViewModel.push(card)
            let rect = CGRect(x: 0, y: 0, width: stockView.frame.width, height: stockView.frame.height)
            card.switchCondition(with: .back)
            let cardView = CardImageView(card: card, frame: rect)
            stockView.addTopSubView(cardView)
        }
    }
    
    @objc private func doubleTapWaste() {
        guard let lastCard = wasteViewModel.lastCard() else { return }
        guard lastCard.isFrontCondition() else { return }
        if lastCard.isAce() {
            aceEvent()
        }
    }
    
    @objc private func doubleTapTableau() {
        
    }
    
    private func aceEvent() {
        guard let card = wasteViewModel.pop() else { return }
        wasteView.removeTopSubView()
        // Foundation 중 왼쪽부터 비어있는 곳에 animate
        for index in 0..<foundationViewModel.count {
            guard foundationViewModel.isEmpty(index: index) else { continue }
            foundationViewModel.push(card, index: index)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: card, frame: rect)
            foundationContainerView.addTopSubView(index: index, view: cardView)
            break
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
        reconfigure()
    }
    
    private func reconfigure() {
        stockView.removeAllSubView()
        wasteView.removeAllSubView()
        tableauContainerView.removeAllSubView()
        stockViewModel.removeAll()
        wasteViewModel.removeAll()
        tableauViewModel.removeAll()
        cardConfigure()
    }
}
