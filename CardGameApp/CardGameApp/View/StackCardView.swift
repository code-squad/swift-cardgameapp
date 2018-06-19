//
//  StackCardView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 16..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class StackCardView: BaseView {
    
    private let stackField: ConcreateCardView = ConcreateCardView()
    private var stackCards: [UIImageView] = []
    
    override func setupView() {
        super.setupView()
        makeStackCard()
    }
    
    private func makeStackCard() {
        for _ in 1 ... 7 {
            stackCards.append(directorView.createCardView(stackField))
        }
    }
    
    func makelocationStackCard(_ stackCardNames: [String]) {
        for (index, stackCardName) in stackCardNames.enumerated() {
            addSubview(stackCards[index])
            stackCards[index].image = UIImage(named: stackCardName)
            stackCards[index].frame = CGRect(x: (CARDGAMEAPP.LAYOUT.width.rawValue / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue) +
                ((CARDGAMEAPP.LAYOUT.width.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue) * CGFloat(index)),
                                             y: CARDGAMEAPP.LAYOUT.top.rawValue + CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue,
                                             width: CARDGAMEAPP.LAYOUT.width.rawValue,
                                             height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
            
        }

    }
}
