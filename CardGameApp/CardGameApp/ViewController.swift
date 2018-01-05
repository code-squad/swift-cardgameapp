//
//  ViewController.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 21..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Layout Size
    struct Size {
        static let constant: CGFloat = 3
        static let cardStackCount: Int = 7
        static var cardWidth: CGFloat = 0
        static var cardHeight: CGFloat = 0
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    }

    // MARK: Properties
    var cardDeck = CardDeck()
    var cardStacks = [CardStack]()
    var remainBackCards = [Card]()
    var remainShowCards: [Card] = [] {
        willSet(newVal) {
            changeShowCardView(newVal)
        }
    }

    // MARK: Views

    var cardStackViews = [CardStackView]()
    var showCardView = UIImageView()
    var backCardView: BackCardView!
    var emptyTopViews: CardDeckView!
    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()
        initProperties()
        initBackGroundImage()

        self.view.addSubview(emptyTopViews)

        cardStackViews.forEach {
            self.view.addSubview($0)
            $0.setLayout()
        }

        self.view.addSubview(backCardView)

        let halfOfCardWidth = Size.cardWidth / 2
        self.view.addSubview(showCardView)
        showCardView.setRatio()
        showCardView.top(equal: self.view)
        showCardView.trailing(
            equal:backCardView.leadingAnchor,
            constant: -(halfOfCardWidth + Size.constant)
        )
        showCardView.width(constant: Size.cardWidth)
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resetData()
            resetCardStackView()
        }
    }

}
// MARK: Initialize, Make Object
extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27
        // 카드 스택을 할당.
        cardStacks = makeCardStack()
        // 카드 스택에 할당하고 남은 카드
        remainBackCards = cardDeck.cards
        cardStackViews = makeCardStackView()
        emptyTopViews = CardDeckView(
            frame: CGRect(
                x: Size.constant,
                y: Size.statusBarHeight,
                width: Size.cardWidth * 4 + Size.constant * 4,
                height: Size.cardHeight
            )
        )
        emptyTopViews.setLayout()
        backCardView = BackCardView(
            frame: CGRect(
                x: Size.constant*7 + Size.cardWidth*6,
                y: Size.statusBarHeight,
                width: Size.cardWidth,
                height: Size.cardHeight
            )
        )
        backCardView.addGesture(self, action: #selector(self.remainCardsViewDidTap(_:)))
    }

    private func resetData() {
        self.cardDeck = CardDeck()
        cardStacks = makeCardStack()
        remainBackCards = cardDeck.cards
        remainShowCards.removeAll()
        backCardView.state = .normal
    }

    private func makeCardStack() -> [CardStack] {
        // 카드를 섞는다.
        cardDeck.shuffle()
        var newCardStacks = [CardStack]()
        for i in 1...Size.cardStackCount {
            // 카드를 i개 뽑는다.
            var cardStack = CardStack()
            guard let cards = try? cardDeck.pickCards(number: i) else {
                continue
            }
            // i 개의 카드를 카드 스택에 푸시한다.
            for j in 1...i {
                cardStack.push(card: cards[j-1])
            }
            newCardStacks.append(cardStack)
        }
        return newCardStacks
    }

    private func resetCardStackView() {
        var copyCardStacks = self.cardStacks
        cardStackViews.forEach { $0.changeImages(copyCardStacks.removeFirst()) }
    }

    private func makeCardStackView() -> [CardStackView] {
        var cardStackViews = [CardStackView]()
        let heightOfView = self.view.frame.height
        var i: CGFloat = 0
        cardStacks.forEach {
            let cardStackView = CardStackView(
                frame: CGRect(
                    x: Size.constant * (i+1) + Size.cardWidth * i,
                    y: Size.statusBarHeight + Size.cardHeight + 10,
                    width: Size.cardWidth,
                    height: heightOfView - 100)
            )
            cardStackView.makeCardStackImageView($0)
            cardStackViews.append(cardStackView)
            i += 1
        }
        return cardStackViews
    }

}

// MARK: Events

extension ViewController {

    /*
     UIGestureRecognizer의 action을 지정하기 위해서는 Selector를 사용해야 하는데,
     Selector는 Objective-C의 라이브러리이다. swift파일의 함수를 Objective-C파일에서 접근하기 위해서는
     @objc를 명시해야 한다.
     */
    @objc func remainCardsViewDidTap(_ recognizer: UITapGestureRecognizer) {
        switch backCardView.state {
        case .refresh:
            // refresh 이미지 일 때, back card는 show card에 있는 카드를 모두 가져온다.
            refreshRamainCardView()
        case .normal:
            let card = remainBackCards.removeLast()
            remainShowCards.append(card)
            changeBackCardView()
        }
    }
}

 // MARK: Methods
extension ViewController {
    private func initBackGroundImage() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor.init(patternImage: patternImage)
    }

    private func refreshRamainCardView() {
        remainBackCards.append(contentsOf: remainShowCards)
        remainShowCards.removeAll(keepingCapacity: false)
    }

    private func changeShowCardView(_ cards: [Card]) {
        guard let card = cards.last else {
            // show 카드를 비웠을 때, show 카드는 빈 view image이다.
            showCardView.image = nil
            backCardView.state = .normal
            return
        }
        showCardView.image = card.makeImage()
    }

    private func changeBackCardView() {
        // back 카드가 하나도 없다면, refresh 이미지로 바꿔준다.
        if remainBackCards.count == 0 {
            backCardView.state = .refresh
        }
    }

}
