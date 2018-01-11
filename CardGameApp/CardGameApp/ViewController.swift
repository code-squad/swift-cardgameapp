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

    @IBOutlet var topCardViews: [UIView]!
    @IBOutlet var showCardView: UIView!
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

    struct Image {
        static let refreshImage = UIImage(named: "cardgameapp-refresh-app")!
        static let backImage = UIImage(named: "card-back")!
        static let bgImage = UIImage(named: "bg_pattern")!
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
            retsetTopViews()
        }
    }
}

extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27
        cardStacks = makeCardStack()
        topCardStacks = makeTopCardStacks()
        remainBackCards = cardDeck.cards

        // View Init
        initAndLayoutCardStackView()
        initBackCardView()
        initTopCardViews()
    }

    // Reset Properties
    private func resetData() {
        self.cardDeck = CardDeck()
        cardStacks = makeCardStack()
        topCardStacks.removeAll()
        topCardStacks = makeTopCardStacks()
        remainBackCards = cardDeck.cards
        remainShowCards.removeAll()
    }

    private func resetCardStackView() {
        var copyCardStacks = self.cardStacks
        cardStackViews.forEach {
            guard let cardStackView = $0.subviews.first as? CardStackView else {
                return
            }
            let cardStack = copyCardStacks.removeFirst()
            cardStackView.resetCardStackImageView(cardStack)
            cardStackView.addDoubleTapGesture(
                self,
                action: #selector(self.cardStackViewDidDoubleTap(_:))
            )
        }
    }

    private func retsetTopViews() {
        topCardViews.forEach { (cardView: UIView) in
            cardView.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }

    // Make Objects

    private func makeCardStackView() -> [CardStackView] {
        var cardStackViews = [CardStackView]()
        let heightOfView = self.view.frame.height
        var i: CGFloat = 0
        cardStacks.forEach {
            let cardStackView = CardStackView(
                frame: CGRect(x: 0, y: 0, width: Size.cardWidth, height: heightOfView - 100)
            )
            cardStackView.setCardStackImageView($0)
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

    private func makeTopCardStacks() -> [CardStack] {
        let cardStacks = [CardStack?](repeating: nil, count: 4)
        let newCardStacks = cardStacks.map { _ in return CardStack()}
        return newCardStacks
    }
    // Initialize Views

    private func initBackGroundImage() {
        view.backgroundColor = UIColor.init(patternImage: Image.bgImage)
    }

    fileprivate func initAndLayoutCardStackView() {
        var myCardStackViews = makeCardStackView()
        cardStackViews.forEach {
            $0.backgroundColor = UIColor.clear
            let stackView = myCardStackViews.removeFirst()
            stackView.addDoubleTapGesture(self, action: #selector(self.cardStackViewDidDoubleTap(_:)))
            $0.addSubview(stackView)
        }
    }

    fileprivate func initBackCardView() {
        backCardView.image = Image.backImage
        backCardView.addTapGesture(
            self,
            action: #selector(self.remainCardsViewDidTap(_:))
        )
    }

    fileprivate func initTopCardViews() {
        topCardViews.forEach {
            $0.makeEmptyView()
        }
    }

    // Change Views
    private func changeRemainBackCardView(cards: [Card]) {
        if cards.isEmpty {
            backCardView.image = Image.refreshImage
        } else {
            backCardView.image = Image.backImage
        }
    }

    private func changeRemainShowCardView(cards: [Card]) {
        if cards.isEmpty {
            showCardView.subviews.forEach { $0.removeFromSuperview() }
        } else {
            guard let lastCard = cards.last else {
                return
            }
            showCardView.addSubview(UIImageView(image: lastCard.makeImage()))
            showCardView.subviews.last?.setRatio()
            showCardView.subviews.last?.top(equal: showCardView)
            showCardView.subviews.last?.leading(equal: showCardView.leadingAnchor)
            showCardView.subviews.last?.trailing(equal: showCardView.trailingAnchor)
            showCardView.width(equal: showCardView.widthAnchor)
        }
    }

    // get view position

    // x좌표를 갖고 현재 위치가 몇번 째 카드 스택에 속하는지 인덱스 반환.
    private func selectCurrentIndexOfCardStack(pointX: CGFloat) -> Int {
        for i in 0..<7 {
            let cgfloatI = CGFloat(i)
            let minX = Size.constant * (cgfloatI + 1) + Size.cardWidth * (cgfloatI)
            let maxX = Size.constant * (cgfloatI + 1) + Size.cardWidth * (cgfloatI + 1)
            if pointX >= minX && pointX <= maxX { return i }
        }
        return 0
    }

    // Top View로 이동 시, 카드가 이동할 Top View 인덱스를 반환
    private func selectTargetTopViewIndex(card: Card) -> Int? {
        for index in 0..<topCardStacks.count {
            let top = topCardStacks[index].top
            if card.isSameSuitAndNextRank(with: top) {
                return index
            }
        }
        return nil
    }

    // card Stack View로 이동 시, 카드가 이동할 card stack view 인덱스를 반환
    private func selectTargetCardStackViewIndex(card: Card) -> Int? {
        for index in 0..<cardStacks.count {
            let top = cardStacks[index].top
            if card.isDifferentColorAndPreviousRank(with: top) {
                return index
            }
        }
        return nil
    }
}

// MARK: Events

extension ViewController {
    @objc func cardStackViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        let currentLocation = sender.location(in: self.view)
        let indexTapped = selectCurrentIndexOfCardStack(pointX: currentLocation.x)
        guard let selectedImageView = sender.view as? UIImageView,
            let selectedCardStackView = selectedImageView.superview as? CardStackView,
            let backgroundView = selectedCardStackView.superview,
            let selectedCard = cardStacks[indexTapped].top else {
                return
        }
        let originalPos = backgroundView.frame.origin

        if let indexTopView = selectTargetTopViewIndex(card: selectedCard) {
            let topViewPos = topCardViews[indexTopView].frame.origin
            selectedImageView.willMove(
                from: originalPos,
                to: topViewPos,
                action: { _ in
                    self.cardStacks[indexTapped].pop()
                    self.topCardStacks[indexTopView].push(card: selectedCard)
                    let topCard = self.cardStacks[indexTapped].top
                    selectedImageView.removeFromSuperview()
                    selectedCardStackView.popCardStackView(previousCard: topCard)
                    self.topCardViews[indexTopView].addSubview(selectedImageView)
                    selectedImageView.fitLayout(with: self.topCardViews[indexTopView])
                    selectedImageView.isUserInteractionEnabled = false
                    self.viewWillLayoutSubviews()
            })
        } else if let indexCardStack = selectTargetCardStackViewIndex(card: selectedCard) {
            self.view.bringSubview(toFront: selectedImageView)
            var cardStackViewPos = cardStackViews[indexCardStack].frame.origin
            cardStackViewPos.y += ( 30 * CGFloat(cardStacks[indexCardStack].count) )

            selectedImageView.willMove(
                from: originalPos,
                to: cardStackViewPos,
                action: { _ in
                    self.cardStacks[indexTapped].pop()
                    self.cardStacks[indexCardStack].push(card: selectedCard)
                    let topCard = self.cardStacks[indexTapped].top
                    selectedImageView.removeFromSuperview()
                    selectedCardStackView.popCardStackView(previousCard: topCard)
                    // 목적지
                    if let targetCardStackView = self.cardStackViews[indexCardStack]
                        .subviews
                        .first as? CardStackView {
                        targetCardStackView.pushCardStackView(selectedImageView)
                    }
                    self.viewWillLayoutSubviews() }
            )
        }
    }

    @objc func remainCardsViewDidTap(_ recognizer: UITapGestureRecognizer) {
        guard let imageView = recognizer.view as? UIImageView,
            let cardImage = imageView.image else {
                return
        }
        switch cardImage {
        case Image.refreshImage:
            remainBackCards.append(contentsOf: remainShowCards)
            remainShowCards.removeAll(keepingCapacity: false)
        case Image.backImage:
            // 카드를 꺼낸다.
            let card = remainBackCards.removeLast()
            remainShowCards.append(card)
        default: break
        }

    }
}
