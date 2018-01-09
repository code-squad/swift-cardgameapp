//
//  ViewController.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 21..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var topCardsView: [UIImageView]!
    @IBOutlet var showCardView: UIImageView!
    @IBOutlet var backCardView: UIImageView!
    @IBOutlet var cardStackViews: [UIView]!

    var cardDeck = CardDeck()
    var cardStacks = [CardStack]()
    var topCardStacks = [CardStack]()
    var remainBackCards = [Card]() {
        willSet {
            changeRemainBackCardView(cards: newValue)
        }
    }
    var remainShowCards = [Card]() {
        willSet {
            changeRemainShowCardView(cards: newValue)
        }
    }
    struct Size {
        static let constant: CGFloat = 3
        static let cardStackCount: Int = 7
        static var cardWidth: CGFloat = 0
        static var cardHeight: CGFloat = 0
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initProperties()
        initBackGroundImage()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resetData()
            resetCardStackView()
        }
    }
}

extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27
        cardStacks = makeCardStack()
        for _ in 0...3 { topCardStacks.append(CardStack()) }
        remainBackCards = cardDeck.cards
        var myCardStackViews = makeCardStackView()
        myCardStackViews.forEach {
            $0.addDoubleTapGesture(self, action: #selector(self.cardStackViewDidDoubleTap(_:)))
        }
        cardStackViews.forEach {
            $0.backgroundColor = UIColor.clear
            let stackView = myCardStackViews.removeFirst()
            $0.addSubview(stackView)
            stackView.setLayout()
            self.view.addSubview($0)
        }
        backCardView.image = UIImage(named: "card-back")!
        backCardView.addTapGesture(
            self,
            action: #selector(self.remainCardsViewDidTap(_:))
        )
        topCardsView.forEach { $0.makeEmptyView() }
    }

    private func resetData() {
        self.cardDeck = CardDeck()
        cardStacks = makeCardStack()
        remainBackCards = cardDeck.cards
        remainShowCards.removeAll()
    }

    func getIndex(pointX: CGFloat) -> Int {
        for i in 0..<7 {
            let cgfloatI = CGFloat(i)
            let minX = Size.constant * (cgfloatI + 1) + Size.cardWidth * (cgfloatI)
            let maxX = Size.constant * (cgfloatI + 1) + Size.cardWidth * (cgfloatI + 1)
            if pointX >= minX && pointX <= maxX { return i }
        }
        return 0
    }

    func getIndexEmptyTopCardStack() -> Int {
        for i in 0..<topCardStacks.count where topCardStacks[i].isEmpty {
            print(i)
            return i
        }
        return 0
    }

    private func makeCardStackView() -> [CardStackView] {
        var cardStackViews = [CardStackView]()
        let heightOfView = self.view.frame.height
        var i: CGFloat = 0
        cardStacks.forEach {
            let cardStackView = CardStackView(
                frame: CGRect(x: 0, y: 0, width: Size.cardWidth, height: heightOfView - 100)
            )
            cardStackView.makeCardStackImageView($0)
            cardStackViews.append(cardStackView)
            i += 1
        }
        return cardStackViews
    }

    private func makeCardStack() -> [CardStack] {
        cardDeck.shuffle()
        var newCardStacks = [CardStack]()
        for i in 1...Size.cardStackCount {
            guard let cards = try? cardDeck.pickCards(number: i) else {
                continue
            }
            newCardStacks.append(CardStack(cards: cards))
        }
        return newCardStacks
    }

    private func initBackGroundImage() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor.init(patternImage: patternImage)
    }

    private func resetCardStackView() {
        var copyCardStacks = self.cardStacks
        cardStackViews.forEach { (view: UIView) in
            guard let cardStackView = view.subviews.first as? CardStackView else {
                return
            }
            let cardStack = copyCardStacks.removeFirst()
            cardStackView.changeImages(cardStack)
        }
    }

    func changeRemainBackCardView(cards: [Card]) {
        let refreshImage = UIImage(named: "cardgameapp-refresh-app")!
        let backImage = UIImage(named: "card-back")!
        if cards.isEmpty {
            backCardView.image = refreshImage
        } else {
            backCardView.image = backImage
        }
    }

    func changeRemainShowCardView(cards: [Card]) {
        if cards.isEmpty {
            showCardView.image = nil
        } else {
            guard let lastCard = cards.last else {
                return
            }
            showCardView.image = lastCard.makeImage()
        }
    }
}

extension ViewController {
    @objc func cardStackViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        let indexOfCardStacks = getIndex(pointX: location.x)
        guard let selectedView = sender.view as? UIImageView,
            let topCard = cardStacks[indexOfCardStacks].top else {
                return
        }
        if topCard.isAce {
            let indexEmptyTopCard = getIndexEmptyTopCardStack()
            let moveZero = cardStackViews[indexOfCardStacks].frame.origin
            let emptyViewPos = topCardsView[indexEmptyTopCard].frame.origin
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    selectedView.frame.origin.x = -moveZero.x
                    selectedView.frame.origin.x += emptyViewPos.x
                    selectedView.frame.origin.y = -moveZero.y
                    selectedView.frame.origin.y += emptyViewPos.y
            },
                completion: nil
            )
        }
    }

    @objc func remainCardsViewDidTap(_ recognizer: UITapGestureRecognizer) {
        let refreshImage = UIImage(named: "cardgameapp-refresh-app")!
        let backImage = UIImage(named: "card-back")!
        guard let imageView = recognizer.view as? UIImageView,
            let cardImage = imageView.image else {
                return
        }
        switch cardImage {
        case refreshImage:
            remainBackCards.append(contentsOf: remainShowCards)
            remainShowCards.removeAll(keepingCapacity: false)
        case backImage:
            // 카드를 꺼낸다.
            let card = remainBackCards.removeLast()
            remainShowCards.append(card)
        default: break
        }

    }
}
