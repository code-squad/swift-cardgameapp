//
//  RefreshImageView.swift
//  CardGameApp
//
//  Created by oingbong on 31/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class RefreshImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setting() {
        guard let superView = self.superview else { return }
        self.frame.size = CGSize(width: superView.frame.width * Unit.refreshRatio, height: superView.frame.height * Unit.refreshRatio)
        self.center = CGPoint(x: superView.frame.width * Unit.refreshPoint, y: superView.frame.height * Unit.refreshPoint)
    }
}
