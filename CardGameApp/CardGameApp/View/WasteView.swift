//
//  WasteView.swift
//  CardGameApp
//
//  Created by oingbong on 31/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class WasteView: UIView, CardView {
    var dataSource: SingleDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func draw() {
        removeAllSubView()
        addAllSubView()
    }
    
    private func addAllSubView() {
        guard let cardStack = dataSource?.cardStack() else { return }
        for card in cardStack.list() {
            card.flipCondition(with: .front)
            let cardView = CardImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            cardView.image = card.image()
            addGestureCardView(with: cardView)
            self.addSubview(cardView)
        }
    }
    
    private func removeAllSubView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension WasteView {
    private func addGestureCardView(with view: CardImageView) {
        let doubleTapGesture = UITapGestureRecognizer(target: view, action: #selector(view.dobuleTapActionWaste(tapGestureRecognizer:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(doubleTapGesture)
    }
}

extension WasteView: DeliverableView {
    func draw(index: Int?) {
        draw()
    }
}
