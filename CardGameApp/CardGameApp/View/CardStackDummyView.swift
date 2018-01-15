//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

final class CardStackDummyView: UIStackView {

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
        let cardStackViews = makeCardStackViews(cardStacks)
        addCardStackViews(cardStackViews)
    }

    private func makeCardStackViews(_ cardStacks: [CardStack]) -> [CardStackView] {
        var embededViews = [CardStackView]()
        cardStacks.forEach {
            let lastIndex = $0.count - 1
            guard let width = subviews.first?.frame.width else { return }
            let frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            let cardStackView = CardStackView(frame: frame)
            let action = Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:)))
            cardStackView.setCardStackImageView($0)
            cardStackView.addDoubleTapGestureAllSubViews(action: action)
            cardStackView.validUserInterationOnly(on: lastIndex)
            embededViews.append(cardStackView)
        }
        return embededViews
    }

    private func addCardStackViews(_ cardStackViews: [CardStackView]) {
        var i = 0
        subviews.forEach {
            $0.addSubview(cardStackViews[i])
            i += 1
        }
    }

    func removeCardStackDummyView() {
        subviews.forEach {
            let subview = $0.subviews.first
            subview?.removeFromSuperview()
        }
    }

    func moveX(from startIndex: Int, to endIndex: Int) -> CGFloat {
        let startX = subviews[startIndex].frame.origin.x
        let endX = subviews[endIndex].frame.origin.x
        return endX - startX
    }

    func moveY(from startIndex: Int, to endIndex: Int) -> CGFloat {
        let startSubview = subviews[startIndex].subviews.first
        let endSubview = subviews[endIndex].subviews.first
        guard let startCardStackview = startSubview as? CardStackView,
            let endCardStackview = endSubview as? CardStackView else {
            return CGFloat(0)
        }
        let willMove = endCardStackview.topConstantOfLastCard() + 30
        return willMove - startCardStackview.topConstantOfLastCard()
    }

    func distance(from startIndex: Int, to endIndex: Int) -> CGPoint {
        let x = moveX(from: startIndex, to: endIndex)
        let y = moveY(from: startIndex, to: endIndex)
        return CGPoint(x: x, y: y)
    }

    func pop(index: Int, previousCard: Card?) {
        guard let card = previousCard else { return }
        let subview = subviews[index].subviews.first
        let cardStackview = subview as? CardStackView
        cardStackview?.popCardStackView(previousCard: card)
        self.layoutSubviews()
    }

    func push(index: Int, cardView: UIView) {
        let subview = subviews[index].subviews.first
        let cardStackview = subview as? CardStackView
        cardStackview?.pushCardStackView(cardView: cardView)
        self.layoutSubviews()
    }

    // get view position

    // x좌표를 갖고 현재 위치가 몇번 째 카드 스택에 속하는지 인덱스 반환.
    private func selectCurrentIndexOfCardStack(pointX: CGFloat) -> Int {
        let dummyViewFrame = self.frame
        let distributionWidth = dummyViewFrame.width / 7
        return Int(pointX / distributionWidth)
    }
}

// MARK: Events
extension CardStackDummyView {
    @objc func cardViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        let tappedLocation = sender.location(in: self)
        let indexTapped = selectCurrentIndexOfCardStack(pointX: tappedLocation.x)
        guard let tappedView = sender.view as? UIImageView else { return }
        delegate?.moveToCardDummyView (
            self, tappedView: tappedView,
            cardStackIdx: indexTapped
        )
        delegate?.moveToCardStackDummyView (
            self, tappedView: tappedView,
            cardStackIdx: indexTapped
        )
    }

}

protocol CardStackDummyViewDelegate: NSObjectProtocol {
    func moveToCardDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, cardStackIdx: Int)
    func moveToCardStackDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, cardStackIdx: Int)
}
