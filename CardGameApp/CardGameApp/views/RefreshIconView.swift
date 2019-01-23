//
//  RefreshIconView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 23..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
/// 드로우뷰 맨 밑의 리프레시 뷰
class RefreshIconView: UIImageView {

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

}

