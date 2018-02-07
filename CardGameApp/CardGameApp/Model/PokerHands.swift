//
//  PokerHands.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

typealias Rank = Int

// 패 계산 클래스.
class PokerHands {
    // 플레이어가 가진 카드들을 숫자 순서대로 정렬한 배열.
    private var sortedCards: [Card]
    // 숫자별 빈도 테이블.
    private var numberFrequencies: [Number:Int]
    // 모양별 빈도 테이블.
    private var shapeFrequencies: [Shape:Int]
    init(_ sortedCards: [Card]) {
        self.sortedCards = sortedCards
        self.numberFrequencies = [:]
        self.shapeFrequencies = [:]
        // 정렬된 카드들의 숫자, 모양 빈도 테이블 생성.
        makeFrequecyTables()
    }

    // 스택 내 카드들의 숫자별, 모양별 빈도 테이블 생성.
    private func makeFrequecyTables() {
        for card in self.sortedCards {
            // 특정 카드의 숫자, 모양.
            let currCard = card.info
            self.numberFrequencies.updateTable(forKey: currCard.number)
            self.shapeFrequencies.updateTable(forKey: currCard.shape)
        }
    }

    // 카드스택의 숫자 빈도를 통해 가지고 있는 패 리스트 반환.
    private func searchEqualNumberHands(of needCount: Int, for currHandKey: String) -> [HandRanks] {
        var owningHands: [HandRanks] = []
        // needCount 개수만큼의 빈도가 있는지 확인.
        for frequency in self.numberFrequencies.values where frequency == needCount {
            // 같은 숫자의 카드가 needCount와 같으면 해당 패를 추가. (개수 세기 위함)
            guard let currHand = HandRanks(rawValue: currHandKey) else { continue }
            owningHands.append(currHand)
        }
        return owningHands
    }

    // 카드스택의 모양 빈도를 통해 가지고 있는 패 리스트 반환.
    private func searchEqualShapeHands(of needCount: Int, for currHandKey: String) -> [HandRanks] {
        var owningHands: [HandRanks] = []
        for frequency in self.shapeFrequencies.values where frequency >= needCount {
            // 같은 모양의 카드가 needCount 이상 있으면 해당 패를 추가. (개수 세기 위함)
            guard let currHand = HandRanks(rawValue: currHandKey) else { continue }
            owningHands.append(currHand)
        }
        return owningHands
    }

    // 카드스택 내 연속숫자의 유무 확인.
    private func hasContinousNumbers(in numbers: Dictionary<Number, Int>.Keys, until needCount: Int) -> Bool {
        // 오름차순으로 정렬.
        let sortedNumbers = numbers.sorted(by: <)
        // 현재 원소(curr)와 다음 원소(next)를 비교하면서 연속숫자 판단.
        let continued = howManyContinues(in: sortedNumbers, needCount)
        // 기록한 연속카운트가 요구카운트보다 같거나 크면 true 반환.
        if continued >= needCount-1 { return true }
        // 아니면 false 반환.
        return false
    }

    // 배열의 원소가 연속되는 카운트 반환.
    private func howManyContinues<Type: ExtraComparable>(in data: [Type], _ needCount: Int) -> Int {
        var continuedCount = 0
        for (index, curr) in data.enumerated() {
            // 현재 원소의 인덱스가 마지막 원소의 인덱스보다 같거나 크면 종료.
            guard index < data.endIndex-1 else { print("break?"); break }
            // 다음 원소 정의.
            let next = data[data.index(after: index)]
            // 현재 원소와 다음 원소의 차이가 1이면 (<<는 Number.swift에 정의.)
            if curr << next {
                // 얼마나 연속됐는지 기록.
                continuedCount += 1
            } else {
                // 차이가 1이 아닌데, 요구되는 카운트보다 같거나 크면 for문 종료.
                guard continuedCount < needCount-1 else { break }
                // 아직 요구되는 카운트보다 작으면, 연속이 끊겼으므로 기록 초기화.
                continuedCount = 0
            }
        }
        return continuedCount
    }

    // 패는 4가지 종류로 나뉨.
    enum Hands: Equatable {
        case equalNumber(Int)               // 숫자가 Int개만큼 같은 패.
        case equalShape(Int)                // 모양이 Int개만큼 같은 패.
        case continousNumber(Int)           // 연속되는 숫자가 Int개만큼 있는 패.
        indirect case mixed(Hands, Hands)   // 두 가지 패가 섞여있는 패.

        // 같은 패인지 비교.
        static func == (lhs: PokerHands.Hands, rhs: PokerHands.Hands) -> Bool {
            // 케이스의 연관값끼리 비교.
            guard let lhsValue = getAssociatedValue(of: lhs) else { return false }
            guard let rhsValue = getAssociatedValue(of: rhs) else { return false }
            if lhsValue == rhsValue { return true }
            return false
        }

