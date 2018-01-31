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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        self.deck = Deck()
        self.gameTable = Table(with: self.deck)
        makeTableOpenCards()
        makeFoundation()
        makeDeck()
    }
    
    private func makeFoundation() {
        for index in 0..<4 {
            let cardPlace = UIImageView()
            cardPlace.makeCardView(index: CGFloat(index), yPoint: UIApplication.shared.statusBarFrame.height)
            self.view.addSubview(cardPlace)
        }
    }
    
    private func makeDeck() {
        guard let restOfcardCover = deck.getRestDeck().last else { return }
        let lastColumn = 6
        if !restOfcardCover.isUpside() {
            let backSide = UIImageView(image: UIImage(named: "card_back"))
            backSide.makeCardView(index: CGFloat(lastColumn), yPoint: UIApplication.shared.statusBarFrame.height)
            let gesture = UITapGestureRecognizer(target: self,
                                                 action: #selector (popCard(_:)))
            backSide.addGestureRecognizer(gesture)
            backSide.isUserInteractionEnabled = true
            self.view.addSubview(backSide)
        }
    }
    
    @objc private func popCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended {
            if let oneCard = deck.popCard() {
                oneCard.flipCard()
                let cardView = UIImageView(image: UIImage(named: oneCard.getCardName()))
                cardView.makeCardView(index: 4.5, yPoint: UIApplication.shared.statusBarFrame.height)
                self.view.addSubview(cardView)
            } else if deck.isEmptyDeck() {
                let button = UIImageView(image: UIImage(named: "cardgameapp-refresh-app"))
                button.makeRefreshButton()
                self.view.addSubview(button)
            }
        }
    }
    
    private func makeTableOpenCards() {
        self.deck = try? self.gameTable.dealTheCardOfGameTable()
        let tableStacks = makeColumnView()
        var column = 0
        for cardView in tableStacks {
            for index in 0..<cardView.count {
                cardView[index].makeStackView(column: column, cardsRow: index)
                self.view.addSubview(cardView[index])
            }
            column += 1
        }
    }
    
    private func makeColumnView() -> [[UIImageView]] {
        var cardStackView = [[UIImageView]]()
        var cardView = UIImageView()
        for cards in gameTable.cardStacksOfTable {
            var stacks = [UIImageView]()
            for card in cards {
                if card.isUpside() {
                    cardView = UIImageView(image: UIImage(named: card.getCardName()))
                } else {
                    cardView = UIImageView(image: UIImage(named: "card_back"))
                }
                stacks.append(cardView)
            }
            cardStackView.append(stacks)
        }
        return cardStackView
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            self.deck = Deck()
            self.gameTable = Table(with: self.deck)
            makeTableOpenCards()
        }
    }
}
