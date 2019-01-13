//
//  CardView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 13..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

/// 카드 표현을 담당하는 이미지뷰
class CardView : UIImageView {
    /// 카드정보를 가진다
    var cardInfo : CardInfo
    
    init(cardInfo: CardInfo, frame: CGRect){
        self.cardInfo = cardInfo
        super.init(frame: frame)
        self.image = UIImage(named: cardInfo.image())
    }
    
    /// 저장기능은 아직 없음
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 카드뷰를 뒤집을 경우 뒤집은 후의 이미지로 교체한다
    func flip(){
        // 카드정보에서 뒤집기
        cardInfo.flip()
        // 이미지를 추출
        guard let flipedCardImage = UIImage(named: cardInfo.image()) else {
            os_log("카드뷰 뒤집기 실패 : %@",cardInfo.name())
            return ()
            
        }
        // 추출된 이미지로 교체
        self.image = flipedCardImage
    }
    
    /// 카드인포 내부에서 카드가 뒤집힐 경우를 위한 이미지 갱신
    func refreshImage(){
        // 이미지 추출
        let changedImage = UIImage(named: cardInfo.image())
        // 이미지 갱신
        self.image = changedImage
    }
}
