//
//  Error.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 27..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import Foundation

enum CardGameError: Error {
    case emptyCard
    var localizedDescription: String {
        switch self {
        case .emptyCard: return "카드가 더이상 없습니다."
        }
    }
}

public extension Error {
    var localizedDescription: String {
        guard let error = self as? CardGameError else {
            return ""
        }
        return error.localizedDescription
    }
}
