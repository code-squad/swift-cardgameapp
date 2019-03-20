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
    /// 플레이덱매니저 초기세팅함수
    func setting(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]){
        // 위치, 사이즈 조정
        self.frame.origin.x = 0
        self.frame.origin.y = yPositions[1]
        self.frame.size.width = cardSize.screenWidth
        self.frame.size.height = cardSize.screenHeight - yPositions[1]
        
        // 내부 덱뷰를 생성한다
        makeDeckViews(cardSize: cardSize, xPositions: xPositions, yPositions: yPositions)
    }
    
    /// 카드사이즈와 좌표를 받아서 스택뷰 구성
    private func makeDeckViews(cardSize: CardSize, xPositions: [CGFloat], yPositions: [CGFloat]){
        for count in 0..<cardSize.maxCardCount {
            // 스택뷰 구성
            let playDeckView = PlayDeckView()
            playDeckView.setting(cardSize: cardSize, x: xPositions[count], y: yPositions[0])
            
            // 추가
            self.addSubview(playDeckView)
        }
    }
    
    /// 덱라인을 받아서 해당 플레이덱뷰를 리턴
    private func getPlayDeckViewFrom(deckLine: Int) -> PlayDeckView{
        return subviews[deckLine] as! PlayDeckView
    }
    
    
    /// 덱라인, 뷰를 받아서 추가
    func addView(view: UIView, deckLine: Int) -> CGPoint{
        // 덱 라인에 맞는 스택뷰 추출
        let playDeckView = getPlayDeckViewFrom(deckLine: deckLine) //  else { return nil }
        // 맞는 스택뷰에 추가
        playDeckView.addPlayCardview(view)
        
        // 추가된 위치값 리턴
        return origin(deckLine: deckLine)
    }
    
    /// 과거카드데이터를 받아서 해당 뷰 리턴
    func getView(pastCardData: PastCardData) -> UIView? {
        // 덱 라인에 맞는 스택뷰 추출
        let playDeckView = getPlayDeckViewFrom(deckLine: pastCardData.deckLine) // else { return nil }
        return playDeckView.lastView()
    }
    
    
    /// 덱라인 받아서 위치 리턴
    func origin(deckLine: Int) -> CGPoint {
        // 결과 리턴용 변수
        var point = CGPoint()
        // 서브뷰가 있다면 플레이덱뷰를 뽑아내서
        if let lastView = self.subviews[deckLine] as? PlayDeckView {
            // 결과변수에 추가한다
            point.addPosition(point: lastView.origin())
        }
        // 결과변수에 자신의 오리진도 추가한다
        point.addPosition(point: self.frame.origin)
       
        // 결과리턴
        return point
    }
    
    /// 카드뷰를 받아서 마지막 뷰가 아니면 해당뷰와 이후의 모든 카드뷰의 이미지를 배열로 리턴
    func AllCardImagesAfter(cardView: CardView) -> [CardView]? {
        guard let playDeckView = self.subviews[cardView.cardViewModel.getDeckLine()] as? PlayDeckView else {
            return nil
        }
        return playDeckView.AllCardImagesAfter(cardView: cardView)
    }
    
    /// 마지막 카드가 뒷면이면 뒤집어준다
    func flipLastBackImageCardView(){
        // 모든 플레이덱뷰를 체크한다
        for subView in self.subviews {
            // 서브뷰가 카드뷰인지 체크
            guard let cardView = subView as? PlayDeckView else { continue }
            
            // 마지막카드가 뒷면인지 체크한다
            cardView.flipLastBackImageCardView()
        }
    }
}
