//
//  PatternUIView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class PatternUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        defalutBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defalutBackground()
    }
    
    private func defalutBackground() {
        if let backgroundPattern = UIImage(named: "bg_pattern.png") {
            self.backgroundColor = UIColor(patternImage: backgroundPattern)
        }
    }
}
