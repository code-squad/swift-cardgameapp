//
//  DeckView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 15..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class DeckView: BaseView {
    
    private let deckField: UIImageView = CARDGAMEAPP.Attributes.deckField.instance
    
    override func setupView() {
        super.setupView()
        
        addSubView(deckField)
        makeDeck()
    }
    
    private func makeDeck() {
        deckField.frame = CGRect(x: UIScreen.main.bounds.width - CARDGAMEAPP.LAYOUT.width.rawValue - CARDGAMEAPP.LAYOUT.margin.rawValue,
                            y: CARDGAMEAPP.LAYOUT.top.rawValue,
                            width: CARDGAMEAPP.LAYOUT.width.rawValue,
                            height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
    }
}
