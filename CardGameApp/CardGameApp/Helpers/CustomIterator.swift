//
//  CustomIterator.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 클래스 iterator
class ClassIteratorOf<Type>: IteratorProtocol {
    typealias Element = Type
    private let elements: [Element]
    private var nextIndex: Int
    init(_ elements: [Element]) {
        self.nextIndex = 0
        self.elements = elements
    }

    func next() -> Element? {
        defer { self.nextIndex += 1 }
        guard self.nextIndex < self.elements.count else { return nil }
        return self.elements[self.nextIndex]
    }

}

// 구조체 iterator
struct StructIteratorOf<Type>: IteratorProtocol {
    typealias Element = Type
    private let elements: [Element]
    private var nextIndex: Int
    init(_ elements: [Element]) {
        self.nextIndex = 0
        self.elements = elements
    }

    mutating func next() -> Element? {
        defer { self.nextIndex += 1 }
        guard self.nextIndex < self.elements.count else { return nil }
        return self.elements[self.nextIndex]
    }
}
