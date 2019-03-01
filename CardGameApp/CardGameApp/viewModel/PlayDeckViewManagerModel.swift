//
//  PlayDeckViewManagerModel.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 3. 1..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import UIKit

class PlayDeckViewManagerModel {
    
    var deckList : [PlayDeckView] = []
    
    /// 카드사이즈와 좌표를 받아서 스택뷰 구성
    private func makeDeckViews(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]) -> [PlayDeckView]{
        for count in 0..<cardSize.maxCardCount {
            // 스택뷰 구성
            let stackView = PlayDeckView()
            stackView.setting(cardSize: cardSize, x: xPositions[count], y: yPositions[0])
            
            // 일반추가함
            deckList.append(stackView)
        }
        return deckList
    }
    
    /// 플레이덱매니저 초기세팅함수
    func setting(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]) -> [PlayDeckView]{
        // 내부 덱뷰를 생성한다
        return makeDeckViews(cardSize: cardSize, xPositions: xPositions, yPositions: yPositions)
    }
    
    /// 덱라인, 뷰를 받아서 추가
    func addView(view: UIView, deckLine: Int){
        // 덱 라인에 맞는 스택뷰 추출
        let stackView = self.deckList[deckLine]
        // 맞는 스택뷰에 추가
        stackView.addPlayCardview(view)
    }
    
    /// 과거카드데이터를 받아서 해당 뷰 리턴
    func getView(pastCardData: PastCardData) -> UIView? {
        return self.deckList[pastCardData.deckLine].lastView()
        
    }
}
