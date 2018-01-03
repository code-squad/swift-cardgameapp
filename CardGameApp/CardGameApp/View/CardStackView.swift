//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView: UIView {
    var cardStackImageViews: [UIImageView] = [UIImageView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CardStackView {
    func makeCardStackImageView(_ cardStack: CardStack?) {
        var imageViews = [UIImageView]()
        let images = makeCardImages(cardStack)
        images.forEach {imageViews.append(UIImageView(image: $0))}
        cardStackImageViews = imageViews
    }

    func changeImages(_ cardStack: CardStack?) {
        var images = makeCardImages(cardStack)
        cardStackImageViews.forEach { $0.image = images.removeFirst() }
    }

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

    func setLayout() {
        setEmptyStackViewLayout()
        setCardStackViewLayout()
    }

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
