//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStacksView: UIStackView {
    private var viewModel: CardStacksViewModel!

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
        self.viewModel = viewModel
        configureLayout()
        createCardStackViews()
        registerAsObserver()
    }

    func push(_ cardStackView: CardStackView) {
        addArrangedSubview(cardStackView)
    }

    private func configureLayout() {
        spacing = 5
        distribution = .fillEqually
    }

    private func createCardStackViews() {
        viewModel.iterateCardStackViewModels { [unowned self] cardStackViewModel in
            let cardStackView = CardStackView(frame: CGRect(), viewModel: cardStackViewModel)
            self.addArrangedSubview(cardStackView)
        }
    }

    private func registerAsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCardStackViews), name: .cardStacksReset, object: viewModel)
    }

    @objc private func updateCardStackViews() {
        for index in subviews.indices {
            viewModel.accessCardStackViewModel(at: index) { [unowned self] cardStackViewModel in
                if let cardStackView = self.subviews[index] as? CardStackView {
                    cardStackView.replace(viewModel: cardStackViewModel)
                }
            }
        }
    }

}
