//
//  CardPileView.swift
//  CardGameApp
//
//  Created by 윤지영 on 04/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardPileView: UIView {
    var viewModel: CardPileViewModel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, viewModel: CardPileViewModel) {
        self.init(frame: frame)
        self.viewModel = viewModel
    }

    func push(_ cardView: CardView) {
        addSubview(cardView)
    }

}
