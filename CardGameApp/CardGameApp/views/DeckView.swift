//
//  RefreshIconView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 23..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
/// 드로우뷰 맨 밑의 리프레시 뷰
class DeckView: UIImageView {
    init(){
        super.init(image: #imageLiteral(resourceName: "cardgameapp-refresh-app"))
        // 뷰 인터랙션 허용
        self.isUserInteractionEnabled = true
    }
    init(origin: CGPoint, size: CGSize){
        let frame = CGRect(origin: origin, size: size)
        super.init(frame: frame)
        // 생성시 이미지 설정
        self.image = #imageLiteral(resourceName: "cardgameapp-refresh-app")
        // 뷰 인터랙션 허용
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // 생성시 이미지 설정
        self.image = #imageLiteral(resourceName: "cardgameapp-refresh-app")
        // 뷰 인터랙션 허용
        self.isUserInteractionEnabled = true
    }
    
    /// 카드를 받아서 추가하고, 추가된 위치를 리턴한다
    func addView(cardView: UIView) -> CGPoint {
        // 카드를 서브뷰에 추가하고
        self.addSubview(cardView)
        // 추가된 카드의 위치 = 자신의 위치를 리턴한다
        return self.frame.origin
    }
    
}

extension UIView {
    /// 위치 변경
    func setPosotion(origin: CGPoint, size: CGSize){
        self.frame.origin = origin
        self.frame.size = size
    }
}
