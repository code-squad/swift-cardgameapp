//
//  ConcreateDeckView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 19..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class ConcreateCardView: CardViewable {
    
    var cardView: UIImageView = UIImageView()
    
    func instance() -> CardViewable {
        self.cardView = UIImageView()
        return self
    }
    
    func setImage(with cardName: String) -> CardViewable {
        self.cardView.image = UIImage(named: cardName)
        return self
    }
    
    func setContentMode(with contentmode: UIViewContentMode) -> CardViewable {
        self.cardView.contentMode = contentmode
        return self
    }
    
    func setClipsToBounds(with bounds: Bool) -> CardViewable {
        self.cardView.clipsToBounds = bounds
        return self
    }
    
    func setCornerRadius(with radius: CGFloat) -> CardViewable {
        self.cardView.layer.cornerRadius = radius
        return self
    }
    
    
}
