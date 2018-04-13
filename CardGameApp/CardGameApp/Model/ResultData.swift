//
//  ResultData.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultData: CustomStringConvertible {
    var result: String
    
    var description: String {
        return self.result
    }

    init(result: String) {
        self.result = result
    }

}
