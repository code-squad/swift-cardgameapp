//
//  DragInfo.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 4. 17..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

struct DragInfo {
    var topCardInDraggableViews : UIImageView!
    var topCardInfo : CardInfo!
    var cardImgPack : [UIImageView] = []
    var origins : [CGPoint] = []
    
    init(_ view : UIImageView, originCardInfo : CardInfo) {
        topCardInDraggableViews = view
        topCardInfo = originCardInfo
    }
    
    mutating func setBelowViews(_ views : [UIImageView]) {
        cardImgPack = views
        cardImgPack.forEach({origins.append($0.center)})
    }
    
    func dragChanged(_ gesture : UIPanGestureRecognizer) {
        cardImgPack.forEach({
            $0.layer.zPosition = 1
            let transition = gesture.translation(in: topCardInDraggableViews)
            $0.center = CGPoint(x: $0.center.x + transition.x, y: $0.center.y + transition.y)
        })
        gesture.setTranslation(CGPoint.zero, in: topCardInDraggableViews)
    }
    
    func moveBelowViews(_ topCardinfos : [CGRect]) {
        var index = 0
        cardImgPack.forEach({
            $0.frame = topCardinfos[index]
            index += 1
        })
    }
    
    func moveCardBackAgain() {
        var index = 0
        cardImgPack.forEach {
            $0.center.x = self.origins[index].x
            $0.center.y = self.origins[index].y
            index += 1
        }
    }
}
