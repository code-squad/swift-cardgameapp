//
//  MainView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 14..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class FoundationCardView: BaseView {
    
    private let firstField: UIImageView = CARDGAMEAPP.Attributes.foundationField.instance
    private let secondField: UIImageView = CARDGAMEAPP.Attributes.foundationField.instance
    private let thirdField: UIImageView = CARDGAMEAPP.Attributes.foundationField.instance
    private let fourField: UIImageView = CARDGAMEAPP.Attributes.foundationField.instance
    
    override func setupView() {
        super.setupView()
        addSubView(firstField, secondField, thirdField, fourField)
        makeFoundationCard()
    }
    
    private func makeFoundationCard() {
        let foundationFileds: [UIImageView] = [firstField, secondField, thirdField, fourField]

        for (index, view) in foundationFileds.enumerated() {
            view.frame = CGRect(x: (CARDGAMEAPP.LAYOUT.width.rawValue / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue) +
                               ((CARDGAMEAPP.LAYOUT.width.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue) * CGFloat(index)),
                                y: CARDGAMEAPP.LAYOUT.top.rawValue,
                                width: CARDGAMEAPP.LAYOUT.width.rawValue,
                                height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
        }
    }

    
}
