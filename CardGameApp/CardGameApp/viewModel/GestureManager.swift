////
////  GestureManager.swift
////  CardGameApp
////
////  Created by Yoda Codd on 2019. 2. 19..
////  Copyright © 2019년 Drake. All rights reserved.
////
//
//import Foundation
//import UIKit
//import os
//
//
//class GestureManager {
//    
//    /// 덱을 위한 탭 제스처
//    func makeTapGetstureForDeck() -> UITapGestureRecognizer {
//        // 탭 제스처 선언
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.deckTapEvent(_:)))
//        // 작동에 필요한 탭 횟수
//        gesture.numberOfTapsRequired = 1
//        // 작동에 필요한 터치 횟수
//        gesture.numberOfTouchesRequired = 1
//        // 제스처를 리턴한다
//        return gesture
//    }
//    
//    /// 덱 탭 제스처시 발생하는 이벤트
//    @objc func deckTapEvent(_ sender: UITapGestureRecognizer) {
//        // 옮겨진 뷰가 카드뷰가 맞는지 체크
//        guard let openedCardView = sender.view as? CardView else {
//            os_log("터치된 객체가 카드뷰가 아닙니다.")
//            return ()
//        }
//        
//        // 꺼낸 카드가 덱뷰의 마지막 카드가 맞는지 체크
//        guard openedCardView == self.deckView.subviews.last else {
//            os_log("덱뷰의 마지막 카드가 아닙니다")
//            return ()
//        }
//        
//        let _ = openDeck(cardInfo: openedCardView.cardInfo)
//    }
//    
//    /// 리프레시 아이콘 용 제스처 생성
//    func makeRefreshGesture() -> UITapGestureRecognizer {
//        // 탭 제스처 선언
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.refreshDeck(_:)))
//        // 작동에 필요한 탭 횟수
//        gesture.numberOfTapsRequired = 1
//        // 작동에 필요한 터치 횟수
//        gesture.numberOfTouchesRequired = 1
//        // 제스처를 리턴한다
//        return gesture
//    }
//}

