//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by 윤동민 on 21/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let touchedDeck = NSNotification.Name(rawValue: "touchedDeck")
}

class CardDeckView: UIView {
    var deckView: [CardView]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        deckView = []
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, _ cardDeck: CardDeck) {
        self.init(frame: frame)
        drawDeck(cardDeck)
    }
    
    func drawDeck(_ cardDeck: CardDeck) {
        var deckImage: CardView
        for _ in 0..<cardDeck.count() {
            deckImage = CardView(frame: CGRect(x: Sizes.originX, y: Sizes.originY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
            deckImage.setBackImage()
            deckView.append(deckImage)
            addSubview(deckImage)
        }
    }
}

extension CardDeckView {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        deckView.remove(at: deckView.count-1).removeFromSuperview()
        NotificationCenter.default.post(name: .touchedDeck, object: nil)
    }
}
