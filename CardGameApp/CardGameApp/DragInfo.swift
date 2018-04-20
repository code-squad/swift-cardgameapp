//
//  DragInfo.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 4. 17..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

struct DragInfo {
    private(set) var topCardInDraggableViews : UIImageView!
    private(set) var topCardInfo : CardInfo!
    private(set) var imgFrameMaker : FrameControl
    private var cardImgPack : [UIImageView] = []
    private var origins : [CGPoint] = []
    
    
    init(_ view : UIImageView, originCardInfo : CardInfo, _ frameControl : FrameControl) {
        topCardInDraggableViews = view
        topCardInfo = originCardInfo
        imgFrameMaker = frameControl
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
    
    func moveCardImgPack(_ topCardinfo : CardInfo) {
        var count = 0
        let baseStackIndex = topCardinfo.stackIndex
        cardImgPack.forEach({
            $0.layer.zPosition = 1
            let oneCardOfPackInfo = CardInfo(topCardinfo.indexOfCard, baseStackIndex + count, topCardinfo.position)
            $0.frame = self.imgFrameMaker.generateCardViewFrame(oneCardOfPackInfo)
            count += 1
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
