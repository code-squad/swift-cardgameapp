//
//  CanFindGameView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 24..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol CanFindGameView {
    func handleCertainView(from view: UIView, execute: (GameView) -> Void)
}

extension CanFindGameView {
    func handleCertainView(from view: UIView, execute: (GameView) -> Void) {
        // GameView까지 올라가서 핸들러 작동
        var nextResponder = view.next
        while nextResponder != nil {
            if let gameView = nextResponder as? GameView {
                execute(gameView)
            }
            nextResponder = nextResponder?.next
        }
    }
}
