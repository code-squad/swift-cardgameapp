//
//  SpareCardViewStack.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 3..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class SpareCardViewStack: CardViewStack {
    override var dataSource: CardViewStackDataSource? {
        didSet {
            // 데이터소스가 준비되면 카드뷰에 이미지를 세팅하고, 마지막에 새로고침 이미지를 붙인다.
            self.setupCardImages()
            self.addArrangedSubview(refreshImageView)
        }
    }
    private var revealedStackView: CardViewStack?
    private var refreshImageView: UIImageView = {
        let refreshImage = UIImage(named: Constants.ImageName.refresh)
        let imageView = UIImageView(image: refreshImage)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, cardViews: [CardView], revealedStackView: CardViewStack) {
        self.init(frame: frame)
        setupCardViews(cardViews)
        self.revealedStackView = revealedStackView
    }
}

extension SpareCardViewStack {
    func setupCardImages() {
        guard let spareCards = dataSource?.spareCards() else { return }
        for (index, spareCard) in spareCards.reversed().enumerated() {
            guard let subCardviews = subCardviews else { continue }
            subCardviews[index].setImage(cardInfo: spareCard)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let frontCard = self.arrangedSubviews.first as? CardView {
            frontCard.turnOver(true)
            revealedStackView?.addArrangedSubview(frontCard)
            self.removeArrangedSubview(frontCard)
        } else if touches.first?.view == refreshImageView {
            reset()
        }
    }

    func reset() {
        guard let revealedSubCardviews = revealedStackView?.arrangedSubviews as? [CardView] else { return }
        for revealedCardView in revealedSubCardviews {
            revealedCardView.turnOver(false)
            self.addArrangedSubview(revealedCardView)
            revealedStackView?.removeArrangedSubview(revealedCardView)
        }
        // refresh 이미지도 떼어지기 때문에 다시 붙여야 정상작동한다.
        defer {
            self.addArrangedSubview(refreshImageView)
        }
    }
}
