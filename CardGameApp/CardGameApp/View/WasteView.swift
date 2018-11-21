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
    
    override func layoutSubviews() {
        removeAllSubView()
        addAllSubView()
    }
    
    private func removeAllSubView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    private func addAllSubView() {
        dataSource?.card {
            let cardView = CardImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            cardView.image = $0.image()
            addGestureCardView(with: cardView)
            self.addSubview(cardView)
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

extension WasteView: DeliverableView, DestinationView {
    func drawSubView() {
        setNeedsLayout()
    }
    
    func convert(at index: Int?, to view: UIView) -> CGPoint? {
        return self.convert(Unit.basePoint, to: view)
    }
    
    func topSubView(at index: Int?) -> UIView? {
        guard let top = self.subviews.last else { return nil }
        return top
    }    
}
