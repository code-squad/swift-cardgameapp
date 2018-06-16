//
//  StackCardView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 16..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class StackCardView: BaseView {
    
    private let stackCardFirst: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    private let stackCardSecond: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    private let stackCardThird: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    private let stackCardFour: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    private let stackCardFifth: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    private let stackCardSixth: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    private let stackCardSeventh: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    
    override func setupView() {
        super.setupView()
        addSubView(stackCardFirst, stackCardSecond, stackCardThird, stackCardFour, stackCardFifth, stackCardSixth, stackCardSeventh)
    }
    
    func makeInitStackView(_ stackCardNames: [String]) {
        let stackCards: [UIImageView] = [stackCardFirst, stackCardSecond, stackCardThird, stackCardFour, stackCardFifth, stackCardSixth, stackCardSeventh]
        
        for (index, stackCardName) in stackCardNames.enumerated() {
            stackCards[index].image = UIImage(named: stackCardName)
            stackCards[index].frame = CGRect(x: (CARDGAMEAPP.LAYOUT.width.rawValue / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue) +
                ((CARDGAMEAPP.LAYOUT.width.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue) * CGFloat(index)),
                                y: CARDGAMEAPP.LAYOUT.top.rawValue + CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue + CARDGAMEAPP.LAYOUT.margin.rawValue,
                                width: CARDGAMEAPP.LAYOUT.width.rawValue,
                                height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
            
        }
    }
}
