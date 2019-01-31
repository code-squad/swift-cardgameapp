//
//  CardStackView.swift
//  CardGameApp
//
//  Created by 윤지영 on 28/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStackView: UIImageView {
    private var cardViews: [CardView]

    var viewModel: CardStackViewModelDelegate! {
        didSet {
            viewModel.imagesDidChange = { [unowned self] viewModel in
                self.setImages(named: viewModel.imageNames)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        cardViews = []
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        cardViews = []
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: CGRect())
    }

    var isEmpty: Bool {
        return cardViews.isEmpty
    }

    func willBeEmpty() -> Bool {
        if cardViews.count == 1 {
            return true
        }
        return false
    }

    func push(_ cardView: CardView) {
        cardViews.append(cardView)
        addSubview(cardView)
    }

    func setImages(named names: [String?]?) {
        guard let names = names else { return }
        for (index, name) in names.enumerated() {
            guard index < cardViews.count else { return }
            cardViews[index].setImage(named: name)
        }
    }

    func pop() -> CardView? {
        if cardViews.isEmpty { return nil }
        let cardView = cardViews.removeLast()
        cardView.removeFromSuperview()
        return cardView
    }

    func flipLast() {
        viewModel.flipLast()
    }

}
