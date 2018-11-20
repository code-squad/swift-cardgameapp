//
//  StockView.swift
//  CardGameApp
//
//  Created by oingbong on 30/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class StockView: UIView, CardView {
    private let refreshImageView = RefreshImageView(image: UIImage(named: Unit.refreshImage.formatPNG))
    var dataSource: SingleDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    override func layoutSubviews() {
        removeAllSubView()
        addAllSubview()
    }
    
    private func removeAllSubView() {
        for subview in self.subviews {
            // RefreshImageView를 제외한 CardImageView만 제거
            guard let cardView = subview as? CardImageView else { continue }
            cardView.removeFromSuperview()
        }
    }
    
    private func addAllSubview() {
        dataSource?.card {
            let cardView = CardImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            cardView.image = $0.image()
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

extension StockView: DeliverableView {
    func drawSubView() {
        setNeedsLayout()
    }
    
    func convert(at index: Int?, to view: UIView) -> CGPoint? {
        return self.convert(self.bounds.origin, to: view)
    }
    
    func topSubView(at index: Int?) -> UIView? {
        guard let top = self.subviews.last else { return nil }
        return top
    }
}
