////
////  containsCardViewModel.swift
////  CardGameApp
////
////  Created by 심 승민 on 2018. 2. 12..
////  Copyright © 2018년 심 승민. All rights reserved.
////
//
//import Foundation
//
//protocol ContainsCardStack {
//    var cardDummy: CollectionObservable<CardStack> { get }
//    func makeFrontCardViewModel(_ faceState: FaceState, on location: Location) -> CardViewModel?
//    func makeCardViewModels(faceState: FaceState, shouldTurnOverFrontCard: FaceState, on location: Location) -> [CardViewModel]
//}
//
//extension ContainsCardStack {
//    func makeFrontCardViewModel(_ faceState: FaceState, on location: Location) -> CardViewModel? {
//        guard let currentTopCard = cardDummy.collection.peek() else { return nil }
//        let frontCardViewModel = CardViewModel(card: currentTopCard, faceState: faceState, location: location)
//        return frontCardViewModel
//    }
//
//    func makeCardViewModels(faceState: FaceState, shouldTurnOverFrontCard: FaceState, on location: Location) -> [CardViewModel] {
//        var cardViewModels: [CardViewModel] = []
//        for (index, card) in cardDummy.collection.enumerated() {
//            let faceState = (index == cardDummy.collection.endIndex-1 ) ? shouldTurnOverFrontCard : faceState
//            let frontCardViewModel = CardViewModel(card: card, faceState: faceState, location: location)
//            cardViewModels.append(frontCardViewModel)
//        }
//        return cardViewModels
//    }
//
//}

