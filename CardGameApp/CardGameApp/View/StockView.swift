//
//  StockView.swift
//  CardGameApp
//
//  Created by oingbong on 30/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class StockView: UIView {
    private let refreshImageView = RefreshImageView(image: UIImage(named: "cardgameapp-refresh-app".formatPNG))
    
    override init(frame: CGRect) {
        let superWidth = Unit.iphone8plusWidth
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let stockXValue = space * Unit.fromLeftSpaceOfStock + width * Unit.fromLeftWidthOfStock
        let newFrame = CGRect(x: stockXValue, y: Unit.stockYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio)
        super.init(frame: newFrame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        addGesture()
        refreshSetting()
    }
    
    private func refreshSetting() {
        self.addSubview(refreshImageView)
        refreshImageView.configure()
    }
    
    func addTopSubView(_ view: CardImageView) {
        addGestureCardView(with: view)
        self.addSubview(view)
    }
    
    func removeTopSubView() {
        self.subviews[subviews.count - 1].removeFromSuperview()
    }
    
    func removeAllSubView() {
        for subview in self.subviews {
            // RefreshImageView를 제외한 CardImageView만 제거
            guard let cardView = subview as? CardImageView else { continue }
            cardView.removeFromSuperview()
        }
    }
}

extension StockView {
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emptyCard(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func emptyCard(tapGestureRecognizer: UITapGestureRecognizer) {
        let name = Notification.Name(NotificationKey.name.restore)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    private func addGestureCardView(with view: CardImageView) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.tapAction(tapGestureRecognizer:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
}
