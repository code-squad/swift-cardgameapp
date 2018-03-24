//
//  FoundationViewModels.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 25..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class FoundationViewModels: Sequence {
    let start: Int = 0
    private var foundationViewModels: [CardStackPresentable]

    convenience init() {
        self.init(Foundations())
    }

    init(_ foundations: Foundations) {
        foundationViewModels = foundations.enumerated().map {
            FoundationViewModel($0.element, stackNumber: $0.offset)
        }
    }

    func makeIterator() -> ClassIteratorOf<CardStackPresentable> {
        return ClassIteratorOf(self.foundationViewModels)
    }

    func bind(with foundations: Foundations) {
        for (model, viewModel) in zip(foundations, foundationViewModels) {
            model.cards.bind {
                model.isAdded ? viewModel.append($0) : viewModel.remove()
            }
        }
    }

    func at(_ index: Int) -> CardStackPresentable {
        return foundationViewModels[index]
    }
}
