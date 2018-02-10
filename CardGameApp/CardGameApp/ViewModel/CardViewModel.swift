//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation
import UIKit

class CardViewModel {
    private let card: Card
    private let frontImageName: String
    private let backImageName: String
    private var isFrontFaceUp: Bool
//    private(set) var size: CGSize
//    private var stackLaidOn: Observable<CardStackViewModel>

    init(card: Card, isFrontFaceUp: Bool=false) {
        //sizeOf size: CGSize, onStack stackLaidOn: Observable<CardStackViewModel>) {
        self.card = card
        self.frontImageName = Mapper.mapFrontImageName(of: card)
        self.backImageName = Constants.ImageName.cardBack
        self.isFrontFaceUp = isFrontFaceUp
//        self.size = size
//        self.stackLaidOn = stackLaidOn
    }

    func turnOver(toFrontFace frontFaceToBeUp: Bool) {
        self.isFrontFaceUp = frontFaceToBeUp
    }
}

//extension CardViewModel: CardPresentable {
//    var cornerRadius: CGFloat {
//        return Constants.CardView.cornerRadius
//    }
//
//    var clipToBounds: Bool {
//        return Constants.CardView.clipsToBounds
//    }
//
//    var borderColor: CGColor {
//        return Constants.CardView.borderColor
//    }
//
//    var borderWidth: CGFloat {
//        return Constants.CardView.borderWidth
//    }
//
//}

