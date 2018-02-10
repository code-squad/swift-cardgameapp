//
//  CardViewModelProtocol.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 8..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

protocol CardViewModelProtocol {
    var frontImage: String { get }
    var backImage: String { get }
    func turnOver(toFrontFace frontFaceToBeUp: Observable<Bool>)
}
