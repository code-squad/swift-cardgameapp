//
//  TableauView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class TableauView: UIStackView {

    private var view: UIView!
    private var config: ViewConfig!

    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        bringSubview(toFront: view)
    }

    func setupEmptySpace() {
        let emptySpace = UIImageView(frame: self.frame)
        emptySpace.layer.cornerRadius = 5
        emptySpace.clipsToBounds = true
        emptySpace.layer.borderColor = UIColor.white.cgColor
        emptySpace.layer.borderWidth = 2
        self.addArrangedSubview(emptySpace)
    }

    convenience init(_ view: UIView, _ config: ViewConfig) {
        self.init(frame: .zero)
        self.view = view
        self.config = config
        configure()
        updateBottomMargin()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func configure() {
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = -config.cardSize.height*0.7
    }

    var count: Int {
        return self.arrangedSubviews.count
    }

    // 다음 카드가 붙을 위치
    var nextYPosition: CGFloat {
        return CGFloat(count)*(config.cardSize.height*0.3)
    }

    func updateBottomMargin() {
        let stackHeight = view.frame.height-config.tableauPosition.y
//        let cardsHeight = CGFloat(count)*config.cardSize.height*0.3+config.cardSize.height
        let cardsHeight = (self.count > 0) ? CGFloat(count-1)*config.cardSize.height*0.3+config.cardSize.height : 0
        let bottomMarginToLastCard = stackHeight-cardsHeight
        setBottomMargin(bottomMarginToLastCard)
    }

    func appendCard(cardViewModel: CardViewModel?) {
        guard let cardViewModel = cardViewModel else { return }
        let cardView = CardView(viewModel: cardViewModel, size: config.cardSize)
        self.addArrangedSubview(cardView)
        updateBottomMargin()
    }

    func appendCard(cardView: CardView) {
        self.addArrangedSubview(cardView)
        updateBottomMargin()
    }

    // (계획) 여러 장으로 변경 시, 배열 사용하기
    func removeCard(cardView: CardView) {
        cardView.image = nil
        self.removeArrangedSubview(cardView)
        cardView.removeFromSuperview()
        updateBottomMargin()
    }

    func removeCards(count: Int) {
        for index in 0..<count {
            guard let cardView = self.arrangedSubviews[index] as? CardView else { break }
            removeCard(cardView: cardView)
        }
    }

    func removeAllCards() {
        removeCards(count: self.count)
    }

    func turnOverFrontCard() {
        (self.arrangedSubviews.last as? CardView)?.viewModel?.turnOver(toFace: .up)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
