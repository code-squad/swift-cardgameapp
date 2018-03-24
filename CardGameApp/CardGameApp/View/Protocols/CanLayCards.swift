//
//  CanLayCards.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 24..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol CanLayCards {
    func lay(card: CardView)

    func removeLastCard()

    func nextCardPosition() -> CGPoint?
}
