//
//  CardStackView.swift
//  CardGameApp
//
//  Created by 윤동민 on 20/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class CardStackView: UIView {
    var cardViews: [CardView]
    
    required init?(coder aDecoder: NSCoder) {
        cardViews = []
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        cardViews = []
        super.init(frame: frame)
    }
    
    init(frame: CGRect, _ cardStack: CardStack) {
        cardViews = []
        super.init(frame: frame)
        drawStack(cardStack)
    }
    
    private func drawStack(_ cardStack: CardStack) {
        var positionY = 0

        cardStack.accessCard { stack in
            var cardImage: CardView
            
            for index in 0..<stack.count {
                cardImage = CardView(frame: CGRect(x: Sizes.originX, y: positionY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
                if index == stack.count-1 { cardImage.setCardImage(name: stack[index].description) }
                else { cardImage.setBackImage() }
                cardViews.append(cardImage)
                addSubview(cardImage)
                positionY += 20
            }
        }
    }
    
    // View들을 관리하는 배열에 넣고 화면에 추가
    func addCardView(cardView: CardView) {
        if cardViews.isEmpty {
            cardView.frame.origin = CGPoint(x: CGFloat(Sizes.originX), y: CGFloat(Sizes.originY))
        } else {
            let prosuccesorY = cardViews[cardViews.count-1].frame.minY
            cardView.frame.origin = CGPoint(x: CGFloat(Sizes.originX), y: prosuccesorY + 20)
        }
        cardViews.append(cardView)
        addSubview(cardView)
    }
    
    // View들을 관리하는 배열에서 뺴주고 화면에서 제거
    func removeFromStack() -> CardView? {
        guard cardViews.count != 0 else { return nil }
        let removeView: CardView = cardViews.remove(at: cardViews.count-1)
        removeView.removeFromSuperview()
        removeView.frame.origin = CGPoint(x: Sizes.originX, y: Sizes.originY)
        return removeView
    }
    
    // Stack의 마지막 카드를 앞면으로 뒤집는다.
    func turnLastCard(_ model: CardStack) {
        model.accessCard { cards in
            cardViews[cardViews.count-1].setCardImage(name: cards[cards.count-1].description)
        }
    }
    
    func accessTopView(_ form: (CardView) -> Void) {
        form(cardViews[cardViews.count-1])
    }
}
