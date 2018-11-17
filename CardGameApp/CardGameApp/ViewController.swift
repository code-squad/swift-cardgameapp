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
        stockView.dataSource = stockViewModel
        wasteView.dataSource = wasteViewModel
        foundationContainerView.dataSource = foundationViewModel
        tableauContainerView.dataSource = tableauViewModel
        
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            for index in 0..<defalutCards.count {
                let containerLocation = defalutCards.count - 1
                tableauViewModel.push(defalutCards[index], index: containerLocation)
            }
        }
        tableauContainerView.draw()
        
        for card in cardDeck.list() {
            stockViewModel.push(card)
        }
        stockView.draw()
    }

    private func createdObservers() {
        let moveToWaste = Notification.Name(NotificationKey.name.moveToWaste)
        NotificationCenter.default.addObserver(self, selector: #selector(moveCardToWaste), name: moveToWaste, object: nil)
        let restore = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreCard), name: restore, object: nil)
        let doubleTap = Notification.Name(NotificationKey.name.doubleTap)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapWaste), name: doubleTap, object: WasteView.self)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapTableau(_:)), name: doubleTap, object: TableauContainerView.self)
    }
    
    @objc private func moveCardToWaste() {
        guard let card = stockViewModel.pop() else { return }
        stockView.draw()
        wasteViewModel.push(card)
        wasteView.draw()
    }
    
    @objc private func restoreCard() {
        for _ in 0..<wasteViewModel.list().count {
            guard let card = wasteViewModel.pop() else { return }
            stockViewModel.push(card)
        }
        wasteView.draw()
        stockView.draw()
    }
    
    @objc private func doubleTapWaste() {
        guard let lastCard = wasteViewModel.lastCard() else { return }
        guard lastCard.isFrontCondition() else { return }
        if lastCard.isAce() {
            aceEvent(deliveryVM: wasteViewModel, deliveryView: wasteView, index: nil)
            return
        }
        if lastCard.isKing() {
            kingEvent(deliveryVM: wasteViewModel, deliveryView: wasteView, index: nil)
            return
        }
        normalEvent(deliveryVM: wasteViewModel, deliveryView: wasteView, index: nil)
    }
    
    @objc private func doubleTapTableau(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        guard let lastCard = tableauViewModel.lastCard(index: index) else { return }
        guard lastCard.isFrontCondition() else { return }
        if lastCard.isAce() {
            aceEvent(deliveryVM: tableauViewModel, deliveryView: tableauContainerView, index: index)
            return
        }
        if lastCard.isKing() {
            kingEvent(deliveryVM: tableauViewModel, deliveryView: tableauContainerView, index: index)
            return
        }
        normalEvent(deliveryVM: tableauViewModel, deliveryView: tableauContainerView, index: index)
    }
    
    private func normalEvent(deliveryVM: DeliverableViewModel, deliveryView: DeliverableView, index: Int?) {
        guard let card = deliveryVM.info(index: index) else { return }
        // 카드(waste or tableau)를 중심으로 Foundation에 한단계 아래 카드가 있다면 그 위로 이동 / 없다면 다음
        if findFoundation(deliveryVM: deliveryVM, deliveryView: deliveryView, card: card, index: index) {
            return
        }
        // Tableau를 돌면서 가장 위에 있는 카드가 나보다 한단계 위 카드이며 색상이 다르다면 그 위로 이동 / 없으면 다음
        if findTableau(deliveryVM: deliveryVM, deliveryView: deliveryView, card: card, index: index) {
            return
        }
    }
    
    private func findFoundation(deliveryVM: DeliverableViewModel, deliveryView: DeliverableView, card: Card, index: Int?) -> Bool {
        for containerIndex in 0..<foundationViewModel.count {
            guard foundationViewModel.isOneStepLower(with: card, index: containerIndex) else { continue }
            guard let popCard = deliveryVM.pop(index: index) else { continue }
            if deliveryVM.hasCard(index: index), let lastCard = deliveryVM.lastCard(index: index) {
                lastCard.switchCondition(with: .front)
            }
            deliveryView.draw()
            foundationViewModel.push(popCard, index: containerIndex)
            foundationContainerView.draw()
            return true
        }
        return false
    }
    
    private func findTableau(deliveryVM: DeliverableViewModel, deliveryView: DeliverableView, card: Card, index: Int?) -> Bool {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isOneStepHigher(with: card, index: containerIndex) else { continue }
            guard let popCard = deliveryVM.pop(index: index) else { continue }
            if deliveryVM.hasCard(index: index), let lastCard = deliveryVM.lastCard(index: index) {
                lastCard.switchCondition(with: .front)
            }
            deliveryView.draw()
            tableauViewModel.push(popCard, index: containerIndex)
            tableauContainerView.draw()
            return true
        }
        return false
    }
    
    private func kingEvent(deliveryVM: DeliverableViewModel, deliveryView: DeliverableView, index: Int?) {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isEmpty(index: containerIndex) else { continue }
            guard let card = deliveryVM.pop(index: index) else { return }
            if deliveryVM.hasCard(index: index), let lastCard = deliveryVM.lastCard(index: index) {
                lastCard.switchCondition(with: .front)
            }
            deliveryView.draw()
            tableauViewModel.push(card, index: containerIndex)
            tableauContainerView.draw()
            break
        }
    }
    
    private func aceEvent(deliveryVM: DeliverableViewModel, deliveryView: DeliverableView, index: Int?) {
        guard let card = deliveryVM.pop(index: index) else { return }
        if deliveryVM.hasCard(index: index), let lastCard = deliveryVM.lastCard(index: index) {
            lastCard.switchCondition(with: .front)
        }
        deliveryView.draw()
        for containerIndex in 0..<foundationViewModel.count {
            guard foundationViewModel.isEmpty(index: containerIndex) else { continue }
            foundationViewModel.push(card, index: containerIndex)
            foundationContainerView.draw()
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
        stockViewModel.removeAll()
        stockView.draw()
        wasteViewModel.removeAll()
        wasteView.draw()
        foundationViewModel.removeAll()
        foundationContainerView.draw()
        tableauViewModel.removeAll()
        tableauContainerView.draw()
        cardConfigure()
    }
}
