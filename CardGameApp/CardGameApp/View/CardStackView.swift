//
//  CardStackView.swift
//  CardGameApp
//
//  Created by 윤지영 on 28/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStackView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, viewModel: CardStackViewModel) {
        self.init(frame: frame)
        createCardViews(with: viewModel)
    }

    private func createCardViews(with viewModel: CardStackViewModel) {
        viewModel.iterateCardViewModels { [unowned self] cardViewModel in
            var frame = CGRect(origin: .zero, size: CardViewLayout.size)
            if let lastCardView = subviews.last {
                frame.origin.y = lastCardView.frame.origin.y + 20
            }
            let cardView = CardView(frame: frame, viewModel: cardViewModel)
            self.addSubview(cardView)
        }
    }

}
