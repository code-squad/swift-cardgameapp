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
        configureView()
        configureDataSource()
        configureCard()
        configureObservers()
    }
    
    private func configureView() {
        self.stockView = StockView(frame: CGRect(x: Unit.stockXValue, y: Unit.stockYValue, width: Unit.cardWidth * Unit.widthRatio, height: Unit.cardWidth * Unit.heightRatio))
        self.wasteView = WasteView(frame: CGRect(x: Unit.wasteXValue, y: Unit.stockYValue, width: Unit.cardWidth * Unit.widthRatio, height: Unit.cardWidth * Unit.heightRatio))
        self.tableauContainerView = TableauContainerView(frame: CGRect(x: 0, y: Unit.defalutCardsYValue, width: backgroundView.frame.width, height: backgroundView.frame.height - Unit.defalutCardsYValue))
        self.foundationContainerView = FoundationContainerView(frame: CGRect(x: 0, y: Unit.foundationYValue, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio))
        backgroundView.addSubview(stockView)
        backgroundView.addSubview(wasteView)
        backgroundView.addSubview(tableauContainerView)
        backgroundView.addSubview(foundationContainerView)
    }
    
    private func configureDataSource() {
        stockView.dataSource = stockViewModel
        wasteView.dataSource = wasteViewModel
        foundationContainerView.dataSource = foundationViewModel
        tableauContainerView.dataSource = tableauViewModel
    }
    
    private func configureCard() {
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            for index in 0..<defalutCards.count {
                let containerIndex = defalutCards.count - 1
                tableauViewModel.push(card: defalutCards[index], index: containerIndex)
            }
        }
        tableauContainerView.draw()
        
        for card in cardDeck.list() {
            stockViewModel.push(card: card, index: nil)
        }
        stockView.draw()
    }

    private func configureObservers() {
        let moveToWaste = Notification.Name(NotificationKey.name.moveToWaste)
        NotificationCenter.default.addObserver(self, selector: #selector(moveCardToWaste), name: moveToWaste, object: nil)
        let restore = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreCard), name: restore, object: nil)
        let doubleTap = Notification.Name(NotificationKey.name.doubleTap)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapCard(_:)), name: doubleTap, object: nil)
    }
    
    @objc private func moveCardToWaste() {
        guard let card = stockViewModel.pop() else { return }
        stockView.draw()
        wasteViewModel.push(card: card, index: nil)
        wasteView.draw()
    }
    
    @objc private func restoreCard() {
        for _ in 0..<wasteViewModel.list().count {
            guard let card = wasteViewModel.pop(index: nil) else { return }
            
            stockViewModel.push(card: card, index: nil)
        }
        wasteView.draw()
        stockView.draw()
    }

    @objc private func doubleTapCard(_ notification: Notification) {
        let delivery = configureDelivery(notification)
        guard let lastCard = delivery.viewModel.lastCard(index: delivery.index) else { return }
        guard lastCard.isFrontCondition() else { return }
        if lastCard.isAce() {
            aceEvent(with: delivery)
            return
        }
        if lastCard.isKing() {
            kingEvent(with: delivery)
            return
        }
        normalEvent(with: delivery)
    }
    
    private func configureDelivery(_ notification: Notification) -> Delivery {
        // from waste
        var delivery = Delivery(viewModel: wasteViewModel, view: wasteView, index: nil)
        if let idx = notification.userInfo?["index"] as? Int {
            // from tableau
            delivery = Delivery(viewModel: tableauViewModel, view: tableauContainerView, index: idx)
        }
        return delivery
    }
    
    private func aceEvent(with delivery: Delivery) {
        for containerIndex in 0..<foundationViewModel.count {
            guard foundationViewModel.isEmpty(index: containerIndex) else { continue }
            guard let card = popDeliveryCard(with: delivery) else { continue }
            foundationViewModel.push(card: card, index: containerIndex)
            foundationContainerView.draw()
            break
        }
    }
    
    private func kingEvent(with delivery: Delivery) {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isEmpty(index: containerIndex) else { continue }
            guard let card = popDeliveryCard(with: delivery) else { continue }
            tableauViewModel.push(card: card, index: containerIndex)
            tableauContainerView.draw()
            break
        }
    }
    
    private func normalEvent(with delivery: Delivery) {
        guard let card = delivery.viewModel.info(index: delivery.index) else { return }
        // 카드(waste or tableau)를 중심으로 Foundation에 한단계 아래 카드가 있다면 그 위로 이동 / 없다면 다음
        if findFoundation(with: delivery, card: card) {
            return
        }
        // Tableau를 돌면서 가장 위에 있는 카드가 나보다 한단계 위 카드이며 색상이 다르다면 그 위로 이동 / 없으면 다음
        if findTableau(with: delivery, card: card) {
            return
        }
    }
    
    private func findFoundation(with delivery: Delivery, card: Card) -> Bool {
        for containerIndex in 0..<foundationViewModel.count {
            guard foundationViewModel.isOneStepLower(with: card, index: containerIndex) else { continue }
            guard let popCard = popDeliveryCard(with: delivery) else { continue }
            foundationViewModel.push(card: popCard, index: containerIndex)
            foundationContainerView.draw()
            return true
        }
        return false
    }
    
    private func findTableau(with delivery: Delivery, card: Card) -> Bool {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isOneStepHigher(with: card, index: containerIndex) else { continue }
            guard let popCard = popDeliveryCard(with: delivery) else { continue }
            tableauViewModel.push(card: popCard, index: containerIndex)
            tableauContainerView.draw()
            return true
        }
        return false
    }
    
    private func popDeliveryCard(with delivery: Delivery) -> Card? {
        guard let card = delivery.viewModel.pop(index: delivery.index) else { return nil }
        if delivery.viewModel.hasCard(index: delivery.index), let lastCard = delivery.viewModel.lastCard(index: delivery.index) {
            lastCard.flipCondition(with: .front)
        }
        delivery.view.draw()
        return card
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
        configureCard()
    }
}
