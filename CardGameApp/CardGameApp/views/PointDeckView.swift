//
//  PointDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 19..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

class PointDeckView: UIStackView {

    // 기본 생성자
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 위치설정. 카드사이즈를 통째로 불러와서 설정한다
    func setPointDeckView(origin: CGPoint, cardSize: CardSize){
        // 뷰 오리진 수정
        self.frame.origin = origin
        
        // 뷰 사이즈 수정
        // 세로는 다른 뷰들과 같다
        self.frame.size.height = cardSize.height
        // 가로는 카드 4장 길이 필요
        self.frame.size.width = cardSize.originWidth * 4 - cardSize.widthPadding * 2
        
        self.axis = .horizontal
        
        self.spacing = cardSize.widthPadding * 2
        
        self.distribution = .fillEqually
        
        setSubView(cardSize: cardSize)
    }
    
    /// 빈 카드뷰 추가
    private func setSubView(cardSize: CardSize){
        for _ in Mark.allCases() {
            // 카드 기준점 설정
            let viewPoint = CGPoint(x: 0, y: 0)
            // 기준점에서 카드사이즈로 이미지뷰 생성
            let emptyCardView = EmptyPointCardView(origin: viewPoint, size: cardSize.cardSize)
            
            self.addArrangedSubview(emptyCardView)
        }
    }
    
    /// 카드뷰를 받아서 알맞은 위치에 추가한다
    func addPointCardView(view: UIView){
        // 카드뷰 변환 가능한지 체크
        guard let cardView = view as? CardView else {
            os_log("포인트뷰덱에 추가 실패")
            return ()
        }
        // 라인에 따라 추가위치 변경
        let superView = self.subviews[cardView.cardInfo.getDeckLine()]
        superView.addSubview(cardView)
    }
    
    /// 과거카드데이터 를 받아서 해당 뷰 리턴
    func getCardView(pastCardData: PastCardData) -> UIView? {
        // 덱라인의 마지막 카드를 뽑아서 리턴
        return self.subviews[pastCardData.deckLine].subviews.last 
}

