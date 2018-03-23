//
//  ViewController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 26..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

typealias Position = (from: CGRect, target: CGRect)

class ViewController: UIViewController {
    private var eventController: EventController!
    private var deck: Deck!
    private var openDeck: OpenDeck!
    private var gameCardStack: GameCardStack!
    private var foundationDeck: FoundationDeck!
    private (set) var openDeckView: OpenDeckView!
    private (set) var gameCardStackView: GameCardStackView!
    private (set) var foundationView: FoundationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deck = Deck()
        self.openDeck = OpenDeck()
        self.gameCardStack = GameCardStack(with: self.deck)
        self.foundationDeck = FoundationDeck()
        self.eventController = EventController()
        self.foundationView = FoundationView(frame: CGRect(x: CGFloat(ScreenPoint.startXPoint),
                                                           y: UIApplication.shared.statusBarFrame.height,
                                                           width: (UIView.cardSize().width + UIView.marginBetweenCard()) * 4,
                                                           height: UIView.cardSize().height))
        self.openDeckView = OpenDeckView(frame: CGRect(origin: self.view.makeViewPoint(columnIndex: CGFloat(ScreenPoint.openCardXPoint),
                                                                                       rowIndex: CGFloat(ScreenPoint.startYPoint)),
                                                       size: UIView.cardSize()))
        self.gameCardStackView = GameCardStackView(frame: CGRect(x: CGFloat(ScreenPoint.startXPoint),
                                                                 y: UIView.cardSize().height
                                                                    + UIView.marginBetweenCard()
                                                                    + UIApplication.shared.statusBarFrame.height,
                                                                 width: UIScreen.main.bounds.size.width,
                                                                 height: UIScreen.main.bounds.size.height
                                                                    - UIApplication.shared.statusBarFrame.height
                                                                    - (UIView.cardSize().height
                                                                        + UIView.marginBetweenCard())))
        makeGameTable()
        NotificationCenter.default.addObserver(self, selector: #selector(playGameCardStack(notification:)), name: .playingGameCardStack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openCardDeck(notification:)), name: .openCard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popOpenCardView(notification:)), name: .popOpenCard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushOpenCardView(notification:)), name: .pushOpenCard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushFoundationView(notification:)), name: .pushFoundation, object: nil)
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
        openDeckView.makeBasicSubView()
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
                                                 action: #selector (eventController.oneTappedCard(_:)))
            backSide.addGestureRecognizer(gesture)
            backSide.isUserInteractionEnabled = true
            backSide.tag = SubViewTag.deck.rawValue
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
                addDoubleTapGesture(view: cardView[index])
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
    
    private func addDoubleTapGesture(view: UIView) {
        let gesture = UITapGestureRecognizer(target: eventController,
                                             action: #selector(eventController.doubleTappedCard(_:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        gesture.numberOfTapsRequired = 2
    }
    // Game Table View Setting::END
    
    // Play Game Model::START
    @objc private func openCardDeck(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let fromPoint = userInfo[Notification.Name.cardLocation] as? CGRect else { return }
        if let oneCard = deck.popCard() {
            oneCard.flipCard()
            let cardView = moveableCardView(oneCard)
            cardView.frame = fromPoint
            self.view.addSubview(cardView)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                           delay: 0.0,
                                                           options: [.curveLinear],
                                                           animations: { [weak self = self] in
                                                            guard let targetFrame = self?.openDeckView.frame else { return }
                                                            cardView.frame = targetFrame },
                                                           completion: { [weak self = self] _ in
                                                            cardView.removeFromSuperview()
                                                            self?.openDeck.pushCard(card: oneCard, index: 0) })
        } else if deck.isEmptyDeck() {
            let button = UIImageView(image: UIImage(named: "cardgameapp-refresh-app"))
            button.refreshButton()
            self.view.subviews[SubViewTag.deck.rawValue].removeFromSuperview()
            self.view.addSubview(button)
        }
    }
    
    private func checkCardGameModel(_ originView: UIView) -> CardGameMoveAble? {
        switch originView.tag {
        case SubViewTag.foundationView.rawValue:
            return foundationDeck
        case SubViewTag.gameCardStackView.rawValue:
            return gameCardStack
        case SubViewTag.openDeckView.rawValue:
            return openDeck
        default:
            return nil
        }
    }
    
    @objc private func playGameCardStack(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let originView = userInfo[Notification.Name.subView] as? UIView else { return }
        guard let point = userInfo[Notification.Name.cardLocation] as? CGPoint else { return }
        guard let fromPoint = userInfo[Notification.Name.fromGlobalPoint] as? CGRect else { return }
        guard let originDeck = checkCardGameModel(originView) else { return }
        guard let originGameView = originView as? CardGameView else { return }
        let pickedCard = originDeck.pickCard(xIndex: Int(point.x), yIndex: Int(point.y))
        guard pickedCard.isUpside() else { return }
        guard let lastCard = originDeck.lastCard(xIndex: Int(point.x)) else { return }
        guard pickedCard == lastCard else { return }
        guard let gameInfo = choicePlace(card: pickedCard) else { return }
        
        let cardView = moveableCardView(pickedCard)
        
        self.view.addSubview(cardView)
        cardView.frame = fromPoint
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: 0.0,
                                                       options: [.curveLinear],
                                                       animations: { [weak self = self] in
                                                        self?.view.bringSubview(toFront: cardView)
                                                        cardView.frame = gameInfo.targetFrame
                                                        originGameView.removeStackViewLast(index: Int(point.x)) },
                                                       completion: { _ in
                                                        cardView.removeFromSuperview()
                                                        gameInfo.targetDeck.pushCard(card: pickedCard, index: gameInfo.index)
                                                        originDeck.popCard(xPoint: Int(point.x)) })
    }
    
