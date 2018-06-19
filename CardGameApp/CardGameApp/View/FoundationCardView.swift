//
//  MainView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 14..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class FoundationCardView: BaseView {
  
    private let createFoundation: ConcreateFoundationView = ConcreateFoundationView()   // FoundationView 구현, 객체 생성 결과의 대한 책임
    private var foundationFields: [UIImageView] = []

    override func setupView() {
        super.setupView()
        makeFoudationView()
        makelocationFoundationView(foundationFields)
    }
    
    private func makeFoudationView() {
        for _ in 1 ... 4 {
            let foundationView = directorView.createFoundationView(createFoundation)
            foundationFields.append(foundationView)
        }
    }
    
    private func makelocationFoundationView(_ foundationViews: [UIImageView]) {
        for (index, view) in foundationFields.enumerated() {
            addSubview(view)
            view.frame = CGRect(x: (CARDGAMEAPP.LAYOUT.width.rawValue / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue) +
                ((CARDGAMEAPP.LAYOUT.width.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue) * CGFloat(index)),
                                y: CARDGAMEAPP.LAYOUT.top.rawValue,
                                width: CARDGAMEAPP.LAYOUT.width.rawValue,
                                height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)

        }
    }
}
