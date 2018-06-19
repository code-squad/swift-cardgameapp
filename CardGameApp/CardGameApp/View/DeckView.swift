//
//  DeckView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 15..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class DeckView: BaseView {
    
    private let deckField: ConcreateCardView = ConcreateCardView()
    private var deckCards: [UIImageView] = []
    
    override func setupView() {
        super.setupView()
        makeDekcView()
        makelocationDeckView()
    }
    
    private func makeDekcView() {
        deckCards.append(directorView.createCardView(deckField))
    }
    
    private func makelocationDeckView() {
        for deckCard in deckCards {
            addSubview(deckCard)
            deckCard.frame = CGRect(x: UIScreen.main.bounds.width - CARDGAMEAPP.LAYOUT.width.rawValue - CARDGAMEAPP.LAYOUT.margin.rawValue,
                                     y: CARDGAMEAPP.LAYOUT.top.rawValue,
                                     width: CARDGAMEAPP.LAYOUT.width.rawValue,
                                     height: CARDGAMEAPP.LAYOUT.width.rawValue * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
        }
    }

}
