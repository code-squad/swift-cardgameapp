//
//  CardBackUIImageView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("began")
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: superview?.superview)
//        print(location)
//        UIView.animate(withDuration: 0.1) {
////            let movePoint = CGPoint(
////                x: toPoint.x - fromPoint.x,
////                y: toPoint.y - fromPoint.y)
////            delivery.view.topSubView(at: delivery.index)?.frame.origin.x += movePoint.x
////            delivery.view.topSubView(at: delivery.index)?.frame.origin.y += movePoint.y
////            self.frame.origin.x = location.x
////            self.frame.origin.y = location.y
//            self.frame.origin.x =
//            self.frame.origin.y = location.y
//        }
//    }
}

extension CardImageView {
    @objc public func tapAction(tapGestureRecognizer: UITapGestureRecognizer) {
        let name = Notification.Name(NotificationKey.name.moveToWaste)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    @objc public func dobuleTapActionWaste(tapGestureRecognizer: UITapGestureRecognizer) {
        let name = Notification.Name(NotificationKey.name.doubleTap)
        NotificationCenter.default.post(name: name, object: WasteView.self)
    }
    
    @objc public func dobuleTapActionTableau(tapGestureRecognizer: CustomUITapGestureRecognizer) {
        let name = Notification.Name(NotificationKey.name.doubleTap)
        let cardIndex = tapGestureRecognizer.index
        NotificationCenter.default.post(name: name, object: TableauContainerView.self, userInfo: [NotificationKey.hash.index: cardIndex])
    }
    
    @objc public func panAction(tapGestureRecognizer: CustomUIPanGestureRecognizer) {
        let name = Notification.Name("drag")
        let index = tapGestureRecognizer.index
        let subIndex = tapGestureRecognizer.subIndex
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["recognizer": tapGestureRecognizer, "index": index, "subIndex": subIndex])
    }
}
