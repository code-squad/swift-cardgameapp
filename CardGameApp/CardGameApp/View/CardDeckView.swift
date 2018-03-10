//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 11..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class CardDeckView: UIImageView {
    let backImage = UIImage(named: Figure.Image.back.value)
    let refreshImage = UIImage(named: Figure.Image.refresh.value)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCardDeck()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCardDeck()
    }

    private func configureCardDeck() {
        contentMode = .scaleAspectFit
        image = UIImage(named: Figure.Image.back.value)
        addTapEvent()

    }

    private func addTapEvent() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapCardDeck(recognizer:)))
        tap.numberOfTapsRequired = Figure.TapGesture.once.rawValue
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    @objc private func tapCardDeck(recognizer: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .tappedCardDeck,
                                        object: self,
                                        userInfo: [Keyword.tappedCardDeck.value: recognizer.view!])
    }

}
