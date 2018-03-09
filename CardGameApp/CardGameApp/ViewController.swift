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
    private var gameTable: Table!
    private var eventController: CardEventController!
    private var foundationView: FoundationView!
    private var stackView: CardStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        self.deck = Deck()
        self.gameTable = Table(with: self.deck)
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
        makeGameTable()
    }
    
    func makeGameTable() {
        guard let deck = try? self.gameTable.dealTheCardOfGameTable() as? Deck else {
            return
        }
        self.deck = deck
        makeDeck()
        foundationView.makeFoundation()
        stackView.makeStackBackView()
        self.view.addSubview(foundationView)
        self.view.addSubview(stackView)
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
                let gesture = UITapGestureRecognizer(target: eventController,
                                                     action: #selector(eventController.moveFoundation(_:)))
                cardView[index].addGestureRecognizer(gesture)
                cardView[index].isUserInteractionEnabled = true
                gesture.numberOfTapsRequired = 2
                stackView.subviews[column].addSubview(cardView[index])
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
    
    func openedCardDeck() {
        if let oneCard = deck.popCard() {
            oneCard.flipCard()
            let cardView = UIImageView(image: UIImage(named: oneCard.getCardName()))
            cardView.makeCardView(index: 4.5)
            let gesture = UITapGestureRecognizer(target: eventController,
                                                 action: #selector(eventController.moveOpenedCardFoundation(_:)))
            cardView.addGestureRecognizer(gesture)
            cardView.isUserInteractionEnabled = true
            gesture.numberOfTapsRequired = 2
            self.view.addSubview(cardView)
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
        
    }
    
    @objc private func doubleTapStackView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let cardLocation = userInfo["cardLocation"] as? CGPoint else { return }
        let dummyCard = UIImageView()
        let column = Int(cardLocation.x / (dummyCard.cardSize().width + dummyCard.marginBetweenCard()))
        if let lastCard = gameTable.cardStacksOfTable[column].last {
            if lastCard.getCardName().hasSuffix(Card.Rank.one.rawValue) {
                
            }
        }
        
    }
    
}

extension ViewController {
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            self.deck = Deck()
            self.gameTable = Table(with: self.deck)
            self.view.subviews.forEach { $0.removeFromSuperview() }
            makeGameTable()
        }
    }
}
