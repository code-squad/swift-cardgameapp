//
//  EmptyPointCardView EmptyPointCardView EmptyPointCardView EmptyPointCardView EmptyPointCardView EmptyPointCardView EmptyPointCardViewEmptyPointCardView EmptyPointCardView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 22..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class EmptyCardView: UIView {
    
    init(origin: CGPoint, size: CGSize){
        let frame = CGRect(origin: origin, size: size)
        super.init(frame: frame)
        makeBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeBorder()
    }
}

// 테두리 기능 확장
extension EmptyCardView {
    /// 뷰 테두리 생성
    private func makeBorder(){
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
    }
}
