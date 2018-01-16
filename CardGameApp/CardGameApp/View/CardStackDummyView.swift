//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackDummyView: UIStackView {

    weak var delegate: CardStackDummyViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setCardStackDummyView(_ cardStacks: [CardStack]) {
        addCardStackViews(cardStacks)
    }

    private func addCardStackViews(_ cardStacks: [CardStack]) {
        var i = 0
        subviews.forEach {
            let cardStack = cardStacks[i]
            guard let stackview = $0 as? CardStackView else { return }
            let action = Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:)))
            stackview.setCardStackImageView(cardStack)
            stackview.addDoubleTapGestureAllSubViews(action: action)
            stackview.validUserInterationOnlyLastCard()
            i += 1
        }
    }

    func removeCardStackDummyView() {
        subviews.forEach {
            guard let stackview = $0 as? CardStackView else { return }
            stackview.removeAllCardViews()
        }
    }

    func moveX(from startIndex: Int, to targetIndex: Int) -> CGFloat {
        let startX = subviews[startIndex].frame.origin.x
        let targetX = subviews[targetIndex].frame.origin.x
        return targetX - startX
    }

    func moveY(from startIndex: Int, to targetIndex: Int) -> CGFloat {
        guard let startCardStackview = subviews[startIndex] as? CardStackView,
            let targetCardStackview = subviews[targetIndex] as? CardStackView else {
            return CGFloat(0)
        }
        let nextY = targetCardStackview.topConstantOfLastCard() + 30
        return nextY - startCardStackview.topConstantOfLastCard()
    }

    func movePoint(from startIndex: Int, to targetIndex: Int) -> CGPoint {
        let x = moveX(from: startIndex, to: targetIndex)
        let y = moveY(from: startIndex, to: targetIndex)
        return CGPoint(x: x, y: y)
    }
    // get view position

    // x좌표를 갖고 현재 위치가 몇번 째 카드 스택에 속하는지 인덱스 반환.
    private func currentIndex(pointX: CGFloat) -> Int {
        let dummyViewFrame = self.frame
        let distributionWidth = dummyViewFrame.width / 7
        return Int(pointX / distributionWidth)
    }
}

extension CardStackDummyView: CardStackMovableView {
    func pop(index: Int, previousCard: Card?) {
        guard let card = previousCard else { return }
        let cardStackview = subviews[index] as? CardStackView
        cardStackview?.popCardStackView(previousCard: card)
    }

    func push(index: Int, cardView: UIView) {
        let cardStackview = subviews[index] as? CardStackView
        cardStackview?.pushCardStackView(cardView: cardView)
    }
}

// MARK: Events
extension CardStackDummyView {
    @objc func cardViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        let tappedLocation = sender.location(in: self)
        let indexTapped = currentIndex(pointX: tappedLocation.x)
        guard let tappedView = sender.view as? UIImageView else { return }
        delegate?.moveToCardDummyView (
            self, tappedView: tappedView,
            startIndex: indexTapped
        )
        delegate?.moveToCardStackDummyView (
            self, tappedView: tappedView,
            startIndex: indexTapped
        )
    }

}

protocol CardStackDummyViewDelegate: NSObjectProtocol {
    func moveToCardDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, startIndex: Int)
    func moveToCardStackDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, startIndex: Int)
}
