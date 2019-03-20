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
        deckView = []
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        deckView = []
        super.init(frame: frame)
    }
    
    init(frame: CGRect, _ cardDeck: CardDeck) {
        deckView = []
        super.init(frame: frame)
        drawRefresh()
        drawDeck(cardDeck)
    }
    
    private func drawDeck(_ cardDeck: CardDeck) {
        var deckImage: CardView
        for _ in 0..<cardDeck.count() {
            deckImage = CardView(frame: CGRect(x: Sizes.originX, y: Sizes.originY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
            deckImage.setBackImage()
            deckView.append(deckImage)
            addSubview(deckImage)
        }
    }
    
    private func drawRefresh() {
        let refreshImage = UIImageView(frame: CGRect(x: Sizes.originX, y: Sizes.originY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
        refreshImage.image = UIImage(named: "cardgameapp-refresh-app")
        addSubview(refreshImage)
    }
}

extension CardDeckView {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard deckView.count != 0 else { return }
        NotificationCenter.default.post(name: .touchedDeck, object: nil)
        super.touchesEnded(touches, with: event)
    }
    
    func removeView() -> CardView {
        let removeView = deckView.remove(at: deckView.count-1)
        removeView.removeFromSuperview()
        return removeView
    }
    
    func accessTopView(form: (CardView) -> Void) {
        form(deckView[deckView.count-1])
    }
}
