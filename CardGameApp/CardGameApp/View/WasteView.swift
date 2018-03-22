//
//  WasteView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class WasteView: UIStackView {

    private var config: ViewConfig!

    convenience init(_ config: ViewConfig, borderState: BorderState) {
        let size = CGSize(width: config.cardSize.width-config.horizontalStackSpacing, height: config.cardSize.height)
        self.init(frame: CGRect(origin: config.wastePosition, size: size))
        self.config = config
//        setupEmptySpace()
    }

//    private func setupEmptySpace() {
//        let emptySpace = UIImageView(frame: self.frame)
//        emptySpace.layer.cornerRadius = 5
//        emptySpace.clipsToBounds = true
//        emptySpace.layer.borderColor = UIColor.white.cgColor
//        emptySpace.layer.borderWidth = 2
//        self.addArrangedSubview(emptySpace)
//    }

    func appendCard(cardViewModel: CardViewModel) {
        let cardView = CardView(viewModel: cardViewModel, size: config.cardSize)
        appendCard(cardView: cardView)
    }

    func appendCard(cardView: CardView) {
        self.addArrangedSubview(cardView)
    }

    // 카드 뷰의 이미지 nil로 변경
    func eraseLastImage() {
        (self.arrangedSubviews.last as? CardView)?.removeImage()
    }

    // 카드 뷰 스택에서 제거
    func removeLastView() {
        guard let lastView = self.arrangedSubviews.last else { return }
        self.removeArrangedSubview(lastView)
    }

    func eraseAllImages() {
        for card in self.arrangedSubviews {
            guard let card = card as? CardView else { continue }
            card.removeImage()
        }
    }

    func removeAll() {
        for card in self.arrangedSubviews {
            guard let card = card as? CardView else { continue }
            self.removeArrangedSubview(card)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
