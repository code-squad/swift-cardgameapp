//
//  ReverseBoxView.swift
//  CardGameApp
//
//  Created by oingbong on 30/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ReverseBoxView: UIView {
    private let refreshImageView = RefreshImageView(image: UIImage(named: "cardgameapp-refresh-app".formatPNG))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emptyCard(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func emptyCard(tapGestureRecognizer: UITapGestureRecognizer) {
        let name = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    private func createdObservers() {
        let name = Notification.Name(NotificationKey.name.getBack)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getBack(_:)), name: name, object: nil)
    }
    
    @objc private func getBack(_ notification: Notification) {
        guard let cardViewList = notification.userInfo?[NotificationKey.hash.cardViewList] as? [CardImageView] else { return }
        for cardView in cardViewList {
            self.addSubview(cardView)
        }
    }
    
    public func defaultSetting() {
        guard let superView = self.superview else { return }
        let superWidth = superView.frame.width
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let xValue = space * Unit.fromLeftSpaceOfReverseBox + width * Unit.fromLeftWidthOfReverseBox
        reFrame(xValue: xValue)
        reSize(width: width)
        addRefresh()
        addGesture()
        createdObservers()
    }
    
    private func reFrame(xValue: CGFloat) {
        self.frame = CGRect(x: xValue, y: Unit.reverseBoxYValue, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    private func reSize(width: CGFloat) {
        self.frame.size = CGSize(width: width * Unit.widthRatio, height: width * Unit.heightRatio)
    }
    
    private func addRefresh() {
        self.addSubview(refreshImageView)
        refreshImageView.setting()
    }
}
