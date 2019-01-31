//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

protocol CardViewModelDelegate {
    init(card: Card)
    var imageName: String? { get }
    var imageDidChange: ((CardViewModelDelegate) -> ())? { get set }
    func flip()
}

class CardViewModel: CardViewModelDelegate {
    private var card: Card

    required init(card: Card) {
        self.card = card
    }

    var imageName: String? {
        didSet {
            imageDidChange?(self)
        }
    }

    var imageDidChange: ((CardViewModelDelegate) -> ())?

    func flip() {
        card.flip()
        imageName = card.imageName
    }

}
