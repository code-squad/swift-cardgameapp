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
class CardViewModel {
    private let frontImage: UIImage
    private let backImage: UIImage
    private(set) var card: Card
    private(set) var faceState: FaceState
    private(set) var location: Location
    private(set) var borderState: BorderState

    init(card: Card, faceState: FaceState, borderState: BorderState, location: Location) {
        self.card = card
        self.frontImage = UIImage(imageLiteralResourceName: Mapper.frontFileName(of: card))
        self.backImage = UIImage(imageLiteralResourceName: "card-back")
        self.faceState = faceState
        self.location = location
        self.borderState = borderState
    }

    func setBorderState(to borderState: BorderState) {
        self.borderState = borderState
    }

    var image: UIImage {
        return faceState == .up ? frontImage : backImage
    }

    func turnOver(toFace faceState: FaceState) {
        self.faceState = faceState
    }

    func updateLocation(to location: Location) {
        self.location = location
    }
}
