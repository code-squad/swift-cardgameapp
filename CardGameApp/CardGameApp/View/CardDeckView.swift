//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardDeckView: UIImageView {
    private var viewModel: CardDeckViewModel!

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
        self.viewModel = viewModel
        createCardViews()
        registerAsObserver()
    }

    private func setRefreshImage() {
        image = UIImage(named: "cardgameapp-refresh-app")
    }

    private func createCardViews() {
        viewModel.iterateCardViewModels { [unowned self] cardViewModel in
            let cardView = CardView(frame: self.bounds, viewModel: cardViewModel)
            self.addSubview(cardView)
        }
    }

    func pop() -> CardView? {
        guard let cardView = subviews.last as? CardView else { return nil }
        cardView.removeFromSuperview()
        return cardView
    }

    func push(_ cardView: CardView) {
        addSubview(cardView)
    }

    private func registerAsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCardViews), name: .cardDeckReset, object: viewModel)
    }

    @objc private func updateCardViews() {
        for index in subviews.indices {
            viewModel.accessCardViewModel(at: index) { [unowned self] cardViewModel in
                if let cardView = self.subviews[index] as? CardView {
                    cardView.replace(viewModel: cardViewModel)
                }
            }
        }
    }

}
