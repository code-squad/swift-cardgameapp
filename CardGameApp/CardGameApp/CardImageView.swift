//
//  CardImageView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 31..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    //MARK: - Properties
    
    weak var dataSource: CardImageViewDataSource?
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(card: CardImageViewDataSource) {
        
        self.dataSource = card
        super.init(image: dataSource?.image())
        addAspectRatioConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        addAspectRatioConstraint()
    }
    
    //MARK: Private
    
    private func addAspectRatioConstraint() {
        
        let aspectRatioConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .width,
                                                       multiplier: 1.27,
                                                       constant: 0)
        self.addConstraint(aspectRatioConstraint)
    }
}


