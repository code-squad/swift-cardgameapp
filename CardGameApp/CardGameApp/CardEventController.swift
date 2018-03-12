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
    mutating func makeStack(numberOfCards: Int) throws -> [Card]
    mutating func shuffle()
}

class CardEventController {
    private var deck: CardGameInfo
    private var mainViewController: ViewController
    
    init(deck: CardGameInfo, viewController: ViewController) {
        self.deck = deck
        self.mainViewController = viewController
    }
    
    @objc func popCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended {
            mainViewController.openCardDeck()
        }
    }
    
    @objc func moveFoundation(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended && touch.numberOfTapsRequired == 2 {
            NotificationCenter.default.post(name: .doubleTapStack,
                                            object: self,
                                            userInfo: ["cardLocation": touch.location(in: mainViewController.view) as Any])
        }
    }
    
    @objc func moveOpenedCardFoundation(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended && touch.numberOfTapsRequired == 2 {
            NotificationCenter.default.post(name: .doubleTapOpenedCard,
                                            object: self,
                                            userInfo: ["cardLocation": touch.location(in: mainViewController.view) as Any])
        }
    }
}
