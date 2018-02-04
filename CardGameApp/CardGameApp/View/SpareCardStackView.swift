//
//  SpareCardViewStack.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 3..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class SpareCardStackView: CardViewStack {
    private var refreshImageView: UIImageView?
    private weak var revealedStackView: CardViewStack?

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ cardViews: [CardView], _ frame: CGRect, revealedStackView: CardViewStack?) {
        self.init(frame: frame)
        self.revealedStackView = revealedStackView
        if let refreshImageView = makeRefreshImageView() {
            self.refreshImageView = refreshImageView
            self.addArrangedSubview(refreshImageView)
        }
        cardViews.forEach { (cardView) in
            self.addArrangedSubview(cardView)
        }
    }

    private func makeRefreshImageView() -> UIImageView? {
        guard let refreshImage = UIImage(named: "cardgameapp-refresh-app") else { return nil }
        let imageView = UIImageView(image: refreshImage)
        imageView.isUserInteractionEnabled = true
        return imageView
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let lastCard = self.lastCard {
            lastCard.turnOver(true)
            revealedStackView?.addArrangedSubview(lastCard)
            self.removeArrangedSubview(lastCard)
        } else if touches.first?.view == refreshImageView {
            reset()
        }
    }

    func reset() {
        guard let subviews = revealedStackView?.arrangedSubviews,
            let subCardViews = subviews as? [CardView] else { return }
        for revealedCardView in subCardViews.reversed() {
            revealedCardView.turnOver(false)
            self.addArrangedSubview(revealedCardView)
            revealedStackView?.removeArrangedSubview(revealedCardView)
        }
    }

}
