//
//  Columns.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 8..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Columns {
    
    //MARK: - Properties
    //MARK: Private
    
    private var columns: [CardStack]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init?(cardStacks: [CardStack]) {
        
        guard cardStacks.count == 7 else { return nil }
        
        self.columns = cardStacks
    }
}
