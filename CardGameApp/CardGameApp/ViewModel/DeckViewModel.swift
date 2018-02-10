//
//  DeckViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 8..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation
import UIKit

/* Deck에서 뺀 카드와 남은 카드뷰모델 정보 관리 */
class DeckViewModel {
    private var deck: Deck {
        didSet {
            // deck에 변화가 생기면 deck에 남은 카드들을 다시 spare에 업데이트한다.
            guard let remnants = deck.remnants() else { return }
            spareCardDummy.cards.value = remnants.cards.value
        }
    }

    private(set) var fetchedCardDummys: [CardStack]
    private(set) var spareCardDummy: CardStack
    private(set) var revealedCardDummy: CardStack
    private(set) var arrangedCardDummys: [CardStack]

    init() {
        self.deck = Deck()
        self.fetchedCardDummys = []
        self.spareCardDummy = CardStack()
        self.revealedCardDummy = CardStack()
        self.arrangedCardDummys = []
        initialize()
    }

    func initialize() {
        self.deck.shuffle()
        fetch(InitialGameSettings.maxStud)
        if let remnants = deck.remnants() {
            spareCardDummy.cards.value = remnants.cards.value
        }
    }

    // 여러 장 fetch. 초기화 시 사용되며, 그 이후에는 1장씩 이동되므로 필요 없음.
    private func fetch(_ maxFetchCount: Int) {
        for countForCurrentStack in 1...maxFetchCount {
            guard let fetchedCards = deck.fetch(countForCurrentStack) else { break }
            // 기존 스택이 있는 경우 (바인드를 위해 더미를 초기화하면 안 되므로 기존 스택을 재사용)
            if self.fetchedCardDummys.count >= maxFetchCount {
                self.fetchedCardDummys[countForCurrentStack-1].cards.value = fetchedCards.cards.value
            } else {
                // 맨 처음 초기화 시에는 스택을 붙인다.
                self.fetchedCardDummys.append(fetchedCards)
            }
        }
    }

    // deck 리셋 후 섞기
    func reset() {
        self.fetchedCardDummys.forEach {
            $0.cards.value = []
        }
        self.spareCardDummy.cards.value = []
        self.revealedCardDummy.cards.value = []
        self.arrangedCardDummys.forEach {
            $0.cards.value = []
        }
        // 카드 더미 자체를 초기화하면 bind가 안 된다. 기존 객체에만 연결돼 있으므로..
        deck = Deck()
        initialize()
    }

    // spare 카드뷰 탭 시 호출됨.
    func updateSpareTopCard() {
        if let topCardOnSpare = spareCardDummy.pop() {
            revealedCardDummy.push(card: topCardOnSpare)
        } else {
            restoreSpareDummy()
        }
    }

    private func restoreSpareDummy() {
        spareCardDummy.cards.value = revealedCardDummy.cards.value.reversed()
        revealedCardDummy.cards.value = []
    }

}

extension DeckViewModel {
    struct InitialGameSettings {
        static var maxStud: Int = 7
        static var vacantSpaceCount: Int = 4
        static var refresh: String = "cardgameapp-refresh-app"
        static var spareViewCount: Int = 4
    }

    struct CardPresentable {
        static let cornerRadius: CGFloat = 5
        static let clipToBounds: Bool = true
        static let borderColor: CGColor = UIColor.white.cgColor
        static let borderWidth: CGFloat = 2
    }
}

extension CardStack {
    func topCardViewModel(_ shouldTurnOver: Bool) -> CardViewModelType? {
        guard let currentTopCard = self.getTopCard() else { return nil }
        let topCardViewModel = CardViewModel(card: currentTopCard)
        topCardViewModel.turnOver(toFrontFace: shouldTurnOver)
        return topCardViewModel
    }

    func existCardViewModels(_ shouldTurnOverAtMostFrontCard: Bool) -> [CardViewModelType] {
        var cardViewModels: [CardViewModelType] = []
        for current in 0..<self.count {
            guard let topCard = self.pop() else { break }
            let topCardViewModel = CardViewModel(card: topCard)
            // 마지막(맨앞) 카드는 뒤집는다.
            if current == 0 {
                topCardViewModel.turnOver(toFrontFace: shouldTurnOverAtMostFrontCard)
            }
            cardViewModels.insert(topCardViewModel, at: 0)
        }
        return cardViewModels
    }
}
