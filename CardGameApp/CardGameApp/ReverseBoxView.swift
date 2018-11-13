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
        defaultSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetting()
    }
    
    private func defaultSetting() {
        addRefreshImageView()
        addGesture()
        createdObservers()
    }
    
    private func addRefreshImageView() {
        self.addSubview(refreshImageView)
        refreshImageView.setting()
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
    
    func removeSubView() {
        for subview in self.subviews {
            // RefreshImageView를 제외한 CardImageView만 제거
            guard let cardView = subview as? CardImageView else { continue }
            cardView.removeFromSuperview()
        }
    }
}