    private func moveableCardView(_ pickedCard: Card) -> UIImageView {
        let cardView = UIImageView(image: UIImage(named: pickedCard.getCardName()))
        cardView.makeCardView()
        cardView.makeZeroOrigin()
        return cardView
    }
    
    private func choicePlace(card: Card) -> (targetFrame: CGRect, targetDeck: CardGameMoveAble, index: Int)? {
        if card.isAceCard() {
            guard let emptyIndex = foundationDeck.calculateEmptyPlace() else { return nil }
            let targetGlobalPoint = foundationView.convert(foundationView.subviews[emptyIndex].frame, to: self.view)
            return (targetGlobalPoint, foundationDeck, emptyIndex)
        } else if card.isKingCard() {
            guard let emptyIndex = gameCardStack.calculateEmptyPlace() else { return nil }
            let dummyCardOrigin  = CGPoint(x: gameCardStackView.subviews[emptyIndex].frame.origin.x, y: 0)
            let dummyCard = CGRect(origin: dummyCardOrigin, size: UIView.cardSize())
            let targetGlobalPoint = gameCardStackView.convert(dummyCard, to: self.view)
            return (targetGlobalPoint, gameCardStack, emptyIndex)
        } else if foundationDeck.isContinuousCard(card) {
            guard let index = foundationDeck.calculateSameGroup(card) else { return nil }
            let targetGlobalPoint = foundationView.convert(foundationView.subviews[index].frame, to: self.view)
            return (targetGlobalPoint, foundationDeck, index)
        } else if let validIndex = gameCardStack.choicePlace(with: card) {
            let xPoint = gameCardStackView.subviews[validIndex.xPoint].frame.origin.x
            let dummyCardOrigin  = CGPoint(x: xPoint, y: CGFloat(validIndex.yPoint * 20 + 20))
            let dummyCard = CGRect(origin: dummyCardOrigin, size: UIView.cardSize())
            let targetGlobalPoint = gameCardStackView.convert(dummyCard, to: self.view)
            return (targetGlobalPoint, gameCardStack, validIndex.xPoint)
        }
        return nil
    }
    // Play Game Model::END
    
    @objc private func popOpenCardView(notification: Notification) {
        guard let lastView = openDeckView.subviews.last else { return }
        lastView.removeFromSuperview()
    }
    
    @objc private func pushOpenCardView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let cardName = userInfo[Notification.Name.cardName] as? Card else { return }
        let cardView = UIImageView(image: UIImage(named: cardName.getCardName()))
        cardView.makeCardView()
        cardView.makeZeroOrigin()
        addDoubleTapGesture(view: cardView)
        self.openDeckView.subviews[0].addSubview(cardView)
    }
}

extension ViewController {
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
        guard let xPoint = userInfo[Notification.Name.cardLocation] as? Int else { return }
        guard let cardName = userInfo[Notification.Name.cardName] as? String else { return }
        
        let yPoint = gameCardStack.cardStacksOfTable[xPoint].cards.endIndex - 1
        let newCard = UIImageView(image: UIImage(named: cardName))
        newCard.makeStackView(cardsRow: yPoint)
        newCard.frame.origin.x = 0
        gameCardStackView.subviews[xPoint].addSubview(newCard)
        addDoubleTapGesture(view: newCard)
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
        addDoubleTapGesture(view: newCard)
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
