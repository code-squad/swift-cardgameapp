//
//  Columns.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Columns {
    
    //MARK: - Properties
    //MARK: Pirvate
    
    private var columns: [Column]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(countOfColumns: Int = 7) {
        var columns = [Column]()
        
        for _ in 0..<countOfColumns {
            columns.append(Column())
        }
        
        self.columns = columns
    }
    
    //MARK: Instance
    
    subscript(index: Int) -> Column? {
        get {
            guard 0 <= index && index < columns.count else { return nil }
            return columns[index]
        }
        set {
            guard let column = newValue,
                let topCardOfColunm = column.peek() else { return }
            columns[index] = column
            let countOfBackCards = column.count() - 1
            
            NotificationCenter.default.post(name: type(of: self).didCreateNotiName(),
                                            object: self,
                                            userInfo: [UserInfoKey.countOfBackCards: countOfBackCards,
                                                       UserInfoKey.topCardOfStack: topCardOfColunm,
                                                       UserInfoKey.index: index])
        }
    }
    
    func add(stack: CardStack, to position: Int) {
        self.columns[position].put(stack: stack)
    }
    
    func emptyAll() {
        for column in columns {
            column.empty()
        }
    }
    
    func position(of cardStack: CardStack) -> Int? {
        return self.columns.firstIndex(where: {$0===cardStack})
    }
    
    func indexOfEmptyColumn() -> Int? {
        return columns.firstIndex(where: {$0.isEmpty()})
    }
    
    func indexOfMoveableToColumns(_ card: Card) -> Int? {
        return self.columns.firstIndex(where: {card.isMoveableToColumn($0.peek())})
    }
    
    static func didCreateNotiName() -> Notification.Name {
        return Notification.Name("\(self)DidCreate")
    }
}
