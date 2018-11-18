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
}
