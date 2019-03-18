//
//  SpaceView.swift
//  CardGameApp
//
//  Created by 윤동민 on 21/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class SpaceView: UIView {
    private var cardViews: [CardView]
    
    required init?(coder aDecoder: NSCoder) {
        cardViews = []
        super.init(coder: aDecoder)
        initialSetting()
    }
    
    override init(frame: CGRect) {
        cardViews = []
        super.init(frame: frame)
        initialSetting()
    }
    
    private func initialSetting() {
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
        self.clipsToBounds = false
    }
    
    func addCardView(_ cardView: CardView) {
        cardViews.append(cardView)
        self.addSubview(cardView)
    }
}
