//
//  CardStackMovableModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

protocol MovableViewModel {
    @discardableResult func pop(index: Int, count: Int) -> [Card]
    func push(index: Int, cards: [Card])
    func top(index: Int) -> Card?
    func targetIndex(card: Card) -> Int?
    func lastShowCards(index: Int, count: Int) -> [Card]?
}
