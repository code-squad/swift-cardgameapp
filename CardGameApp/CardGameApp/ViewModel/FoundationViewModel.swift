//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class FoundationViewModel {
    private var foundationModels: [FoundationModel]
    
    init() {
        var modelList = [FoundationModel]()
        for _ in 0..<Unit.foundationCount {
            let foundationModel = FoundationModel()
            modelList.append(foundationModel)
        }
        self.foundationModels = modelList
    }
}
