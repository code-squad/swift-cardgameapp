//
//  RefreshImageView.swift
//  CardGameApp
//
//  Created by oingbong on 31/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class RefreshImageView: UIImageView {
    private let refreshRatio = CGFloat(0.3)
    private let refreshPoint = CGFloat(0.5)
    
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
        self.frame.size = CGSize(width: superView.frame.width * refreshRatio, height: superView.frame.height * refreshRatio)
        self.center = CGPoint(x: superView.frame.width * refreshPoint, y: superView.frame.height * refreshPoint)
    }
}
