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
                tableauViewModel.push(defalutCards[index], at: containerIndex)
            }
        }
        for card in cardDeck.list() {
            stockViewModel.push(card, at: nil)
        }
    }

    private func configureObservers() {
        let keyName = NotificationKey.name
        let stock = Notification.Name(keyName.stock)
        NotificationCenter.default.addObserver(self, selector: #selector(redrawStock), name: stock, object: nil)
        let waste = Notification.Name(keyName.waste)
        NotificationCenter.default.addObserver(self, selector: #selector(redrawWaste), name: waste, object: nil)
        let foundation = Notification.Name(keyName.foundation)
        NotificationCenter.default.addObserver(self, selector: #selector(redrawFoundation), name: foundation, object: nil)
        let tableau = Notification.Name(keyName.tableau)
        NotificationCenter.default.addObserver(self, selector: #selector(redrawTableau), name: tableau, object: nil)
        let moveToWaste = Notification.Name(keyName.moveToWaste)
        NotificationCenter.default.addObserver(self, selector: #selector(moveCardToWaste), name: moveToWaste, object: nil)
        let restore = Notification.Name(keyName.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreCard), name: restore, object: nil)
        let doubleTap = Notification.Name(keyName.doubleTap)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapCard(_:)), name: doubleTap, object: nil)
    }
    
    @objc private func redrawStock() {
        self.stockView.setNeedsLayout()
    }
    
    @objc private func redrawWaste() {
        self.wasteView.setNeedsLayout()
    }
    
    @objc private func redrawTableau() {
        self.tableauContainerView.setNeedsLayout()
    }
    
    @objc private func redrawFoundation() {
        self.foundationContainerView.setNeedsLayout()
    }
    
    @objc private func moveCardToWaste() {
        let delivery = Delivery(viewModel: stockViewModel, view: stockView, index: nil)
        let destination = Destination(viewModel: wasteViewModel, view: wasteView, index: nil)
        moveCard(from: delivery, to: destination)
    }
    
    @objc private func restoreCard() {
        for _ in 0..<wasteViewModel.list().count {
            guard let card = wasteViewModel.pop(at: nil) else { return }
            stockViewModel.push(card, at: nil)
        }
    }

    @objc private func doubleTapCard(_ notification: Notification) {
        let delivery = configureDelivery(notification)
        guard let lastCard = delivery.viewModel.lastCard(at: delivery.index) else { return }
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
        if let idx = notification.userInfo?[NotificationKey.hash.index] as? Int {
            // from tableau
            delivery = Delivery(viewModel: tableauViewModel, view: tableauContainerView, index: idx)
        }
        return delivery
    }
    
    private func aceEvent(with delivery: Delivery) {
        for containerIndex in 0..<foundationViewModel.count {
            guard foundationViewModel.isEmpty(index: containerIndex) else { continue }
            let destination = Destination(viewModel: foundationViewModel, view: foundationContainerView, index: containerIndex)
            moveCard(from: delivery, to: destination)
            break
        }
    }
    
    private func kingEvent(with delivery: Delivery) {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isEmpty(index: containerIndex) else { continue }
            let destination = Destination(viewModel: tableauViewModel, view: tableauContainerView, index: containerIndex)
            moveCard(from: delivery, to: destination)
            break
        }
    }
    
    private func normalEvent(with delivery: Delivery) {
        guard let card = delivery.viewModel.info(at: delivery.index) else { return }
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
            let destination = Destination(viewModel: foundationViewModel, view: foundationContainerView, index: containerIndex)
            moveCard(from: delivery, to: destination)
            return true
        }
        return false
    }
    
    private func findTableau(with delivery: Delivery, card: Card) -> Bool {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isOneStepHigher(with: card, at: containerIndex) else { continue }
            let destination = Destination(viewModel: tableauViewModel, view: tableauContainerView, index: containerIndex)
            moveCard(from: delivery, to: destination)
            return true
        }
        return false
    }
    
    private func popDeliveryCard(with delivery: Delivery) -> Card? {
        guard let card = delivery.viewModel.pop(at: delivery.index) else { return nil }
        if delivery.viewModel.hasCard(at: delivery.index), let lastCard = delivery.viewModel.lastCard(at: delivery.index) {
            lastCard.flipCondition(with: .front)
        }
        delivery.view.drawSubView()
        return card
    }
    
    private func moveCard(from delivery: Delivery, to destination: Destination) {
        guard let toPoint = destination.view.convert(at: destination.index, to: backgroundView) else { return }
        guard let fromPoint = delivery.view.convert(at: delivery.index, to: backgroundView) else { return }
        UIView.animate(withDuration: 0.2, animations: {
            let movePoint = CGPoint(
                x: toPoint.x - fromPoint.x,
                y: toPoint.y - fromPoint.y)
            delivery.view.topSubView(at: delivery.index)?.frame.origin.x += movePoint.x
            delivery.view.topSubView(at: delivery.index)?.frame.origin.y += movePoint.y
        }, completion: { (_) in
            guard let card = self.popDeliveryCard(with: delivery) else { return }
            destination.viewModel.push(card, at: destination.index)
        })
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
        wasteViewModel.removeAll()
        foundationViewModel.removeAll()
        tableauViewModel.removeAll()
        configureCard()
    }
}
