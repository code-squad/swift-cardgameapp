//
//  WatingDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 3. 18..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class WatingDeckView : UIView {
    /// 뷰를 받아서 추가하고 추가된 뷰의 위치를 리턴한다. 웨이팅덱뷰는 그냥 0.0
    func addView(cardView: CardView) -> CGPoint {
        self.addSubview(cardView)
        return self.frame.origin
    }
}
