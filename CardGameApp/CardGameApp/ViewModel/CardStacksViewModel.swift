//
//  CardStacksViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 31/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

protocol CardStacksViewModelDelegate {
    init(cardStacks: CardStacks)
    var imageNames: [[String?]?]? { get }
    var imagesDidChange: ((CardStacksViewModelDelegate) -> ())? { get set }
    func refresh()
}

class CardStacksViewModel: CardStacksViewModelDelegate {
    private var cardStacks: CardStacks

    required init(cardStacks: CardStacks) {
        self.cardStacks = cardStacks
    }

    var imageNames: [[String?]?]? {
        didSet {
            imagesDidChange?(self)
        }
    }

    var imagesDidChange: ((CardStacksViewModelDelegate) -> ())?

    func refresh() {
        imageNames = cardStacks.imageNames
    }

}
