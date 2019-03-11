//
//  KlondikePresenter.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 10..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class KlondikePresenter {
    
    private weak var view: KlondikeView?
    private let klondike = Klondike()
    
    init() {
        addObservers()
    }
    
    func attach(view: KlondikeView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func setUp() {
        self.klondike.setUp()
    }
    
    func reset() {
        self.klondike.reset()
    }
    
    func movePreviewTopCard() {
        klondike.movePreviewTopCard()
    }
    
    func moveGoalTopCard(index: Int) {
        klondike.moveGoalTopCard(index: index)
    }
    
    func moveColumn(position: Position) {
        klondike.moveColumnCardIn(position: position)
    }
    
    func flipCardsFromThePileToPreview() {
        klondike.flipCardsFromThePileToPreview()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPileStackView),
                                               name: .pileDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePileStackView),
                                               name: .pileDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPreviewStackView),
                                               name: .previewDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePreviewStackView),
                                               name: .previewDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(initialSettingColumns),
                                               name: .columnDidCreate,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addColumnsStackView),
                                               name: .columnDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeColumnsStackView),
                                               name: .columnDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addGoalsStackView),
                                               name: .goalDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeGoalsStackView),
                                               name: .goalDidPop,
                                               object: nil)
    }
    
    @objc private func addPileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        view?.addPileStackView(count: cards.count)
    }
    
    @objc private func removePileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        view?.removePileStackView(count: count)
    }
    
    @objc private func addPreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        view?.addPreviewStackView(cards: cards)
    }
    
    @objc private func removePreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        view?.removePreviewStackView(count: count)
    }
    
    @objc private func addColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Column,
            let index = klondike.index(of: sender) else { return }
        view?.addColumnsStackView(cards: cards, index: index)
    }
    
    @objc private func removeColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Column,
            let position = klondike.index(of: sender) else { return }
        let topCardOfStack = userInfo[UserInfoKey.topCardOfStack] as? Card
        view?.removeColumnsStackView(count: count, index: position, card: topCardOfStack)
    }
    
    @objc private func initialSettingColumns(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let countOfBackCard = userInfo[UserInfoKey.countOfBackCards] as? Int,
            let topCardOfColumn = userInfo[UserInfoKey.topCardOfStack] as? Card,
            let index = userInfo[UserInfoKey.index] as? Int else { return }
        view?.initialSettingColumns(count: countOfBackCard, index: index, card: topCardOfColumn)
    }
    
    @objc private func addGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Goal,
            let index = klondike.index(of: sender) else { return }
        view?.addGoalsStackView(cards: cards, index: index)
    }
    
    @objc private func removeGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Goal,
            let index = klondike.index(of: sender) else { return }
        view?.removeGoalsStackView(count: count, index: index)
    }
}
