//
//  CardViewStackDataSource.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 5..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol CardViewStackDataSource {
    func spareCards() -> CardStack?

    func dealedCards(_ stud: Int) -> CardStack?
//    var revealedCardViewStack: CardViewStack { get }
//
//    func spareCardViews() -> [CardView]?
//
//    func vacantSpaces() -> [CardView]?
//
//    func dealedCardViews(on stackColumn: Int) -> [CardView]?
}
