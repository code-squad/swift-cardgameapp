//
//  Extension.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 3. 5..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit


extension CGPoint {
    /// 다른 포인트를 받아서 x,y 좌표를 각각 더한 값을 리턴한다
    func getPlusedPoint(point: CGPoint) -> CGPoint{
        let xPoint = self.x + point.x
        let yPoint = self.y + point.y
        return CGPoint(x: xPoint, y: yPoint)
    }
    
    /// 다른 포인트를 받아서 x,y 만큼 추가한다
    mutating func addPosition(point: CGPoint){
        self.x += point.x
        self.y += point.y
    }
}
