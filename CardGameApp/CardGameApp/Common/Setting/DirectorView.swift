//
//  DirectorFoundationView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 18..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class DirectorView {
    
    func createFoundationView(_ builder: FoundationViewable) -> UIImageView {
        let builder = builder.instance()
        .setBorderColor(with: UIColor.white.cgColor)
        .setBorderWith(with: 1)
        .setContentMode(with: .scaleAspectFit)
        .setClipsToBounds(with: true)
        .setCornerRadius(with: 5)
        
        return builder.foundationView
    }
    
    func createCardView(_ builder: CardViewable) -> UIImageView {
        let builder = builder.instance()
        .setImage(with: "card-back")
        .setContentMode(with: .scaleAspectFit)
        .setClipsToBounds(with: true)
        .setCornerRadius(with: 5)
        
        return builder.cardView
    }

}
