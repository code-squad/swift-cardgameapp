//
//  FoundationView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 6..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class FoundationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension FoundationView {
    func makeFoundation() {
        for column in 0..<4 {
            let cardPlace = UIImageView()
            cardPlace.makeCardView(index: CGFloat(column), yPoint: 0)
            self.addSubview(cardPlace)
        }
    }
}
