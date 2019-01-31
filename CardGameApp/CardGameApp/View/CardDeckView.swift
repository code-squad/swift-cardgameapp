//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardDeckView: CardStackView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    private func setRefreshImage() {
        image = UIImage(named: "cardgameapp-refresh-app")
    }

    func popWithRefreshImage() -> CardView? {
        if willBeEmpty() {
            setRefreshImage()
        }
        return super.pop()
    }

}
