//
//  CardEventController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 5..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

protocol CardGameInfo {
    mutating func popCard() -> Card?
    func isEmptyDeck() -> Bool
}

class CardEventController {
    private var deck: CardGameInfo
    private var mainViewController: UIViewController
    
    init(deck: CardGameInfo, viewController: UIViewController) {
        self.deck = deck
        self.mainViewController = viewController
    }
    
    @objc func popCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended {
            if let oneCard = deck.popCard() {
                oneCard.flipCard()
                let cardView = UIImageView(image: UIImage(named: oneCard.getCardName()))
                cardView.makeCardView(index: 4.5)
                mainViewController.view.addSubview(cardView)
            } else if deck.isEmptyDeck() {
                makeRefreshButtonView()
            }
        }
    }
    
    @objc func moveFoundation(_ touch: UITapGestureRecognizer) {
        touch.numberOfTapsRequired = 2
        if touch.state == .ended {
            print("Double Tap!")
        }
    }
    
    private func makeRefreshButtonView() {
        let button = UIImageView(image: UIImage(named: "cardgameapp-refresh-app"))
        button.refreshButton()
        if let deckCoverView = mainViewController.view.viewWithTag(1) {
            deckCoverView.removeFromSuperview()
        }
        mainViewController.view.addSubview(button)
    }
}
