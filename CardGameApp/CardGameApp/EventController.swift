//
//  CardEventController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 5..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit
typealias Position = (from: CGRect, target: CGRect)

class EventController {
    
    @objc func oneTappedCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended {
            guard let touchedView = touch.view else { return }
            NotificationCenter.default.post(name: .openCard, object: self, userInfo: [Notification.Name.cardLocation: touchedView.frame])
        }
    }
    
    @objc func doubleTappedCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended && touch.numberOfTapsRequired == 2 {
            guard let touchedView = touch.view else { return }
            // as? CardView()
            guard let cardView = touchedView as? CardView else { return }
//            guard let originView = touchedView.superview?.superview else { return }
//            guard let fromGlobalPoint = touchedView.superview?.convert(touchedView.frame, to: originView.superview) else { return }
            guard let originView = cardView.getOriginView() else { return }
            guard let fromGlobalPoint = cardView.convertGlobalLocation() else { return }
            let location = touch.location(in: originView)
            let xPoint = Int(location.x / (CardView.cardSize().width + CardView.marginBetweenCard()))
            let yPoint = Int(touchedView.frame.origin.y / 20)
            NotificationCenter.default.post(name: .playingGameCardStack,
                                            object: self,
                                            userInfo: [Notification.Name.cardLocation: CGPoint(x: xPoint, y: yPoint),
                                                       Notification.Name.touchedView: touchedView,
                                                       Notification.Name.subView: originView,
                                                       Notification.Name.fromGlobalPoint: fromGlobalPoint])
        }
    }
}
