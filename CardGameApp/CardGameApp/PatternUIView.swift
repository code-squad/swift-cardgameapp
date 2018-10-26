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
        listCards()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defalutBackground()
        listCards()
    }
    
    private func defalutBackground() {
        if let backgroundPattern = UIImage(named: "bg_pattern.png") {
            self.backgroundColor = UIColor(patternImage: backgroundPattern)
        }
    }
    
    private func listCards() {
        let image = UIImage(named: "card-back.png")
        let cardBack = CardBackUIImageView(image: image)
        cardBack.reSize(with: self.frame)
        self.addSubview(cardBack)
    }
}
