//
//  OpenedCardView.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 26..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class OpenedCardView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setOpenedCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setOpenedCard()
    }
    
    private func setOpenedCard() {
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 5
    }
    
    func reset() {
        image = UIImage()
    }
}
