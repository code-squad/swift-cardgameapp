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

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        self.deck = Deck()
        self.deck.shuffle()
        makeOpenCards()
        makeEmptyCard()
        makeRestDeck()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func makeEmptyCard() {
        for index in 0..<4 {
            let emptyCard = UIImageView()
            emptyCard.makeCardView(index: index, yCoordinate: 20)
            self.view.addSubview(emptyCard)
        }
    }
    
    private func makeRestDeck() {
        guard let restOfcardCover = deck.getRestDeck().last else { return }
        let lastColumn = 6
        if !restOfcardCover.isUpside() {
            let backSide = UIImageView(image: UIImage(named: "card_back"))
            backSide.makeCardView(index: lastColumn, yCoordinate: UIApplication.shared.statusBarFrame.height)
            self.view.addSubview(backSide)
        }
    }
    
    private func makeOpenCards() {
        guard let stack = try? self.deck.makeStack(numberOfCards: 7) else { return }
        let playCardYPoint = CGFloat(80)
        for index in 0..<stack.count {
            let card = stack[index]
            card.flipCard()
            let cardView = UIImageView(image: UIImage(named: card.getCardName()))
            cardView.makeCardView(index: index, yCoordinate: UIApplication.shared.statusBarFrame.height + playCardYPoint)
            self.view.addSubview(cardView)
        }
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            makeOpenCards()
        }
    }
}
