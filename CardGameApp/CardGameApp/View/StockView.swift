//
//  StockView.swift
//  CardGameApp
//
//  Created by oingbong on 30/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class StockView: UIView {
    private let refreshImageView = RefreshImageView(image: UIImage(named: Unit.refreshImage.formatPNG))
    var dataSource: SingleDataSource?
    
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
    
    func draw() {
        removeAllSubView()
        addAllSubView()
    }
    
    private func removeAllSubView() {
        for subview in self.subviews {
            // RefreshImageView를 제외한 CardImageView만 제거
            guard let cardView = subview as? CardImageView else { continue }
            cardView.removeFromSuperview()
        }
    }
    
    private func addAllSubView() {
        guard let cardStack = dataSource?.cardStack() else { return }
        for card in cardStack.list() {
            card.switchCondition(with: .back)
            let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            let cardView = CardImageView(card: card, frame: rect)
            addGestureCardView(with: cardView)
            self.addSubview(cardView)
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
