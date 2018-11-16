//
//  WasteView.swift
//  CardGameApp
//
//  Created by oingbong on 31/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class WasteView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTopSubView(_ view: CardImageView) {
        self.addSubview(view)
        addGestureCardView(with: view)
    }
    
    func removeAllSubView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func removeTopSubView() {
        self.subviews[subviews.count - 1].removeFromSuperview()
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
    func removeTopSubView(index: Int?) {
        self.subviews[subviews.count - 1].removeFromSuperview()
    }
}
