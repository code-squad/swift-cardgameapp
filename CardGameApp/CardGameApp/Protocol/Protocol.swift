//
//  Protocol.swift
//  CardGameApp
//
//  Created by oingbong on 16/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol BasicViewModel {
    func postNotification()
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
    func drawSubView()
}

protocol SingleDataSource {
    func cardStack() -> CardStack
}

protocol MultipleDataSource {
    func cardStackList() -> [CardStack]
}

protocol CardView {
    var dataSource: SingleDataSource? { get }
}

protocol CardContainerView {
    var dataSource: MultipleDataSource? { get }
}
