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
        self.deck = try? self.gameTable.dealTheCardOfGameTable()
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
            stacks.append(choiceCardFace(with: card) )
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
