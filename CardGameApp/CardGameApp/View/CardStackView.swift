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
    var cardStackImageViews: [UIImageView] = [UIImageView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Make ImageView
extension CardStackView {
    // 카드 스택 이미지 뷰를 처음 생성한다.
    func makeCardStackImageView(_ cardStack: CardStack?) {
        var imageViews = [UIImageView]()
        let images = makeCardImages(cardStack)
        images.forEach {imageViews.append(UIImageView(image: $0))}
        cardStackImageViews = imageViews
    }

    // 카드 스택 이미지 뷰를 변경한다.
    func changeImages(_ cardStack: CardStack?) {
        var images = makeCardImages(cardStack)
        cardStackImageViews.forEach { $0.image = images.removeFirst() }
    }

    // 카드 이미지 뷰를 만드는 함수 (마지막 카드만 카드 앞면.)
    private func makeCardImages(_ cardStack: CardStack?) -> [UIImage] {
        var images = [UIImage]()
        guard var stack = cardStack else {
            return images
        }
        while stack.count > 1 {
            guard let card = stack.pop() else {
                break
            }
            images.append(card.makeBackImage())
        }
        guard let card = stack.pop() else {
            return images
        }
        images.append(card.makeImage())
        return images

    }
}

// MARK: Layout
extension CardStackView {
    func setLayout() {
        // 0: emptyView ... last: show view
        setEmptyStackViewLayout()
        setCardStackViewLayout()
    }

    // 이미지가 있는 카드 스택 뷰 배치
    private func setCardStackViewLayout() {
        cardStackImageViews.forEach { (imageview: UIImageView) in
            let i = cardStackImageViews.index(of: imageview) ?? cardStackImageViews.endIndex
            self.addSubview(imageview)
            imageview.setRatio()
            imageview.top(equal: self, constant: CGFloat(i) * 30)
            imageview.leading(equal: self.leadingAnchor)
            imageview.trailing(equal: self.trailingAnchor)
            imageview.width(equal: self.widthAnchor)
        }
    }

    // 빈 카드 카드 스택 뷰 배치
    private func setEmptyStackViewLayout() {
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
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapRecognizer.numberOfTapsRequired = 2
        cardStackImageViews.forEach {
            $0.addGestureRecognizer(tapRecognizer)
            $0.isUserInteractionEnabled = true
        }

    }
}
