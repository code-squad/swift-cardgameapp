//
//  CardEventController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 5..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class EventController {
    private var mainViewController: ViewController
    
    init(viewController: ViewController) {
        self.mainViewController = viewController
    }
    
    @objc func popCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended {
            mainViewController.openCardDeck()
        }
    }
    
    @objc func touchedGameCardStack(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended && touch.numberOfTapsRequired == 2 {
            guard let touchedView = touch.view else { return }
            let dummyCard = UIImageView()
            let location = touch.location(in: mainViewController.view)
            let xPoint = Int(location.x / (dummyCard.cardSize().width + dummyCard.marginBetweenCard()))
            let yPoint = Int(touchedView.frame.origin.y / 20)
            NotificationCenter.default.post(name: .playingGameCardStack,
                                            object: self,
                                            userInfo: [Notification.Name.cardLocation: CGPoint(x: xPoint, y: yPoint) as Any])
        }
    }
    
    @objc func touchedOpenDeck(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended && touch.numberOfTapsRequired == 2 {
            NotificationCenter.default.post(name: .playingOpenDeck, object: self)
        }
    }
}
