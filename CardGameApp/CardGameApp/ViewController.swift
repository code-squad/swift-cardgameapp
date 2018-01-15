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
    var cardDummyVM = CardDummyViewModel()
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
        cardStackDummyView.delegate = self
        initProperties()
        initViews()
        initBackGroundImage()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardStackVM.reset()
            cardDummyVM.reset()
            remainBackCards = cardStackVM.remainCards
            remainShowCards.removeAll()
            cardDummyView.removeAllCardDummy()
            cardStackDummyView.removeCardStackDummyView()
            cardStackDummyView.setCardStackDummyView(cardStackVM.cardStacks)
        }
    }
}

extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27
        remainBackCards = cardStackVM.remainCards
    }

    private func initViews() {
        cardStackDummyView.setCardStackDummyView(cardStackVM.cardStacks)
        initBackCardView()
    }

    // Initialize Views

    private func initBackGroundImage() {
        view.backgroundColor = UIColor.init(patternImage: Image.bgImage)
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

}

// MARK: Events

extension ViewController: CardStackDummyViewDelegate {
    fileprivate func move(tappedView: UIView, from stackDummyIndex: Int, to dummyIndex: Int) {
        let popCard = self.cardStackVM.pop(cardStackIndex: stackDummyIndex)!
        self.cardDummyVM.push(index: dummyIndex, card: popCard)
        let topCard = self.cardStackVM.top(cardStackIndex: stackDummyIndex)
        tappedView.removeFromSuperview()
        self.cardStackDummyView.pop(index: stackDummyIndex, previousCard: topCard)
        self.cardDummyView.push(index: dummyIndex, cardView: tappedView)
    }

    func cardViewDidDoubleTap(tappedView: UIView, cardStackIdx: Int, origin: CGPoint) {
        let constant: CGFloat = 7.5
        guard let selectedCard = cardStackVM.top(cardStackIndex: cardStackIdx) else { return }
        if let indexTopView = cardDummyVM.selectTargetTopViewIndex(card: selectedCard) {
            var topViewPos = cardDummyView.position(index: indexTopView)
            topViewPos.x += cardStackDummyView.frame.origin.x
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    tappedView.frame.origin.x = -origin.x
                    tappedView.frame.origin.x += topViewPos.x
                    tappedView.frame.origin.y = -(constant + Size.cardHeight)
            },
                completion: { _ in
                    self.move(tappedView: tappedView, from: cardStackIdx, to: indexTopView)
            })
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
