//
//  CardSize.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 7..
//  Copyright © 2019년 Drake. All rights reserved.
//
import UIKit
import Foundation

class CardSize {
    /// 최대 카드 장수
    var maxCardCount : Int = 1
    /// 입력받은 가로값
    var originWidth : CGFloat = 0
    /// 입력받은 가로 * 1.25
    var originHeight : CGFloat = 0
    /// 카드 가로값. origin * 0.9
    var width : CGFloat = 0
    /// 카드 세로값
    var height : CGFloat = 0
    /// originWidth * 0.1
    var widthPadding : CGFloat = 0
    /// originHeight * 0.1
    var heightPadding : CGFloat = 0
    /// screen width
    var screenWidth : CGFloat = 0
    var screenHeight : CGFloat = 0
    
    var viewSize : CGSize = CGSize()
    var cardSize : CGSize = CGSize()
    
    init(maxCardCount: Int ){
        // 최대 장수
        self.maxCardCount = maxCardCount
    }
    
    /// 화면 가로사이즈를 받아서 필요한 사이즈들을 계산
    func calculateCardSize(screenWidth: CGFloat){
        // 입력값 원본
        self.screenWidth = screenWidth
        self.screenHeight = self.screenWidth * 1.25
        
        // 입력값 / 카드장수
        self.originWidth = screenWidth / CGFloat(self.maxCardCount)
        self.originHeight = self.originWidth * 1.25
        
        // 패딩 좌우 0.1 * 2 를 제외한 0.8
        self.width = self.originWidth * 0.8
        // 가로세로 비율 1.25
        self.height = self.width  * 1.25
        
        // 한쪽 패딩 사이즈 * 0.1
        self.widthPadding = self.originWidth * 0.1
        self.heightPadding = self.originHeight * 0.1
        
        viewSize.width = originWidth
        viewSize.height = originHeight
        
        
    }
}
