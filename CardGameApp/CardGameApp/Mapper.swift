//
//  Mapper.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct Mapper {
    
    static let map: [ObjectIdentifier: Int] = [ObjectIdentifier(Goal.self): 10,
                                               ObjectIdentifier(Preview.self): 20,
                                               ObjectIdentifier(Pile.self): 30,
                                               ObjectIdentifier(Column.self): 40,]
}
