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
    
    init(cardStacks: [CardStack]) {
        self.columns = cardStacks
    }
}
