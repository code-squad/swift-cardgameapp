//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation
import UIKit

/* 카드의 앞/뒤 이미지, 현재 보여질 이미지, 뒤집기와 같은 카드뷰모델 정보 관리 */
class CardViewModel: CardViewModelType {
    private let card: Card
    private let frontImage: UIImage
    private let backImage: UIImage
    private var isFaceUp: Bool

    init(card: Card, isFaceUp: Bool=false) {
        self.card = card
        self.frontImage = UIImage(imageLiteralResourceName: Mapper.mapFrontImageName(of: card))
        self.backImage = UIImage(imageLiteralResourceName: "card-back")
        self.isFaceUp = isFaceUp
    }

    var image: UIImage {
        return isFaceUp ? frontImage : backImage
    }

    func turnOver(toFrontFace frontFaceToBeUp: Bool) {
        self.isFaceUp = frontFaceToBeUp
    }
}
