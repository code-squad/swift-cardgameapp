//
//  CardView.swift
//  CardGameApp
//
//  Created by 윤동민 on 20/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setCardImage(name: String) {
        self.image = UIImage(named: name)
    }
    
    func setBackImage() {
        self.image = UIImage(named: "card-back")
    }
}
