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
    
    private var columns: [CardStack]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(countOfColumns: Int = 7) {
        var columns = [Column]()
        
        for index in 0..<countOfColumns {
            let position = index + 1
            columns.append(Column(position: position))
        }
        
        self.columns = columns
    }
    
    //MARK: Instance
    
    func add(stack: CardStack, to position: Int) {
        self.columns[position].put(stack: stack)
    }
    
    func emptyAll() {
        for stack in columns {
            stack.empty()
        }
    }
}
