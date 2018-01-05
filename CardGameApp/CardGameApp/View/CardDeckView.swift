//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 5..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardDeckView: UIView {
    var cardDeckImageViews: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        cardDeckImageViews = makeEmptyCardView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CardDeckView {
    private func makeEmptyCardView() -> [UIImageView] {
        let views = [UIImageView?](repeating: nil, count: 4)
        let newViews = views.flatMap { _ in return UIImageView().makeEmptyView() as? UIImageView }
        return newViews
    }

    func setLayout() {
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.setAutolayout()
        stackView.top(equal: self)
        stackView.leading(equal: self.leadingAnchor)
        stackView.axis = .horizontal
        cardDeckImageViews.forEach {
            stackView.addArrangedSubview($0)
            $0.setRatio()
            $0.width(constant: ViewController.Size.cardWidth)
        }
        stackView.distribution = .fillEqually
        stackView.spacing = 3
    }
}
