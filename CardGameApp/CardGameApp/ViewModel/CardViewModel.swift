//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

/* 카드의 앞/뒤 이미지, 현재 보여질 이미지, 뒤집기와 같은 카드뷰모델 정보 관리 */
class CardViewModel {

    let card: Card
    private(set) var status: Observable<FaceState>
    private(set) var location: Observable<Location>

    var isUserInteractive: Bool {
        var isUserInteractive: Bool
        switch location.value {
        case .waste: isUserInteractive = true
        case .spare: isUserInteractive = false
        case .foundation: isUserInteractive = false
        case .tableau: isUserInteractive = (status.value == .up) ? true : false
        }
        return isUserInteractive
    }

    init(card: Card, status: FaceState, location: Location) {
        self.card = card
        self.status = Observable(status)
        self.location = Observable(location)
    }

    func turnOver(to status: FaceState) {
        self.status.value = status
    }

    func onCurrentFace() -> UIImage {
        switch status.value {
        case .up: return UIImage(imageLiteralResourceName: card.frontImageFileName)
        case .down: return UIImage(imageLiteralResourceName: card.backImageFileName)
        }
    }

    func move(to location: Location) {
        self.location.value = location
    }
}
