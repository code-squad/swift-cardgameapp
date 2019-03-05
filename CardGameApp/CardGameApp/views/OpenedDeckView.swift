//
//  OpenedDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 18..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class OpenedDeckView: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: 0, height: 0)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /// 카드를 받아서 추가하고, 추가된 위치를 리턴한다
    func addView(cardView: UIView) -> CGPoint {
        // 카드를 서브뷰에 추가하고
        self.addSubview(cardView)
        // 추가된 카드의 위치 = 자신의 위치를 리턴한다
        return self.frame.origin
    }
}
