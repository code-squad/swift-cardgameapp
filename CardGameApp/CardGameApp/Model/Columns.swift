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
    
    private var columns: [CardStack] = {
        
        var columns = [CardStack]()
        
        for position in 0..<7 {
            let position = CardStackType.columns(position: position)
            let cardStack = CardStack(type: position)
            columns.append(cardStack)
        }
        
        return columns
    }()
    
    //MARK: - Methods
    
    func add(stack: CardStack, to position: Int) {
        self.columns[position].put(stack: stack)
    }
    
    func emptyAll() {
        
        for stack in columns {
            stack.empty()
        }
    }
}
