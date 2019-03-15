//
//  KlondikePresenter.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 10..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class KlondikePresenter {
    
    private weak var pileView: PileView?
    private weak var previewView: PreviewView?
    private weak var columnsView: ColumnsView?
    private weak var goalsView: GoalsView?
    private let klondike = Klondike()
    
    init() {
        addObservers()
    }
    
    func attach(pileView: PileView) {
        self.pileView = pileView
    }
    
    func attach(previewView: PreviewView) {
        self.previewView = previewView
    }
    
    func attach(columnsView: ColumnsView) {
        self.columnsView = columnsView
    }
    
    func attach(goalsView: GoalsView) {
        self.goalsView = goalsView
    }
    
    func detachPileView() {
        self.pileView = nil
    }
    
    func detachPreviewView() {
        self.previewView = nil
    }
    
    func detachColumnsView() {
        self.columnsView = nil
    }
    
    func detachGoalsView() {
        self.goalsView = nil
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
                                               name: Pile.didAddNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePileStackView),
                                               name: Pile.didPopNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPreviewStackView),
                                               name: Preview.didAddNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePreviewStackView),
                                               name: Preview.didPopNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(initialSettingColumns),
                                               name: Columns.didCreateNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addColumnsStackView),
                                               name: Column.didAddNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeColumnsStackView),
                                               name: Column.didPopNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addGoalsStackView),
                                               name: Goal.didAddNotiName(),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeGoalsStackView),
                                               name: Goal.didPopNotiName(),
                                               object: nil)
    }
    
    @objc private func addPileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        pileView?.addPileStackView(count: cards.count)
    }
    
    @objc private func removePileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        pileView?.removePileStackView(count: count)
    }
    
    @objc private func addPreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        previewView?.addPreviewStackView(cards: cards)
    }
    
    @objc private func removePreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        previewView?.removePreviewStackView(count: count)
    }
    
    @objc private func addColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Column,
            let index = klondike.index(of: sender) else { return }
        columnsView?.addColumnsStackView(cards: cards, index: index)
    }
    
    @objc private func removeColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Column,
            let position = klondike.index(of: sender) else { return }
        let topCardOfStack = userInfo[UserInfoKey.topCardOfStack] as? Card
        columnsView?.removeColumnsStackView(count: count, index: position, card: topCardOfStack)
    }
    
    @objc private func initialSettingColumns(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let countOfBackCard = userInfo[UserInfoKey.countOfBackCards] as? Int,
            let topCardOfColumn = userInfo[UserInfoKey.topCardOfStack] as? Card,
            let index = userInfo[UserInfoKey.index] as? Int else { return }
        columnsView?.initialSettingColumns(count: countOfBackCard, index: index, card: topCardOfColumn)
    }
    
    @objc private func addGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Goal,
            let index = klondike.index(of: sender) else { return }
        goalsView?.addGoalsStackView(cards: cards, index: index)
    }
    
    @objc private func removeGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Goal,
            let index = klondike.index(of: sender) else { return }
        goalsView?.removeGoalsStackView(count: count, index: index)
    }
}
