//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackDummyView: UIStackView {

    let constant = CGFloat(30)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setCardStackDummyView(_ cardStackView: [CardStackView] ) {
        var i = 0
        subviews.forEach {
            $0.addSubview(cardStackView[i])
            i += 1
        }
    }

    func removeCardStackDummyView() {
        subviews.forEach { (view: UIView) in
            guard let cardStackView = view as? CardStackView else {
                return
            }
            cardStackView.removeAllCardViews()
        }
    }

}
