//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView: UIView {

    let countOfCardDeck = 52
    let constant = CGFloat(30)
    var cardImageViews = [UIImageView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Make ImageView
extension CardStackView {
    // 카드 스택 이미지 뷰를 처음 생성한다.
    func setCardStackImageView(_ cardStack: CardStack) {
        let cardImages = makeCardImages(cardStack)
        cardImages.forEach {
            cardImageViews.append(UIImageView(image: $0))
        }
        addCardViewAndSetLayout()
    }

    func resetCardStackImageView(_ cardStack: CardStack) {
        cardImageViews.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        setEmptyView()
        setCardStackImageView(cardStack)
    }

    func popCardStackView(previousCard: Card?) {
        // 현재꺼 비 활성화, 현재 카드 제거
        cardImageViews.removeLast()
        cardImageViews.last?.isUserInteractionEnabled = true
        ( self.subviews.last as? UIImageView)?.image = previousCard?.makeImage()
       // self.subviews.last?.removeFromSuperview()
    }

    func pushCardStackView(_ cardView: UIImageView) {
        // 현재 카드 비 활성화
        self.subviews.last?.isUserInteractionEnabled = false
        self.addSubview(cardView)
        self.subviews.last?.fitLayout(with: self, topConstant: constant * cardImageViews.count.cgfloat)
        self.subviews.last?.isUserInteractionEnabled = true
        cardImageViews.append(cardView)
    }

    // 카드 이미지 뷰를 만드는 함수 (마지막 카드만 카드 앞면.)
    private func makeCardImages(_ cardStack: CardStack) -> [UIImage] {
        var images = [UIImage]()
        var stack = cardStack
        guard let card = stack.pop() else {
            return images
        }
        images.insert(card.makeImage(), at: 0)
        while !stack.isEmpty {
            guard let card = stack.pop() else {
                break
            }
            images.insert(card.makeBackImage(), at: 0)
        }
        return images
    }
}

// MARK: Layout
extension CardStackView {
    private func addCardViewAndSetLayout() {
        var i: CGFloat = 0
        cardImageViews.forEach {
            self.addSubview($0)
            $0.fitLayout(with: self, topConstant: i * constant)
            i += 1
        }
    }

    // 빈 카드 카드 스택 뷰 배치
    private func setEmptyView() {
        let emptyView = UIView().makeEmptyView()
        self.addSubview(emptyView)
        emptyView.fitLayout(with: self)
    }

}

// MARK: Event
extension CardStackView {
    func addDoubleTapGesture(action: Action) {
        cardImageViews.forEach {
            let tapRecognizer = UITapGestureRecognizer(target: action.target, action: action.selector)
            tapRecognizer.numberOfTapsRequired = 2
            $0.addGestureRecognizer(tapRecognizer)
            $0.isUserInteractionEnabled = false
        }
        cardImageViews.last?.isUserInteractionEnabled = true
    }
}
