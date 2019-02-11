//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardDeckView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init(frame: CGRect, viewModel: CardDeckViewModel) {
        self.init(frame: frame)
        createCardViews(with: viewModel)
        registerAsObserver(of: viewModel)
    }

    private func createCardViews(with viewModel: CardDeckViewModel) {
        viewModel.iterateCardViewModels { [unowned self] cardViewModel in
            let cardView = CardView(frame: self.bounds, viewModel: cardViewModel)
            self.addSubview(cardView)
        }
    }

    private func registerAsObserver(of viewModel: CardDeckViewModel) {
        NotificationCenter.default.addObserver(self, selector: #selector(setRefreshImage), name: .cardDeckWillBeEmpty, object: viewModel)
    }

    @objc private func setRefreshImage() {
        image = UIImage(named: "cardgameapp-refresh-app")
    }

    func push(_ cardView: CardView) {
        addSubview(cardView)
    }

    func pop() -> CardView? {
        guard let cardView = subviews.last as? CardView else { return nil }
        cardView.removeFromSuperview()
        return cardView
    }

}
