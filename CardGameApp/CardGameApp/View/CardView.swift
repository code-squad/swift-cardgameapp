//
//  CardView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 2..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

typealias CardPoint = CGPoint

class CardView: UIImageView {

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setCardFigure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCardFigure()
    }

    private func setCardFigure() {
        layer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
        layer.borderColor = UIColor.white.cgColor
    }

    private func setEmptyCardFigure() {
        layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
    }

    private func setRefreshCardFigure() {
        layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
        image = UIImage(named: Figure.Image.refresh.value)
    }

    static func makeEmptyCardView(frame: CGRect) -> CardView {
        let emptyCard = CardView(frame: frame)
        emptyCard.setEmptyCardFigure()
        return emptyCard
    }

    static func makeNewCardView(frame: CGRect, imageName: String) -> CardView {
        let newCard = CardView(frame: frame)
        newCard.setImage(name: imageName)
        newCard.addDoubleTapEvent()
        return newCard
    }

    static func makeRefreshCardView(frame: CGRect) -> CardView {
        let emptyCard = CardView(frame: frame)
        emptyCard.setRefreshCardFigure()
        return emptyCard
    }

    private func setImage(name: String) {
        image = UIImage(named: name)
        if name != Figure.Image.back.value {
            isUserInteractionEnabled = true
        }
        contentMode = .scaleAspectFit
    }

    private func addDoubleTapEvent() {
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapCard(recognizer:)))
        doubleTap.numberOfTapsRequired = Figure.TapGesture.double.rawValue
        addGestureRecognizer(doubleTap)
    }

    @objc private func doubleTapCard(recognizer: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .doubleTapped,
                                        object: self,
                                        userInfo: [Keyword.doubleTapped.value: recognizer.view!])
    }

    func move(amount: CardPoint) {
        frame.origin.x += amount.x
        frame.origin.y += amount.y
    }

}
