//
//  PlayDeckViewManager.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 21..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

/// 플레이덱뷰 를 가지는 객체
class PlayDeckViewManager : UIView{
    
    /// 카드사이즈와 좌표를 받아서 스택뷰 구성
    private func makeDeckViews(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]){
        for count in 0..<cardSize.maxCardCount {
            // 스택뷰 구성
            let stackView = PlayDeckView(cardSize: cardSize, x: xPositions[count], y: yPositions[0])
            self.addSubview(stackView)
        }
    }
    
    /// 플레이덱매니저 초기세팅함수
    func setting(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]){
        self.frame.origin.x = 0
        self.frame.origin.y = yPositions[1]
        self.frame.size.width = cardSize.screenWidth
        self.frame.size.height = cardSize.screenHeight - yPositions[1]
        
        makeDeckViews(cardSize: cardSize, xPositions: xPositions, yPositions: yPositions)
    }
    
    /// 뷰를 받아서 추가
    func addView(view: UIView, deckLine: Int){
        self.subviews[deckLine].addSubview(view)
    }
    
    /// 과거카드데이터를 받아서 해당 뷰 리턴
    func getView(pastCardData: PastCardData) -> UIView? {
        return self.subviews[pastCardData.deckLine].subviews.last
    }
}
