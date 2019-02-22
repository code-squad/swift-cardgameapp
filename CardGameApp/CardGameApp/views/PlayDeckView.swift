//
//  PlayDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 21..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class PlayDeckView: UIStackView {

    init(cardSize: CardSize, x: CGFloat, y: CGFloat){
        super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: cardSize.cardSize))
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 카드를 겹쳐보이게 뷰 추가시 세로위치를 조정해서 추가
    func addPlayCardview(_ view: UIView) {
        // 마지막 카드가 있는지 체크
        if let lastView = self.subviews.last {
            // 마지막 카드가 있다면 추가되는 카드의 위치는 마지막 카드 높이 + 카드길이/4
            let spacing = lastView.frame.origin.y + lastView.frame.height / 4
            view.frame.origin.y += spacing
        }
        // 서브뷰로 추가
        self.addSubview(view)
    }
}

