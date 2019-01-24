//
//  GamePlayer.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol GamePlayer {
    func take(card: Card)
    func showCards() -> String
    func resetCards()
    var name: String { get }
    var bestHand: Hand? { get }
}
