//
//  FoundationView.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class FoundationContainerView: UIView {
    // 카드몰드는 배열에도 속하지 않고 그냥 모양을 나타내기 위해 addSubView만 합니다.
    
    private var container: [UIView]
    private let freeSpace = CGFloat(5.17)
    private let imageWidth = CGFloat(53.22)
    
    override init(frame: CGRect) {
        self.container = [UIView]()
        super.init(frame: frame)
        addSubViewToFoundation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.container = [UIView]()
        super.init(coder: aDecoder)
    }
    
    private func addSubViewToFoundation() {
        var xValue = freeSpace
        for _ in 0..<Unit.cardCountNumber {
            let mold = cardMold(xValue: xValue, yValue: 0)
            // 모델에서 추가할 때는 인덱스를 보고 추가하기 위해 배열에 넣어 사용합니다.
            self.addSubview(mold)
            //            self.container.append(mold)
            
            //            let container = tableauContainer(xValue: xValue, yValue: 0)
            let rect = CGRect(x: xValue, y: 0, width: imageWidth * Unit.widthRatio, height: self.frame.height - 200)
            let container = UIView(frame: rect)
            container.layer.borderColor = UIColor.red.cgColor
            container.layer.borderWidth = 1
            self.addSubview(container)
            self.container.append(container)
            //            self.tableauContainerView.append(view: container)
            let newXValue = xValue + mold.frame.width + freeSpace
            xValue = newXValue
        }
    }
    
    private func cardMold(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: imageWidth * Unit.widthRatio, height: imageWidth * Unit.heightRatio)
        let mold = UIView(frame: rect)
        mold.layer.borderWidth = Unit.foundationBorderWidth
        mold.layer.borderColor = Unit.foundationBorderColor
        return mold
    }
}
