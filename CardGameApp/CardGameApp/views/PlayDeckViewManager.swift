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
    /// 매니저 선언
    var playDeckViewManagerModel = PlayDeckViewManagerModel()
    
    /// 플레이덱매니저 초기세팅함수
    func setting(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]){
        // 위치, 사이즈 조정
        self.frame.origin.x = 0
        self.frame.origin.y = yPositions[1]
        self.frame.size.width = cardSize.screenWidth
        self.frame.size.height = cardSize.screenHeight - yPositions[1]
        // 내부 덱뷰를 생성한다
        let deckList = playDeckViewManagerModel.setting(cardSize: cardSize, xPositions: xPositions, yPositions: yPositions)
        // 생성된 덱뷰를 서브뷰로 추가한다
        addPlayDeckViews(playDeckViews: deckList)
    }
    
    /// 플레이덱뷰 배열을 받아서 서브뷰로 추가
    private func addPlayDeckViews(playDeckViews: [PlayDeckView]){
        for playDeckView in playDeckViews {
            self.addSubview(playDeckView)
        }
    }
    
    /// 덱라인, 뷰를 받아서 추가
    func addView(view: UIView, deckLine: Int){
        self.playDeckViewManagerModel.addView(view: view, deckLine: deckLine)
    }
    
    /// 과거카드데이터를 받아서 해당 뷰 리턴
    func getView(pastCardData: PastCardData) -> UIView? {
        return self.playDeckViewManagerModel.getView(pastCardData: pastCardData)
    }
}
