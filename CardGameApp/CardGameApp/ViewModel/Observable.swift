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

// 스택과 같이 Sequence 타입 관찰 - 안 됨..
//class ContainerObserving<ContainerType: Sequence> {
//    typealias ObservingType = ContainerType.Iterator
//    typealias Listener = (ObservingType) -> Void
//    private var listener: Listener?
//    var value: ObservingType {
//        didSet {
//            listener?(value)
//        }
//    }
//    var container: ContainerType
//
//    required init(_ container: ContainerType) {
//        self.container = container
//        self.value = container.makeIterator()
//    }
//
//    func bind(_ listener: ((ContainerObserving.ObservingType) -> Void)?) {
//        self.listener = listener
//    }
//
//    func bindAndFire(_ listener: ((ContainerObserving.ObservingType) -> Void)?) {
//        self.listener = listener
//        listener?(self.value)
//    }
//
//}
