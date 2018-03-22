//
//  GameViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class GameViewModel {

    private(set) var game: Game
    private(set) var cardViewModels: [CardViewModel]
    private(set) var spareViewModel: CardStackPresentable
    private(set) var wasteViewModel: CardStackPresentable
    private(set) var foundationViewModels: [CardStackPresentable]
    private(set) var tableauViewModels: [CardStackPresentable]

    init() {
        game = Game()
        cardViewModels = []
        spareViewModel = SpareViewModel()
        wasteViewModel = WasteViewModel()
        foundationViewModels = []
        tableauViewModels = []
    }

    // MARK: - Update Models

    func initialize() {
        game.new()
        initializeViewModels()
        bindModels()
    }

    func moveToWaste(_ cardViewModel: CardViewModel) {
        game.move(cardsFrom: cardViewModel.card, from: .spare, to: .waste)
    }

    func refreshWaste() {
        game.refreshWaste()
    }

    func suitableLocation(for cardViewModel: CardViewModel) -> Location? {
        if case Location.spare = cardViewModel.location.value {
            return .waste
        }
        guard let suitableLocation = game.suitableLocation(cardViewModel.card) else { return nil }
        // 만약 목적지의 마지막 카드가 뒤집힌 카드라면 전달하지 않는다.
        if case let Location.tableau(index) = suitableLocation {
            if let lastCard = tableauViewModels[index].cardViewModels.last, lastCard.status.value == .down {
                return nil
            }
        }
        return suitableLocation
    }

    func move(cardViewModel: CardViewModel, from startLocation: Location, to endLocation: Location) {
        game.move(cardsFrom: cardViewModel.card, from: startLocation, to: endLocation)
    }

    // MARK: - Private Methods

    private func initializeViewModels() {
        spareViewModel = SpareViewModel(game.spare)
        wasteViewModel = WasteViewModel(game.waste)
        foundationViewModels = game.foundations.enumerated().map {
            FoundationViewModel($0.element, stackNumber: $0.offset)
        }
        tableauViewModels = game.tableaus.enumerated().map {
            TableauViewModel($0.element, stackNumber: $0.offset)
        }
    }

    private func bindModels() {
        for (model, viewModel) in zip(game.foundations, foundationViewModels) {
            model.cards.bind {
                model.isAdded ? viewModel.append($0) : viewModel.remove()
            }
        }
        game.spare.cards.bind { [unowned self] in
            self.game.spare.isAdded ? self.spareViewModel.append($0) : self.spareViewModel.remove()
        }
        game.waste.cards.bind { [unowned self] in
            self.game.waste.isAdded ? self.wasteViewModel.append($0) : self.wasteViewModel.remove()
        }
        for (model, viewModel) in zip(game.tableaus, tableauViewModels) {
            model.cards.bind {
                model.isAdded ? viewModel.append($0) : viewModel.remove()
            }
        }
    }

}
