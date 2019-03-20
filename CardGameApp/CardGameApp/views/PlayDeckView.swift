//
//  PlayDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 21..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class PlayDeckView: UIStackView {
    /// 카드를 겹쳐보이게 뷰 추가시 세로위치를 조정해서 추가
    func addPlayCardview(_ view: UIView) {
        // 마지막 카드가 있는지 체크. 마지막 카드가 없으면 바로추가
        if let lastView = self.subviews.last as? CardView {
            // 마지막 카드가 있다면 추가되는 카드의 위치는 마지막 카드 높이 + 카드길이/4
            let spacing = lastView.frame.origin.y + lastView.frame.height / 4
            view.frame.origin.y += spacing
            
            // 플레이덱은 뷰 추가시 마지막 뷰 이미지를 갱신한다
            lastView.refreshImage()
        }
        
        // 서브뷰로 추가
        self.addSubview(view)
    }
    
    /// 뷰 리턴. 마지막 카드가 나가면 그전 카드는 뒤집는다
    func lastView() -> UIView? {
        // 카드가 2장 이상이면 뒤집어준다
//        if self.subviews.count > 1 {
//            let aheadOfLastView = self.subviews[self.subviews.count - 2] as! CardView
//
//            // 마전카드가 뒷면이면 뒤집어준다
//            if aheadOfLastView.isFront() == false {
//                aheadOfLastView.flip()
//                aheadOfLastView.refreshImage()
//            }
//        }
        
        // 마지막뷰 리턴 
        return self.subviews.last
    }
    
    /// 마지막 카드가 뒷면이면 뒤집어준다
    func flipLastBackImageCardView(){
        // 마지막 서브뷰가 카드뷰인지 체크
        guard let lastCardView = self.subviews.last as? CardView else { return () }
        
        // 마지맛 카드뷰가 뒷면이면 뒤집어준다
        if lastCardView.isFront() == false {
            lastCardView.flip()
        }
        
    }
    
    /// 생성 후 세팅
    func setting(cardSize: CardSize, x: CGFloat, y: CGFloat){
        self.frame.origin.x = x
        self.frame.origin.y = y
        self.frame.size = CGSize(width: cardSize.width, height: cardSize.height * 5)
    }
    
    /// origin + 마지막 카드 위치 리턴
    func origin() -> CGPoint {
        // 결과 리턴용 변수
        var point = CGPoint()
        // 서브뷰가 있다면 마지막 뷰를 뽑아내서
        if let lastView = self.subviews.last {
            // 결과변수에 추가한다
            point.addPosition(point: lastView.frame.origin)
        }
        // 결과변수에 자신의 오리진도 추가한다
        point.addPosition(point: self.frame.origin)
        return point
    }
    
    /// 카드뷰를 받아서 마지막 뷰가 아니면 해당뷰와 이후의 모든 카드뷰의 이미지를 배열로 리턴
    func AllCardImagesAfter(cardView: CardView) -> [CardView]? {
        // 배열에 있는지 체크. 없으면 바로 리턴
        guard let cardViewIndex = self.subviews.index(of: cardView) else { return nil }
        
        // 해당카드가 마지막 카드인지 체크
        guard cardViewIndex != (self.subviews.count - 1) else { return nil }
        
        // 해당카드와 이후의 모든 카드의 이미지를 배열로 만들어서 리턴
        var cards : [CardView] = []
        
        for count in cardViewIndex..<self.subviews.count {
            if let selectedCardVIew = self.subviews[count] as? CardView {
                cards.append(selectedCardVIew)
            }
        }
        
        // return
        return cards
    }
}

