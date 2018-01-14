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

    @IBOutlet var cardDummyView: CardDummyView!
    @IBOutlet var showCardView: UIView!
    @IBOutlet var backCardView: UIImageView!
    @IBOutlet var cardStackDummyView: CardStackDummyView!

    var cardStackVM = CardStackViewModel()

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
        cardStackDummyView.layoutSubviews()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resetData()
        }
    }
}

extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27

        topCardStacks = makeTopCardStacks()
        remainBackCards = cardStackVM.remainCards

        // View Init
        initAndLayoutCardStackView()
        initBackCardView()
    }

    // Reset Properties
    private func resetData() {
        cardStackVM = CardStackViewModel()
        topCardStacks.removeAll()
        topCardStacks = makeTopCardStacks()
        remainBackCards = cardStackVM.remainCards
        remainShowCards.removeAll()
    }

    // Make Objects
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
        let frame = CGRect(x: 0, y: 0, width: Size.cardWidth, height: cardStackDummyView.frame.height)
        let action = Action(target: self, selector: #selector(self.cardStackViewDidDoubleTap(_:)))
        let myCardStackViews = cardStackVM.makeCardStackView(frame: frame, action: action)
        cardStackDummyView.setCardStackDummyView(myCardStackViews)
}

    fileprivate func initBackCardView() {
        backCardView.image = Image.backImage
        backCardView.addTapGesture(
            self,
            action: #selector(self.remainCardsViewDidTap(_:))
        )
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
            showCardView.subviews.last?.fitLayout(with: showCardView)
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
}

// MARK: Events

extension ViewController {
    @objc func cardStackViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        print("cardStackViewDidDoubleTap")
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
