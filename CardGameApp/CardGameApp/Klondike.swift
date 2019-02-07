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
    
    private var goals: [[Card]]
    private var preview: [Card]
    private var pile: [Card]
    private var columns: [[Card]]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(delegate: KlondikeDelegate) {
        self.delegate = delegate
    }
}
