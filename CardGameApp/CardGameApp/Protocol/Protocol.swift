//
//  Protocol.swift
//  CardGameApp
//
//  Created by oingbong on 16/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

protocol BasicViewModeling {
    func postNotification()
    func push(_ card: Card, at index: Int?)
    func removeAll()
}

protocol DeliverableViewModeling: BasicViewModeling {
    func pop(at index: Int?, sub subIndex: Int?) -> Card?
    func info(at index: Int?) -> Card?
    func lastCard(at index: Int?) -> Card?
    func hasCard(at index: Int?) -> Bool
}

protocol DeliverableViewable {
    func drawSubView()
    func convert(at index: Int?, to view: UIView) -> CGPoint?
    func topSubView(at index: Int?) -> UIView?
}

protocol DestinationViewable {
    func convert(at index: Int?, to view: UIView) -> CGPoint?
}

protocol SingleDataSource {
    func card(_ handler: (Card) -> Void)
}

protocol MultipleDataSource {
    func card(_ handler: (Card, Int) -> Void)
}

protocol CardReceiving {
    var dataSource: SingleDataSource? { get }
}

protocol CardContainerReceiving {
    var dataSource: MultipleDataSource? { get }
}
