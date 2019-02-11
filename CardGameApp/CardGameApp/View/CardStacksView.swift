//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStacksView: UIStackView {

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    convenience init(frame: CGRect, viewModel: CardStacksViewModel) {
        self.init(frame: frame)
        configureLayout()
        createCardStackViews(with: viewModel)
    }

    private func configureLayout() {
        spacing = 5
        distribution = .fillEqually
    }

    private func createCardStackViews(with viewModel: CardStacksViewModel) {
        viewModel.iterateCardStackViewModels { [unowned self] cardStackViewModel in
            let cardStackView = CardStackView(frame: CGRect(), viewModel: cardStackViewModel)
            self.addArrangedSubview(cardStackView)
        }
    }

}
