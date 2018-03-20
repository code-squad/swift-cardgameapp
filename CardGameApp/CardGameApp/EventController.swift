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
    
    @objc func oneTappedCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended {
            guard let touchedView = touch.view else { return }
            NotificationCenter.default.post(name: .openCard, object: self, userInfo: [Notification.Name.openCard: touchedView])
        }
    }
    
    @objc func doubleTappedCard(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended && touch.numberOfTapsRequired == 2 {
            guard let touchedView = touch.view else { return }
            guard let originView = checkViewOrigin(touchedView) else { return }
            guard let fromGlobalPoint = touchedView.superview?.convert(touchedView.frame, to: originView.superview) else { return }
            let dummyCard = UIImageView()
            let location = touch.location(in: mainViewController.view)
            let xPoint = Int(location.x / (dummyCard.cardSize().width + dummyCard.marginBetweenCard()))
            let yPoint = Int(touchedView.frame.origin.y / 20)
            NotificationCenter.default.post(name: .playingGameCardStack,
                                            object: self,
                                            userInfo: [Notification.Name.cardLocation: CGPoint(x: xPoint, y: yPoint),
                                                       Notification.Name.touchedView: touchedView,
                                                       Notification.Name.subView: originView,
                                                       Notification.Name.fromGlobalPoint: fromGlobalPoint])
        }
    }
    
    private func checkViewOrigin(_ touchedView: UIView) -> UIView? {
        guard let originView = touchedView.superview?.superview else { return nil }
        switch originView.tag {
        case SubViewTag.foundationView.rawValue:
            return mainViewController.foundationView
        case SubViewTag.gameCardStackView.rawValue:
            return mainViewController.gameCardStackView
        case SubViewTag.openDeckView.rawValue:
            return mainViewController.openDeckView
        default:
            return nil
        }
    }
}
