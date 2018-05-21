//
//  FrameCalculator.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 17..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import UIKit

class FrameCalculator {

    let rootViewFrame = CGRect(x: 0,
                               y: 0,
                               width: ViewController.widthOfRootView,
                               height: ViewController.heightOfRootView)


    // origin.y를 검사하여 oneStack내에서의 cardIndex를 알아낸다.
    func cardIndexInStack(originY: CGFloat) -> Int {
        return Int(originY / 15.0)
    }

    func originalLocation(view: UIView, position: CGPoint) -> MoveInfo {
        if let from = view as? OneStack {
            return MoveInfo(view: from, column: from.getColumn(), index: cardIndexInStack(originY: position.y))
        } else if let from = view as? CardDeckView {
            return MoveInfo(view: from, column: nil, index: nil)
        } else {
            return MoveInfo(view: view as! Movable, column: nil, index: nil)
        }
    }

    func availableFrame(of info: MoveInfo) -> CGPoint {
        switch info.view.convertViewKey() {
        case .foundation:
            return CGPoint(x: PositionX.allValues[info.getColumn()!].value,
                           y: PositionY.upper.value)
        case .stack:
            guard let column = info.column else {break}
            guard let index = info.index else {break}
            return CGPoint(x: PositionX.allValues[column].value,
                           y: PositionY.bottom.value + CGFloat(15 * index))
        default: return CGPoint(x: 0.0, y: 0.0)
        }
        return CGPoint(x: 0.0, y: 0.0)
    }

    // 서브뷰 기준에서의 current origin(드래그가 끝난 지점)을 root view기준의 origin으로 변환
    func convertToRootView(from: MoveInfo, origin points: CGPoint) -> CGPoint {
        let fromView = from.getView().convertViewKey()
        let positionX = PositionX.allValues.map{ $0.value }

        switch fromView {
        case .deck:
            return CGPoint(x: points.x + PositionX.sixth.value,
                           y: points.y + PositionY.upper.value)
        case .stack:
            guard let column = from.getColumn() else { break }
            return CGPoint(x: points.x + positionX[column],
                           y: points.y + PositionY.bottom.value)
        default:
            break
        }
        return CGPoint(x:0.0, y:0.0)
    }

    // 현재 currentFrame을 파라미터로 받고 위치한 뷰에 맞는 정보 생성 (카드 도착지점)
    func toInfo(at point: CGPoint) -> (view: ViewKey, column: Int?, index: Int?)?{

        if PositionY.upper.value..<PositionY.bottom.value ~= point.y { // foundationView
            for i in 0..<PositionX.allValues.count where 0...3 ~= i {
                if PositionX.allValues[i].value...(PositionX.allValues[i].value + ViewController.cardSize.width) ~= point.x {
                    return (view: ViewKey.foundation, column: i, index: nil)
                }
            }
        } else if point.y >= PositionY.bottom.value { // stackView
            for i in 1..<PositionX.allValues.count {
                if PositionX.allValues[i-1].value...(PositionX.allValues[i-1].value + ViewController.cardSize.width) ~= point.x {
                    return (view: ViewKey.stack, column: i-1, index: nil)
                }
            }
        }
        return nil
    }

}

class MoveInfo {
    fileprivate var view: Movable
    fileprivate var column: Int?
    fileprivate var index: Int?

    init(view: Movable, column: Int?, index: Int?) {
        self.view = view
        self.column = column
        self.index = index
    }

    func getView() -> Movable {
        return self.view
    }

    func getColumn() -> Int? {
        guard self.column != nil else { return nil }
        return self.column!
    }

    func getIndex() -> Int? {
        guard self.index != nil else { return nil }
        return self.index!
    }

}
