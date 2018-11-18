//
//  FoundationContainerView.swift
//  CardGameApp
//
//  Created by oingbong on 15/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class FoundationContainerView: UIView, CardContainerView {
    var dataSource: MultipleDataSource?
    // 카드몰드는 배열에도 속하지 않고 그냥 모양을 나타내기 위해 addSubView만 합니다.
    private var container = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        var xValue = Unit.space
        for _ in 0..<Unit.foundationCount {
            let mold = cardMold(xValue: xValue, yValue: 0)
            // 모델에서 추가할 때는 인덱스를 보고 추가하기 위해 배열에 넣어 사용합니다.
            self.addSubview(mold)
            let rect = CGRect(x: xValue, y: 0, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio)
            let container = UIView(frame: rect)
            self.addSubview(container)
            self.container.append(container)
            let newXValue = xValue + mold.frame.width + Unit.space
            xValue = newXValue
        }
    }
    
    private func cardMold(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio)
        let mold = UIView(frame: rect)
        mold.layer.borderWidth = Unit.foundationBorderWidth
        mold.layer.borderColor = Unit.foundationBorderColor
        return mold
    }
    
    func draw() {
        removeAllSubView()
        addAllSubView()
    }
    
    private func removeAllSubView() {
        for containerView in self.container {
            for subView in containerView.subviews {
                subView.removeFromSuperview()
            }
        }
    }
    
    private func addAllSubView() {
        guard let cardStackList = dataSource?.cardStackList() else { return }
        for largeIndex in 0..<cardStackList.count {
            for index in 0..<cardStackList[largeIndex].list().count {
                let card = cardStackList[largeIndex].list()[index]
                let cardView = CardImageView(frame: CGRect(x: 0, y: 0, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio))
                cardView.image = card.image()
                self.container[largeIndex].addSubview(cardView)
            }
        }
    }
}
