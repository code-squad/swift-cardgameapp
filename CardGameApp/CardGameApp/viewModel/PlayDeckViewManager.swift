//
//  PlayDeckViewManager.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 20..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import UIKit

/// 플레이덱뷰 를 가지는 객체
class PlayDeckViewManager {
    var stackViewList : [UIStackView] = []
    
    /// 카드사이즈와 좌표를 받아서 스택뷰 구성
    func makeDeckViews(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]){
        for count in 0..<cardSize.maxCardCount {
            // 스택뷰 구성
            let stackView = PlayDeckView(cardSize: cardSize, x: xPositions[count], y: yPositions[count])
            self.stackViewList.append(stackView)
        }
    }
}
