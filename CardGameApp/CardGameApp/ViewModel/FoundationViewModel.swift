//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class FoundationViewModel {
    private let faceState: FaceState = .up
    private(set) var spaceState: SpaceState = .vacant
    private let location: Location

    init(spaceNumber: Int) {
        self.location = .foundation(spaceNumber)
    }

    func push(_ card: Card?) {
        guard let card = card else { return }
        if canPush(card) {
            spaceState = .exist(Observable(card))
        }
    }

    func canPush(_ card: Card) -> Bool {
        var canPush = Bool()
        switch spaceState {
        case .exist(let existCard):
            canPush = (card.shape == existCard.value.shape)
                && (card.number.rawValue == existCard.value.number.rawValue+1)
        case .vacant:
            canPush = (card.number == .ace)
        }
        return canPush
    }

    func reset() {
        self.spaceState = .vacant
    }
}
