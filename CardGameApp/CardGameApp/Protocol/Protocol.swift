//
//  Protocol.swift
//  CardGameApp
//
//  Created by oingbong on 16/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol BasicViewModel {
    func push(card: Card, index: Int?)
    func removeAll()
}

protocol DeliverableViewModel: BasicViewModel {
    func pop(index: Int?) -> Card?
    func info(index: Int?) -> Card?
    func lastCard(index: Int?) -> Card?
    func hasCard(index: Int?) -> Bool
}

protocol DeliverableView {
    func draw()
}

protocol SingleDataSource {
    func cardStack() -> CardStack
}

protocol MultipleDataSource {
    func cardStackList() -> [CardStack]
}

protocol DrawView {
    func draw()
}

protocol CardView: DrawView {
    var dataSource: SingleDataSource? { get }
}

protocol CardContainerView: DrawView {
    var dataSource: MultipleDataSource? { get }
}
