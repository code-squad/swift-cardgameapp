//
//  Card.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 24..
//  Copyright © 2017년 심 승민. All rights reserved.
//

import Foundation

class Card {
    private(set) var shape: Shape
    private(set) var number: Number
    init(_ shape: Shape, _ number: Number) {
        self.shape = shape
        self.number = number
    }

    var color: Color {
        switch shape {
        case .clubs, .spades: return .black
        case .diamonds, .hearts: return .red
        }
    }

    var info: (shape: Shape, number: Number) {
        return (self.shape, self.number)
    }

}

// 카드를 비교할 경우, 카드의 숫자를 비교. (Shape과 Number의 캡슐화를 위함.)
extension Card: Equatable, Comparable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        guard lhs.number == rhs.number else { return false }
        return true
    }

    static func < (lhs: Card, rhs: Card) -> Bool {
        guard lhs.number < rhs.number else { return false }
        return true
    }

}

extension Card {
    func convertToCardViewModel(_ faceState: FaceState, borderState: BorderState, on location: Location) -> CardViewModel {
        return CardViewModel(card: self, faceState: faceState, borderState: borderState, location: location)
    }
}
