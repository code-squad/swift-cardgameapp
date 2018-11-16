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
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapTableau(_:)), name: doubleTap, object: TableauContainerView.self)
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
            return
        }
        if lastCard.isKing() {
            kingEvent()
            return
        }
        normalEvent()
    }
    
    @objc private func doubleTapTableau(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        guard let lastCard = tableauViewModel.lastCard(index: index) else { return }
        guard lastCard.isFrontCondition() else { return }
        if lastCard.isAce() {
            aceEvent2(index: index)
            return
        }
        if lastCard.isKing() {
            kingEvent2(index: index)
            return
        }
        normalEvent2(index: index)
    }
    
    //    나머지 2이상 카드인 경우 왼쪽 상단에 같은 모양의 A가 있는 경우는 그 위로 이동시킨다.
    //    상단으로 이동할 수 없는 경우, 스택 중에서 좌측부터 앞면으로 된 카드 중 가장 위에 있는 카드와 다음 조건을 확인하고 조건에 맞으면 그 위로 이동시킨다.
    //    숫자가 하나 큰 카드가 있는지 확인한다. ex) 터치한 카드가 2인 경우 3, 10인 경우 J
    //    모양의 색이 다른지 확인한다. ex) 터치한 카드가 ♠️♣️ 이면 ♥️♦️
    private func normalEvent() {
        /*
         1. 나(waste)를 중심으로 Foundation에 한단계 아래 카드가 있는지 확인
         2. 있으면 그 위로 이동 / 없으면 다음
         3. Tableau 를 돌면서 가장 위에 있는 카드가 나보다 한단계 위이며 모양(색)이 다른지 확인
         4. 조건 맞으면 그 위로 이동 / 없으면 넘어감
         */
        // 1, 2
        guard let card = wasteViewModel.info() else { return }
        
        for index in 0..<foundationViewModel.count {
            guard foundationViewModel.isOneStepLower(with: card, index: index) else { continue }
            guard let popCard = wasteViewModel.pop() else { continue }
            wasteView.removeTopSubView()
            
            foundationViewModel.push(popCard, index: index)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: popCard, frame: rect)
            foundationContainerView.addTopSubView(index: index, view: cardView)
            break
        }
        
        // 3, 4
        for index in 0..<tableauViewModel.count {
            guard tableauViewModel.isOneStepHigher(with: card, index: index) else { continue }
            guard let popCard = wasteViewModel.pop() else { continue }
            wasteView.removeTopSubView()
            
            tableauViewModel.push(popCard, index: index)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: popCard, frame: rect)
            tableauContainerView.addTopSubView(index: index, view: cardView)
            break
        }
    }
    
    private func normalEvent2(index: Int) {
        /*
         1. 나(tableau)를 중심으로 다른 Foundation에 한단계 아래 카드가 있는지 확인 ( 같은 인덱스 제외? )
         2. 있으면 그 위로 이동 / 없으면 다음
         3. Tableau 를 돌면서 가장 위에 있는 카드가 나보다 한단계 위이며 모양(색)이 다른지 확인
         4. 조건 맞으면 그 위로 이동 / 없으면 넘어감
         */
        guard let card = tableauViewModel[index].info() else { return }
        for containerIndex in 0..<foundationViewModel.count {
            guard index != containerIndex else { continue } // 같은 인덱스 제외 (해야되나?)
            guard foundationViewModel.isOneStepLower(with: card, index: containerIndex) else { continue }
            guard let popCard = tableauViewModel[index].pop() else { continue }
            tableauContainerView.removeTopSubView(index: index)
            
            foundationViewModel.push(popCard, index: containerIndex)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: popCard, frame: rect)
            foundationContainerView.addTopSubView(index: containerIndex, view: cardView)
            break
        }
        
        for containerIndex in 0..<tableauViewModel.count {
            guard index != containerIndex else { continue } // 같은 인덱스 제외 (해야되나?)
            guard tableauViewModel.isOneStepHigher(with: card, index: containerIndex) else { continue }
            guard let popCard = tableauViewModel[index].pop() else { continue }
            tableauContainerView.removeTopSubView(index: index)
            
            tableauViewModel.push(popCard, index: containerIndex)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: popCard, frame: rect)
            tableauContainerView.addTopSubView(index: containerIndex, view: cardView)
            break
        }
    }
    
    private func kingEvent() {
        for index in 0..<tableauViewModel.count {
            guard tableauViewModel.isEmpty(index: index) else { continue }

            guard let card = wasteViewModel.pop() else { return }
            wasteView.removeTopSubView()
            
            tableauViewModel.push(card, index: index)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: card, frame: rect)
            tableauContainerView.addTopSubView(index: index, view: cardView)
            break
        }
    }
    
    private func kingEvent2(index: Int) {
        for containerIndex in 0..<tableauViewModel.count {
            guard tableauViewModel.isEmpty(index: containerIndex) else { continue }

            guard let card = tableauViewModel.pop(index: index) else { return }
            tableauContainerView.removeTopSubView(index: index)
            
            tableauViewModel.push(card, index: containerIndex)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: card, frame: rect)
            tableauContainerView.addTopSubView(index: containerIndex, view: cardView)
            break
        }
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
    
    private func aceEvent2(index: Int) {
        guard let card = tableauViewModel[index].pop() else { return }
        tableauContainerView.removeTopSubView(index: index)

        // Foundation 중 왼쪽부터 비어있는 곳에 animate
        for containerIndex in 0..<foundationViewModel.count {
            guard foundationViewModel.isEmpty(index: containerIndex) else { continue }
            foundationViewModel.push(card, index: containerIndex)
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let cardView = CardImageView(card: card, frame: rect)
            foundationContainerView.addTopSubView(index: containerIndex, view: cardView)
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
        foundationContainerView.removeAllSubView()
        tableauContainerView.removeAllSubView()
        stockViewModel.removeAll()
        wasteViewModel.removeAll()
        foundationViewModel.removeAll()
        tableauViewModel.removeAll()
        cardConfigure()
    }
}