        // 케이스들의 연관값 반환.
        private static func getAssociatedValue(of thisHand: Hands) -> Int? {
            switch thisHand {
            case .equalNumber(let count): return count
            case .equalShape(let count): return count
            case .continousNumber(let count): return count
            case .mixed: return nil
            }
        }
    }

    // 지정 패의 종류.
    private let standardHands: [String:Hands] = [
        "onePair": Hands.equalNumber(2),
        "twoPair": Hands.mixed(Hands.equalNumber(2), Hands.equalNumber(2)),
        "triple": Hands.equalNumber(3),
        "straight": Hands.continousNumber(5),
        "flush": Hands.equalShape(5),
        "fullHouse": Hands.mixed(Hands.equalNumber(2), Hands.equalNumber(3)),
        "fourCard": Hands.equalNumber(4),
        "straightFlush": Hands.mixed(Hands.continousNumber(5), Hands.equalShape(5))
    ]

    // 한 플레이어가 가진 카드스택에 해당하는 모든 패 찾기.
    private func findHands() -> [HandRanks] {
        var owningHands: [HandRanks] = []
        // 해당되는 모든 패를 찾아서 반환.
        owningHands.append(contentsOf: findSingleHands())
        owningHands.append(contentsOf: findMixedHands(in: owningHands))
        return owningHands
    }

    // 1개로 구성된 패 검색.
    private func findSingleHands() -> [HandRanks] {
        var singleHands: [HandRanks] = []
        // 지정 패를 돌면서 해당되는 패를 모두 저장.
        for (key, value) in self.standardHands {
            switch value {
            case .equalNumber(let needCount):
                singleHands.append(contentsOf: searchEqualNumberHands(of: needCount, for: key))
            case .equalShape(let needCount):
                singleHands.append(contentsOf: searchEqualShapeHands(of: needCount, for: key))
            case .continousNumber(let needCount):
                guard hasContinousNumbers(in: self.numberFrequencies.keys, until: needCount) else { break }
                guard let currHand = HandRanks(rawValue: key) else { break }
                singleHands.append(currHand)
            default: break
            }
        }
        return singleHands
    }

    // 2개로 구성된 패 검색.
    private func findMixedHands(in owningHands: [HandRanks]) -> [HandRanks] {
        // 갖고 있는 패가 2개 미만일 시 함수 종료.
        guard owningHands.count >= 2 else { return [] }
        // 갖고 있는 패(HandRanks)를 패 타입(Hands)으로 변환.
        let ownHandTypes = owningHands.flatMap({ self.standardHands[$0.rawValue] })
        var mixedHands: [HandRanks] = []
        // 지정 패를 돌면서 해당되는 패를 모두 저장.
        for (key, value) in self.standardHands {
            switch value {
            case .mixed(let needHand1, let needHand2):
                // 필요패를 모두 포함하면
                if hasAllHandsInMixedCase(in: ownHandTypes, needHand1, needHand2) {
                    // 현재 패를 저장.
                    guard let currHand = HandRanks(rawValue: key) else { break }
                    mixedHands.append(currHand)
                }
            default: break
            }
        }
        return mixedHands
    }

    // 믹스패가 요구하는 모든 패를 가지고 있는지 확인.
    private func hasAllHandsInMixedCase(in ownHands: [Hands], _ needHand1: Hands, _ needHand2: Hands) -> Bool {
        // 필요한 패를 모두 포함하는지 확인하는 변수.
        var equalCount = 0
        // 필요 패가 같은 패인 경우.
        if needHand1 == needHand2 {
            // 아무 필요 패와 비교하여 같으면 카운트 +1 (갯수가 중요)
            _ = ownHands.map({
                if $0 == needHand1 {
                    equalCount += 1
                }
            })
        } else {
            // 필요 패가 같은 패가 아니면, 소유한 패가 필요 패를 모두 포함하는 지 확인.
            if ownHands.contains(needHand1) && ownHands.contains(needHand2) {
                equalCount = 2
            }
        }
        // 필요패를 모두 포함하면
        return (equalCount >= 2)
    }

    // 플레이어의 가장 좋은 패 찾기.
    func findBestHand() -> HandRanks {
        // 가지고 있는 모든 패.
        let allHands = findHands()
        // 모든 패 중 가장 높은 패를 저장.
        let lastHand = allHands.sorted { $0 < $1 }.last
        // 패가 하나도 없는 경우, noPair 전달.
        guard let bestHand = lastHand else { return HandRanks.noPair }
        return bestHand
    }

    // 패의 종류와 순위(랭크).
    enum HandRanks: String, Comparable {
        case noPair
        case onePair
        case twoPair
        case triple
        case straight
        case flush
        case fullHouse
        case fourCard
        case straightFlush

        // 패의 랭크. hashValue 사용.
        var rank: Int {
            return self.hashValue
        }

        // 패의 랭크 비교.
        static func < (lhs: PokerHands.HandRanks, rhs: PokerHands.HandRanks) -> Bool {
            guard lhs.rank < rhs.rank else { return false }
            return true
        }
    }

}
