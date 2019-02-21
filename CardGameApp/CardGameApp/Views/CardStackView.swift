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
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        cardViews = []
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, _ cardStack: CardStack) {
        self.init(frame: frame)
        drawStack(cardStack)
    }
    
    func drawStack(_ cardStack: CardStack) {
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
        cardViews.append(cardView)
        addSubview(cardView)
    }
    
    // View들을 관리하는 배열에서 뺴주고 화면에서 제거
    func removeFromStack() -> CardView {
        let removeView: CardView = cardViews.remove(at: cardViews.count-1)
        removeView.removeFromSuperview()
        return removeView
    }
}
