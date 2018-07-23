//
//  CardStackPrintable.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

protocol CardStackPrintable {
    func printCardStack(_ handler: (_ cards: [Card]) -> Void )
}

protocol OutputPrintable {
    func countOfCards() -> String
}
