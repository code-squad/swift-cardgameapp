//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 28..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import UIKit

class CardViewModel : CardInfo{
    // 카드정보
    let cardInfo : CardInfo
    // 카드 앞면 이미지
    private let cardFrontImage : UIImage
    // 뒷면 이미지는 공통
    private let cardBackImage = #imageLiteral(resourceName: "card-back")
    // 리턴을 위한 현재 이미지
    private var currentImage : UIImage
    
    /// 생성자
    init(cardInfo: CardInfo){
        self.cardInfo = cardInfo
        // 카드 모양으로 이미지 생성
        let cardImage = UIImage(named: cardInfo.name()) ?? UIImage()
        // 카드에 이미지 입력
        self.cardFrontImage = cardImage
        self.currentImage = cardImage
        // 앞뒷면에 따라 이미지 변경
        let _ = self.refreshImage()
    }
    
    
    /// 카드 앞뒷면 상태 체크
    func isFront() -> Bool {
        return self.cardInfo.name() == self.cardInfo.image()
    }
    
    /// 카드뷰를 뒤집을 경우 뒤집은 후의 이미지로 교체한다
    func flip(){
        self.cardInfo.flip()
        let _ = refreshImage()
    }
    
    /// 카드인포 내부에서 카드가 뒤집힐 경우를 위한 이미지 갱신
    func refreshImage() -> UIImage {
        if isFront() {
            self.currentImage = self.cardFrontImage
        } else {
            self.currentImage = self.cardBackImage
        }
        
        return self.currentImage
    }
    
    /// 카드이름
    func name() -> String {
        return self.cardInfo.name()
    }
    
    /// 카드의 덱라인
    func getDeckLine() -> Int {
        return self.cardInfo.getDeckLine()
    }
    
    /// 카드의 덱타입
    func getDeckType() -> DeckType {
        return self.cardInfo.getDeckType()
    }
    
    /// 카드의 마크 순위
    func getMarkRank() -> Int {
        return self.cardInfo.getMarkRank()
    }
    
    /// 카드의 넘버 순위
    func getNumberingRank() -> Int {
        return self.cardInfo.getNumberingRank()
    }
    
    /// 카드의 이미지 이름
    func image() -> String {
        return self.cardInfo.image()
    }
}

