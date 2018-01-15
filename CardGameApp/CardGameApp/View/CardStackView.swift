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
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: cardIndex*constant).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
        }
    }

    func topConstantOfLastCard() -> CGFloat {
        return subviews.last?.frame.origin.y ?? 0
    }

    func removeAllCardViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func popCardStackView(previousCard: Card) {
        subviews.last?.isUserInteractionEnabled = true
        ( self.subviews.last as? UIImageView)?.image = previousCard.makeImage()
    }

    func pushCardStackView(cardView: UIView) {
        subviews.last?.isUserInteractionEnabled = false
        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: (subviews.count-1).cgfloat*constant).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
        subviews.last?.isUserInteractionEnabled = true
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
        let count = stack.count
        while true {
            guard let card = stack.pop() else { break }
            let imageView = UIImageView()
            if stack.count == count - 1 {
                imageView.image = card.makeImage()
            } else { imageView.image = card.makeBackImage() }
            imageViews.insert(imageView, at: 0)
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
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        emptyView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 1.27).isActive = true
    }

}
