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
    var embededViews = [CardStackView]()

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
        makeCardStackViews(cardStacks)
        addCardStackViews()
    }

    private func makeCardStackViews(_ cardStacks: [CardStack]) {
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
    }

    private func addCardStackViews() {
        var i = 0
        subviews.forEach {
            $0.addSubview(embededViews[i])
            i += 1
        }
    }

    func removeCardStackDummyView() {
        subviews.forEach {
            guard let cardStackView = $0 as? CardStackView else {
                return
            }
            cardStackView.removeAllCardViews()
        }
    }

    @objc func cardViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        delegate?.cardViewDidDoubleTap(sender)
    }

}

protocol CardStackDummyViewDelegate: class {
    func cardViewDidDoubleTap(_ sender: UITapGestureRecognizer)
}
