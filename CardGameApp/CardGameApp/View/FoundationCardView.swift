//
//  MainView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 14..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class FoundationCardView: BaseView {
    
    private let firstFiled: UIImageView = CARDGAMEAPP.FRAME.foundationField.instance
    private let secondFiled: UIImageView = CARDGAMEAPP.FRAME.foundationField.instance
    private let thirdFiled: UIImageView = CARDGAMEAPP.FRAME.foundationField.instance
    private let fourFiled: UIImageView = CARDGAMEAPP.FRAME.foundationField.instance
    
    override func setupView() {
        super.setupView()
        addSubView(firstFiled, secondFiled, thirdFiled, fourFiled)
        makeFoundationCard()
    }
    
    private func makeFoundationCard() {
        let foundationFileds: [UIImageView] = [firstFiled, secondFiled, thirdFiled, fourFiled]

        for (index, view) in foundationFileds.enumerated() {
            view.frame = CGRect(x: (CARDGAMEAPP.LAYOUT.width.rawValue / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue) +
                               ((CARDGAMEAPP.LAYOUT.width.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue) * CGFloat(index)),
                                y: CARDGAMEAPP.LAYOUT.top.rawValue,
                                width: CARDGAMEAPP.LAYOUT.width.rawValue,
                                height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
        }
    }

    
}
