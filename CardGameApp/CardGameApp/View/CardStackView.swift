//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView: UIView {

    // 카드 이미지 스택
    // var emptyView = UIImageView()
    let countOfCardDeck = 52
    let constants: CGFloat = 30

    var allCardStackViews = [UIImageView]()
    var cardImages = [UIImage]()
    var topIndex: Int? {
        if cardImages.isEmpty {
            return nil
        }
        return cardImages.count - 1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyView()
        setAllCardStackViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Make ImageView
extension CardStackView {
    // 카드 스택 이미지 뷰를 처음 생성한다.
    func setCardStackImageView(_ cardStack: CardStack) {
        cardImages = makeCardImages(cardStack)
        var i = 0
        cardImages.forEach {
            allCardStackViews[i].image = $0
            i += 1
        }
    }

    func resetCardStackImageView(_ cardStack: CardStack) {
        cardImages.removeAll()
        UIView.animate(
            withDuration: 0.5,
            animations: {
                var i: CGFloat = 0
                self.allCardStackViews.forEach {
                    $0.frame.origin.x = self.frame.origin.x
                    $0.frame.origin.y = self.frame.origin.y + i * 30
                    $0.isUserInteractionEnabled = false
                    i += 1
                }},
            completion: { _ in
                self.setCardStackImageView(cardStack)
                self.setEnabledGestureOfLastCard()
        })
    }

    func popCardStackView(previousCard: Card?) {
        // 현재꺼 비 활성화, 현재 카드 제거
        setDisabledGestureOfPreviousCard()
        cardImages.removeLast()
        // 위 카드 활성화
        guard let previous = previousCard,
            let index = self.topIndex else {
            return
        }
        allCardStackViews[index].image = previous.makeImage()
        allCardStackViews[index].isUserInteractionEnabled = true
    }

    func pushCardStackView(card: Card) {
        // 현재 카드 비 활성화
        setDisabledGestureOfPreviousCard()
        cardImages.append(card.makeImage())
        allCardStackViews[self.topIndex!].isUserInteractionEnabled = true
    }

    private func setDisabledGestureOfPreviousCard() {
        if let currentIndex = self.topIndex {
            allCardStackViews[currentIndex].isUserInteractionEnabled = false
        }
    }

    private func setEnabledGestureOfLastCard() {
        if let currentIndex = self.topIndex {
            allCardStackViews[currentIndex].isUserInteractionEnabled = true
        }
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
    private func setAllCardStackViews() {
        let imageViews = [UIImageView?](repeating: nil, count: countOfCardDeck)
        allCardStackViews = imageViews.map { _ in return UIImageView() }
        var i: CGFloat = 0
        allCardStackViews.forEach {
            self.addSubview($0)
            $0.setRatio()
            $0.top(equal: self, constant: i * constants)
            $0.leading(equal: self.leadingAnchor)
            $0.trailing(equal: self.trailingAnchor)
            $0.width(equal: self.widthAnchor)
            i += 1
        }

    }

    // 빈 카드 카드 스택 뷰 배치
    private func setEmptyView() {
        let emptyView = UIView().makeEmptyView()
        self.addSubview(emptyView)
        emptyView.setRatio()
        emptyView.top(equal: self)
        emptyView.leading(equal: self.leadingAnchor)
        emptyView.trailing(equal: self.trailingAnchor)
        emptyView.width(equal: self.widthAnchor)
    }

}

// MARK: Event
extension CardStackView {
    func addDoubleTapGesture(_ target: Any?, action: Selector) {
        allCardStackViews.forEach {
            let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
            tapRecognizer.numberOfTapsRequired = 2
            $0.addGestureRecognizer(tapRecognizer)
            $0.isUserInteractionEnabled = false
        }
        setEnabledGestureOfLastCard()
    }
}
