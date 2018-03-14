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
    private(set) var storedImage: String = ""

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

    static func makeEmptyCardView(frame: CGRect) -> CardView {
        let emptyCard = CardView(frame: frame)
        emptyCard.setEmptyCardFigure()
        return emptyCard
    }

    static func makeNewCardView(frame: CGRect, imageName: String) -> CardView {
        let newCard = CardView(frame: frame)
        newCard.setImage(name: imageName)
        newCard.addDoubleTapEvent()
        newCard.addDragEvent()
        return newCard
    }

    private func setImage(name: String) {
        image = UIImage(named: name)
        if name != Figure.Image.back.value {
            storedImage = name
            isUserInteractionEnabled = true
        }
        contentMode = .scaleToFill
    }

    private func addDoubleTapEvent() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapCard(recognizer:)))
        doubleTap.numberOfTapsRequired = Figure.TapGesture.double.rawValue
        addGestureRecognizer(doubleTap)
    }

    @objc private func doubleTapCard(recognizer: UITapGestureRecognizer) {
        NotificationCenter.default.post(
            name: .doubleTapped,
            object: self,
            userInfo: [Keyword.doubleTapped.value: recognizer]
        )
    }

    private func addDragEvent() {
        let drag = UIPanGestureRecognizer(target: self, action: #selector(dragCard(recognizer:)))
        drag.minimumNumberOfTouches = 1
        drag.maximumNumberOfTouches = 1
        addGestureRecognizer(drag)
    }

    @objc private func dragCard(recognizer: UIPanGestureRecognizer) {
        NotificationCenter.default.post(
            name: .drag,
            object: self,
            userInfo: [Keyword.drag.value: recognizer]
        )
    }

}
