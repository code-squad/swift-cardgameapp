//
//  canHandleGesture.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol CanHandleGesture: class {
    func handleSingleTapOnSpare()
    func handleDoubleTapOnCard(tappedView: CardView, recognizer: UITapGestureRecognizer)
}

protocol CanUpdateViewModel: class {
    var gameView: GameView! { get }
    func updateMovedCards(movableCardView: MovableCardView)
//    func updateMovedCards(from fromLocation: Location, to toLocation: Location)
}
