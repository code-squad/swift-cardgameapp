//
//  ViewController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 26..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var eventController: EventController!
    
    private var deck: Deck!
    private var openDeck: OpenDeck!
    private var gameCardStack: GameCardStack!
    private var foundationDeck: FoundationDeck!
    
    private var openDeckView: OpenDeckView!
    private var gameCardStackView: GameCardStackView!
    private var foundationView: FoundationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deck = Deck()
        self.openDeck = OpenDeck()
        self.gameCardStack = GameCardStack(with: self.deck)
        self.foundationDeck = FoundationDeck()
        self.eventController = EventController(viewController: self)
        self.foundationView = FoundationView(frame: CGRect(x: CGFloat(ScreenPoint.startXPoint),
                                                           y: UIApplication.shared.statusBarFrame.height,
                                                           width: (self.view.cardSize().width + self.view.marginBetweenCard()) * 4,
                                                           height: self.view.cardSize().height))
        self.openDeckView = OpenDeckView(frame: CGRect(origin: self.view.makeViewPoint(columnIndex: CGFloat(ScreenPoint.openCardXPoint),
                                                                                       rowIndex: CGFloat(ScreenPoint.startYPoint)),
                                                       size: self.view.cardSize()))
        self.gameCardStackView = GameCardStackView(frame: CGRect(x: CGFloat(ScreenPoint.startXPoint),
                                                                 y: self.view.cardSize().height
                                                                    + self.view.marginBetweenCard()
                                                                    + UIApplication.shared.statusBarFrame.height,
                                                                 width: UIScreen.main.bounds.size.width,
                                                                 height: UIScreen.main.bounds.size.height
                                                                    - UIApplication.shared.statusBarFrame.height
                                                                    - (self.view.cardSize().height
                                                                        + self.view.marginBetweenCard())))
        makeGameTable()
        NotificationCenter.default.addObserver(self, selector: #selector(playGameCardStack(notification:)), name: .playingGameCardStack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playOpenDeck(notification:)), name: .playingOpenDeck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openCardDeck(notification:)), name: .openCard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popOpenCard(notification:)), name: .popOpenCard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushFoundationView(notification:)), name: .pushFoundation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popCardGameStackView(notification:)), name: .popCardGameStack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushCardGameStackView(notification:)), name: .pushCardGameStack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(flipCardView(notification:)), name: .flipCard, object: nil)
    }
    
    private func makeGameTable() {
        guard let deck = try? self.gameCardStack.startCardGame() else { return }
        self.deck = deck
        makeBackGround()
        makeDeckView()
        foundationView.makeFoundation()
        gameCardStackView.makeStackBackView()
        self.view.addSubview(foundationView)
        self.view.addSubview(gameCardStackView)
        self.view.addSubview(openDeckView)
        makeGameCardStackView()
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
    
    private func makeDeckView() {
        guard let restOfcardCover = deck.getRestDeck().last else { return }
        if !restOfcardCover.isUpside() {
            let backSide = UIImageView(image: UIImage(named: "card_back"))
            backSide.makeCardView(index: CGFloat(ScreenPoint.lastXpoint))
            
            let gesture = UITapGestureRecognizer(target: eventController,
                                                 action: #selector (eventController.popCard(_:)))
            backSide.addGestureRecognizer(gesture)
            backSide.isUserInteractionEnabled = true
            backSide.tag = 1
            
            self.view.addSubview(backSide)
        }
    }
    
    // Game Table View Setting::START
    private func makeGameCardStackView() {
        let tableStacks = makeColumnView()
        var column = 0
        for cardView in tableStacks {
            for index in 0..<cardView.count {
                cardView[index].makeStackView(cardsRow: index)
                gameCardStackView.subviews[column].addSubview(cardView[index])
                addDoubleTapGestureStack(view: cardView[index])
            }
            column += 1
        }
    }
    
    private func makeColumnView() -> [[UIImageView]] {
        var cardStackView = [[UIImageView]]()
        for cards in gameCardStack.cardStacksOfTable {
            cardStackView.append(makeCardStacks(deck: cards))
        }
        return cardStackView
    }
    
    private func makeCardStacks(deck: Deck) -> [UIImageView] {
        var stacks = [UIImageView]()
        for card in deck.cards {
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
    
    private func addDoubleTapGestureStack(view: UIView) {
        let gesture = UITapGestureRecognizer(target: eventController,
                                             action: #selector(eventController.touchedGameCardStack(_:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        gesture.numberOfTapsRequired = 2
    }
    // Game Table View Setting::END
    
    // Open Deck View Setting::STRAT
    @objc private func openCardDeck(notification: Notification) {
        if let oneCard = deck.popCard() {
            oneCard.flipCard()
            let cardView = UIImageView(image: UIImage(named: oneCard.getCardName()))
            cardView.makeCardView()
            addDoubleTapGestureOpen(view: cardView)
            self.openDeckView.addSubview(cardView)
            openDeck.pushCard(oneCard)
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
    
    private func addDoubleTapGestureOpen(view: UIView) {
        let gesture = UITapGestureRecognizer(target: eventController,
                                             action: #selector(eventController.touchedOpenDeck(_:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        gesture.numberOfTapsRequired = 2
    }
    // Open Deck View Setting::END
    
    // Play Game Model::START
    @objc private func playGameCardStack(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let point = userInfo[Notification.Name.cardLocation] as? CGPoint else { return }
        let pickedCard = gameCardStack.cardStacksOfTable[Int(point.x)].cards[Int(point.y)]
        guard pickedCard.isUpside() else { return }
        guard let lastCard = gameCardStack.cardStacksOfTable[Int(point.x)].lastCard() else { return }
        guard pickedCard == lastCard else { return }
        
        if pickedCard.isAceCard() && foundationDeck.pushAce(pickedCard) {
            gameCardStack.popCard(xPoint: Int(point.x))
        } else if pickedCard.isKingCard() && gameCardStack.pushKing(pickedCard) {
            gameCardStack.popCard(xPoint: Int(point.x))
        } else if foundationDeck.isContinuousCard(pickedCard) {
            foundationDeck.pushCard(pickedCard)
            gameCardStack.popCard(xPoint: Int(point.x))
        } else if let validIndex = gameCardStack.choicePlace(with: pickedCard) {
            gameCardStack.pushCard(card: pickedCard, index: validIndex)
            gameCardStack.popCard(xPoint: Int(point.x))
        }
    }

    @objc private func playOpenDeck(notification: Notification) {
        guard let pickedCard = openDeck.lastCard() else { return }
        if pickedCard.isAceCard() && foundationDeck.pushAce(pickedCard) {
            openDeck.popCard()
        } else if pickedCard.isKingCard() && gameCardStack.pushKing(pickedCard) {
            openDeck.popCard()
        } else if foundationDeck.isContinuousCard(pickedCard) {
            foundationDeck.pushCard(pickedCard)
            openDeck.popCard()
        } else if let validIndex = gameCardStack.choicePlace(with: pickedCard) {
            gameCardStack.pushCard(card: pickedCard, index: validIndex)
            openDeck.popCard()
        }
    }
    // Play Game Model::END
    
    @objc private func popOpenCard(notification: Notification) {
        guard let lastView = openDeckView.subviews.last else { return }
        lastView.removeFromSuperview()
    }
    
    @objc private func pushFoundationView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let foundationIndex = userInfo[Notification.Name.cardLocation] as? Int else { return }
        guard let cardName = userInfo[Notification.Name.cardName] as? String else { return }
        
        let newCard = UIImageView(image: UIImage(named: cardName))
        newCard.makeCardView()
        newCard.makeZeroOrigin()
        foundationView.subviews[foundationIndex].addSubview(newCard)
    }
    
    @objc private func pushCardGameStackView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let index = userInfo[Notification.Name.cardLocation] as? Int else { return }
        guard let cardName = userInfo[Notification.Name.cardName] as? String else { return }
        	
        let yPoint = gameCardStack.cardStacksOfTable[index].cards.endIndex - 1
        let newCard = UIImageView(image: UIImage(named: cardName))
        newCard.makeStackView(cardsRow: yPoint)
        newCard.frame.origin.x = 0
        gameCardStackView.subviews[index].addSubview(newCard)
    }
    
    @objc private func popCardGameStackView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let index = userInfo[Notification.Name.cardLocation] as? Int else { return }
        guard let lastView = gameCardStackView.subviews[index].subviews.last else { return }
        lastView.removeFromSuperview()
    }
    
    @objc private func flipCardView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let index = userInfo[Notification.Name.cardLocation] as? Int else { return }
        guard let cardName = userInfo[Notification.Name.cardName] as? String else { return }
        guard let lastView = gameCardStackView.subviews[index].subviews.last else { return }
        lastView.removeFromSuperview()
        
        let yPoint = gameCardStack.cardStacksOfTable[index].cards.endIndex - 1
        let newCard = UIImageView(image: UIImage(named: cardName))
        newCard.makeStackView(cardsRow: yPoint)
        newCard.frame.origin.x = 0
        gameCardStackView.subviews[index].addSubview(newCard)
        
    }
}

extension ViewController {
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            self.deck = Deck()
            self.foundationDeck = FoundationDeck()
            self.openDeck = OpenDeck()
            self.gameCardStack = GameCardStack(with: self.deck)
            self.view.subviews.forEach { $0.removeFromSuperview() }
            self.gameCardStackView.subviews.forEach { $0.removeFromSuperview() }
            self.foundationView.subviews.forEach { $0.removeFromSuperview() }
            self.openDeckView.subviews.forEach { $0.removeFromSuperview() }
            makeGameTable()
        }
    }
}
