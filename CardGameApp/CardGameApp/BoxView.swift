//
//  BoxView.swift
//  CardGameApp
//
//  Created by oingbong on 31/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class BoxView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetting()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func defaultSetting() {
        let superWidth = Unit.iphone8plusWidth
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let xValue = space * Unit.fromLeftSpaceOfBox + width * Unit.fromLeftWidthOfBox
        updateFrame(xValue: xValue, width: width)
        createdObservers()
    }

    private func updateFrame(xValue: CGFloat, width: CGFloat) {
        self.frame = CGRect(x: xValue, y: Unit.reverseBoxYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio)
    }
    
    private func createdObservers() {
        let moveToBox = Notification.Name(NotificationKey.name.moveToBox)
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveToBox(_:)), name: moveToBox, object: nil)
        let restore = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.addObserver(self, selector: #selector(self.restore), name: restore, object: nil)
    }
    
    @objc private func moveToBox(_ notification: Notification) {
        guard let view = notification.userInfo?[NotificationKey.hash.view] as? UIView else { return }
        self.addSubview(view)
    }
    
    @objc private func restore() {
        var cardViewList = [CardImageView]()
        var index = 1
        for _ in 0..<self.subviews.count {
            guard let cardView = self.subviews[self.subviews.count - index] as? CardImageView else { continue }
            cardView.turnOver()
            cardViewList.append(cardView)
            index += 1
        }
        let name = Notification.Name(NotificationKey.name.getBack)
        NotificationCenter.default.post(name: name, object: nil, userInfo: [NotificationKey.hash.cardViewList: cardViewList])
    }
    
    func removeSubView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
