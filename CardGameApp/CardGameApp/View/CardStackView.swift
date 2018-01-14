//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 12..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView: UIView {

    let constant = CGFloat(30)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: Make ImageView
extension CardStackView {
    // 카드 스택 이미지 뷰를 처음 생성한다.
    func setCardStackImageView(_ cardStack: CardStack) {
        let cardImageViews = makeCardImageViews(cardStack)
        cardImageViews.forEach {
            let cardIndex = CGFloat(subviews.count)
            self.addSubview($0)
            $0.setAutolayout()
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: cardIndex*constant).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
        }
    }

    func addDoubleTapGestureAllSubViews(action: Action) {
        subviews.forEach {
            let tapRecognizer = UITapGestureRecognizer(target: action.target, action: action.selector)
            tapRecognizer.numberOfTapsRequired = 2
            $0.addGestureRecognizer(tapRecognizer)
            $0.isUserInteractionEnabled = true
        }
    }

    func validUserInterationOnly(on index: Int) {
        subviews.forEach { $0.isUserInteractionEnabled = false }
        subviews[index].isUserInteractionEnabled = true
    }


    // 카드 이미지 뷰를 만드는 함수 (마지막 카드만 카드 앞면.)
    private func makeCardImageViews(_ cardStack: CardStack) -> [UIImageView] {
        var imageViews = [UIImageView]()
        var stack = cardStack
        guard let card = stack.pop() else {
            return []
        }
        let cardView = CardView(frame: frame)
        cardView.image = card.makeImage()
        imageViews.insert(UIImageView(image: card.makeImage()), at: 0)
        while !stack.isEmpty {
            guard let card = stack.pop() else {
                break
            }
            imageViews.insert(UIImageView(image: card.makeBackImage()), at: 0)
        }
        return imageViews
    }
}

// MARK: Layout
extension CardStackView {

    // 빈 카드 카드 스택 뷰 배치
    private func setEmptyView() {
        let emptyView = UIView().makeEmptyView()
        self.addSubview(emptyView)
        emptyView.fitLayout(with: self)
    }

}
