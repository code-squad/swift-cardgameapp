//
//  TableauViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class TableauViewModel {
    private var tableauModels: [TableauModel]
    
    init() {
        var modelList = [TableauModel]()
        for _ in 0..<Unit.tableauCount {
            let tableauModel = TableauModel()
            modelList.append(tableauModel)
        }
        self.tableauModels = modelList
    }
    
    func push(_ card: Card, index: Int) {
        tableauModels[index].push(card)
    }
    
    func removeAll() {
        for index in 0..<tableauModels.count {
            tableauModels[index].removeAll()
        }
    }
    
    func lastCard(index: Int) -> Card? {
        return tableauModels[index].lastCard
    }
}

extension TableauViewModel {
    subscript(index: Int) -> TableauModel {
        return tableauModels[index]
    }
}
