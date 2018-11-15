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
    
    func addTopSubView(_ view: UIImageView) {
        self.addSubview(view)
    }
    
    func removeTopSubView() {
        self.subviews[subviews.count - 1].removeFromSuperview()
    }
    
    func removeAllSubView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
