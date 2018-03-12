//
//  ViewController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 26..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var deck: Deck!
    private var openDeck: OpenDeck!
    private var gameTable: Table!
    private var foundationDeck: FoundationDeck!
    private var eventController: CardEventController!
    private var foundationView: FoundationView!
    private var stackView: CardStackView!
    private var openDeckView: OpenDeckView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        self.deck = Deck()
        self.openDeck = OpenDeck()
        self.gameTable = Table(with: self.deck)
        self.foundationDeck = FoundationDeck()
        self.eventController = CardEventController(deck: self.deck, viewController: self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doubleTapStackView(notification:)),
                                               name: .doubleTapStack,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doubleTapOpenedCard(notification:)),
                                               name: .doubleTapOpenedCard,
                                               object: nil)
        self.foundationView = FoundationView(frame: CGRect(x: 0,
                                                           y: UIApplication.shared.statusBarFrame.height,
                                                           width: (self.view.cardSize().width + self.view.marginBetweenCard()) * 4,
                                                           height: self.view.cardSize().height))
        self.stackView = CardStackView(frame: CGRect(x: 0,
                                                     y: 80 + UIApplication.shared.statusBarFrame.height,
                                                     width: UIScreen.main.bounds.size.width,
                                                     height: UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - 80))
        self.openDeckView = OpenDeckView(frame: CGRect(origin: self.view.makeViewPoint(columnIndex: 4.5, rowIndex: 0),
                                                       size: self.view.cardSize()))
        makeGameTable()
    }
    
    private func makeGameTable() {
        guard let deck = try? self.gameTable.dealTheCardOfGameTable() as? Deck else {
            return
        }
        self.deck = deck
        makeDeck()
        foundationView.makeFoundation()
        stackView.makeStackBackView()
        self.view.addSubview(foundationView)
        self.view.addSubview(stackView)
        self.view.addSubview(openDeckView)
        makeTableColumnCards()
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
    
    private func makeDeck() {
        guard let restOfcardCover = deck.getRestDeck().last else { return }
        let lastColumn = 6
        if !restOfcardCover.isUpside() {
            let backSide = UIImageView(image: UIImage(named: "card_back"))
            backSide.makeCardView(index: CGFloat(lastColumn))
            let gesture = UITapGestureRecognizer(target: eventController,
                                                 action: #selector (eventController.popCard(_:)))
            backSide.addGestureRecognizer(gesture)
            backSide.isUserInteractionEnabled = true
            backSide.tag = 1
            self.view.addSubview(backSide)
        }
    }
    
    private func makeTableColumnCards() {
        let tableStacks = makeColumnView()
        var column = 0
        for cardView in tableStacks {
            for index in 0..<cardView.count {
                cardView[index].makeStackView(cardsRow: index)
                stackView.subviews[column].addSubview(cardView[index])
                addDoubleTapGesture(view: cardView[index])
            }
            column += 1
        }
    }
    
    private func makeColumnView() -> [[UIImageView]] {
        var cardStackView = [[UIImageView]]()
        for cards in gameTable.cardStacksOfTable {
            cardStackView.append(makeCardStacks(cards: cards))
        }
        return cardStackView
    }
    
    private func makeCardStacks(cards: [Card]) -> [UIImageView] {
        var stacks = [UIImageView]()
        for card in cards {
            stacks.append(choiceCardFace(with: card))
        }
        return stacks
    }
    
    private func choiceCardFace(with card: Card) -> UIImageView {
        var cardView = UIImageView()
        if card.isUpside() {
            cardView = UIImageView(image: UIImage(named: card.getCardName()))
        } else {
            cardView = UIImageView(image: UIImage(named: "card_back"))
        }
        return cardView
    }
    
    func openCardDeck() {
        if let oneCard = deck.popCard() {
            oneCard.flipCard()
            let cardView = UIImageView(image: UIImage(named: oneCard.getCardName()))
            cardView.makeCardView()
            let gesture = UITapGestureRecognizer(target: eventController,
                                                 action: #selector(eventController.moveOpenedCardFoundation(_:)))
            cardView.addGestureRecognizer(gesture)
            cardView.isUserInteractionEnabled = true
            gesture.numberOfTapsRequired = 2
            self.openDeckView.addSubview(cardView)
            openDeck.appendCard(oneCard)
        } else if deck.isEmptyDeck() {
            makeRefreshButtonView()
        }
    }
    
    private func makeRefreshButtonView() {
        let button = UIImageView(image: UIImage(named: "cardgameapp-refresh-app"))
        button.refreshButton()
        if let deckCoverView = self.view.viewWithTag(1) {
            deckCoverView.removeFromSuperview()
        }
        self.view.addSubview(button)
    }
    
    @objc private func doubleTapOpenedCard(notification: Notification) {
        guard let lastCard = openDeck.popCard() else { return }
        if lastCard.getCardName().hasSuffix(Card.Rank.one.rawValue) {
            pushFoundationView(card: lastCard)
        }
    }
    
    @objc private func doubleTapStackView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let cardLocation = userInfo["cardLocation"] as? CGPoint else { return }
        let dummyCard = UIImageView()
        let column = Int(cardLocation.x / (dummyCard.cardSize().width + dummyCard.marginBetweenCard()))
        guard let lastCard = gameTable.cardStacksOfTable[column].last else { return }
        
        if lastCard.getCardName().hasSuffix(Card.Rank.one.rawValue) {
            pushFoundationView(stackColumn: column, card: lastCard)
            _ = gameTable.popCard(column: column)
            filpLastStackCardView(stackColumn: column)
        }
    }
    
    private func addDoubleTapGesture(view: UIView) {
        let gesture = UITapGestureRecognizer(target: eventController,
                                             action: #selector(eventController.moveFoundation(_:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        gesture.numberOfTapsRequired = 2
    }
    
    private func pushFoundationView(stackColumn: Int, card: Card) {
        let movableCard = stackView.subviews[stackColumn].subviews[gameTable.cardStacksOfTable[stackColumn].endIndex - 1]
        movableCard.frame.origin = CGPoint.zero
        let foundationColumn = foundationDeck.appendDecks(card)
        foundationView.subviews[foundationColumn].addSubview(movableCard)
    }
    
    private func pushFoundationView(card: Card) {
        guard let movableCard = openDeckView.subviews.last else { return }
        let foundationColumn = foundationDeck.appendDecks(card)
        movableCard.frame.origin = CGPoint.zero
        foundationView.subviews[foundationColumn].addSubview(movableCard)
    }
    
    private func filpLastStackCardView(stackColumn: Int) {
        guard let beforeLastCard = gameTable.cardStacksOfTable[stackColumn].last else { return }
        guard let lastView = stackView.subviews[stackColumn].subviews.last else { return }
        beforeLastCard.flipCard()
        let filpCard = choiceCardFace(with: beforeLastCard)
        filpCard.makeBasicView()
        filpCard.makeStackView(cardsRow: gameTable.cardStacksOfTable[stackColumn].endIndex - 1)
        stackView.removeStackViewLast(cardView: lastView)
        stackView.subviews[stackColumn].addSubview(filpCard)
        addDoubleTapGesture(view: lastView)
    }
}

extension ViewController {
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            self.deck = Deck()
            self.foundationDeck = FoundationDeck()
            self.openDeck = OpenDeck()
            self.gameTable = Table(with: self.deck)
            self.view.subviews.forEach { $0.removeFromSuperview() }
            self.stackView.subviews.forEach { $0.removeFromSuperview() }
            self.foundationView.subviews.forEach { $0.removeFromSuperview() }
            self.openDeckView.subviews.forEach { $0.removeFromSuperview() }
            makeGameTable()
        }
    }
}
