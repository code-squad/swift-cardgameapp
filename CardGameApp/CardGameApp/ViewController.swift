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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        self.deck = Deck()
        self.gameTable = Table(with: self.deck)
        self.eventController = CardEventController(deck: self.deck, viewController: self)
        makeGameTable()
    }
    
    func makeGameTable() {
        makeTableColumnCards()
        makeFoundation()
        makeDeck()
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
    
    private func makeFoundation() {
        for column in 0..<4 {
            let cardPlace = UIImageView()
            cardPlace.makeCardView(index: CGFloat(column))
            self.view.addSubview(cardPlace)
        }
    }
    
    private func makeTableColumnCards() {
        self.deck = try? self.gameTable.dealTheCardOfGameTable()
        let tableStacks = makeColumnView()
        var column = 0
        for cardView in tableStacks {
            for index in 0..<cardView.count {
                cardView[index].makeStackView(column: column, cardsRow: index)
                let gesture = UITapGestureRecognizer(target: eventController,
                                                     action: #selector (eventController.moveFoundation(_:)))
                cardView[index].addGestureRecognizer(gesture)
                cardView[index].isUserInteractionEnabled = true
                self.view.addSubview(cardView[index])
            }
            column += 1
        }
    }
    
    private func makeDoubleTapGesture() {
        
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
