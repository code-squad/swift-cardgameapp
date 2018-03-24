//
//  TableauViewModels.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 25..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class TableauViewModels: Sequence {
    let start: Int = 0
    private var tableauViewModels: [CardStackPresentable]

    convenience init() {
        self.init(Tableaus())
    }

    init(_ tableaus: Tableaus) {
        tableauViewModels = tableaus.enumerated().map {
            TableauViewModel($0.element, stackNumber: $0.offset)
        }
    }

    func makeIterator() -> ClassIteratorOf<CardStackPresentable> {
        return ClassIteratorOf(self.tableauViewModels)
    }

    func bind(with tableaus: Tableaus) {
        for (model, viewModel) in zip(tableaus, tableauViewModels) {
            model.cards.bind {
                model.isAdded ? viewModel.append($0) : viewModel.remove()
            }
        }
    }

    func at(_ index: Int) -> CardStackPresentable {
        return tableauViewModels[index]
    }
}
