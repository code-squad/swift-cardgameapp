//
//  Observable.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 9..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

// 원시타입 관찰
class Observable<ObservingType> {
    typealias Listener = (ObservingType) -> Void
    private var listener: Listener?
    var value: ObservingType {
        didSet {
            listener?(value)
        }
    }

    required init(_ value: ObservingType) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(self.value)
    }
}

class ObservableCollection<ObservingType: Sequence> {
    typealias Listener = (ObservingType.Element?) -> Void
    private var listener: Listener?
    var collection: ObservingType {
        didSet {
            prevCount = oldValue.underestimatedCount
            // 변경된 collection의 마지막 인자를 element로 저장
            if collection.underestimatedCount > 0 {
                self.element = collection.reversed().first
            } else {
                self.element = nil
            }
        }
    }
    private(set) var prevCount: Int = 0
    var element: ObservingType.Element? {
        didSet {
            listener?(element)
        }
    }

    required init(_ collection: ObservingType) {
        self.collection = collection
        for element in collection {
            self.element = element
        }
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(element)
    }
}
