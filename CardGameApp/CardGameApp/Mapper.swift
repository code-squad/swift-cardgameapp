//
//  Mapper.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct Mapper {
    
    static let map: [ObjectIdentifier: Int] = [ObjectIdentifier(Goal.self): 1,
                                               ObjectIdentifier(Preview.self): 2,
                                               ObjectIdentifier(Pile.self): 3,
                                               ObjectIdentifier(Column.self): 4,]
}
