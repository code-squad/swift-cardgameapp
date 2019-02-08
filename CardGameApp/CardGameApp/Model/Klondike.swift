//
//  Klondike.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 7..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Klondike {
    
    //MARK: - Properties
    //MARK: Delegate
    
    private var delegate: KlondikeDelegate
    
    //MARK: Private
    
    private var goals = Goals()
    private var preview = Preview()
    private var pile: Pile
    private var columns: [CardStack]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(delegate: KlondikeDelegate) {
        
        self.delegate = delegate
        
        
    }
}
