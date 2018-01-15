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

    var stackDummyVM = CardStackDummyViewModel()
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
            stackDummyVM.reset()
            cardDummyVM.reset()
            remainBackCards = stackDummyVM.remainCards
            remainShowCards.removeAll()
            cardDummyView.removeAllCardDummy()
            cardStackDummyView.removeCardStackDummyView()
            cardStackDummyView.setCardStackDummyView(stackDummyVM.cardStacks)
        }
    }
}

extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27
        remainBackCards = stackDummyVM.remainCards
    }

    private func initViews() {
        cardStackDummyView.setCardStackDummyView(stackDummyVM.cardStacks)
        initBackCardView()
    }

    // Initialize Views

    private func initBackGroundImage() {
        view.backgroundColor = UIColor.init(patternImage: Image.bgImage)
    }

    fileprivate func initBackCardView() {
        backCardView.image = Image.backImage
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.remainCardsViewDidTap(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        backCardView.addGestureRecognizer(tapRecognizer)
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
            guard let subview = showCardView.subviews.last else { return }

            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.topAnchor.constraint(equalTo: showCardView.topAnchor).isActive = true
            subview.leadingAnchor.constraint(equalTo: showCardView.leadingAnchor).isActive = true
            subview.trailingAnchor.constraint(equalTo: showCardView.trailingAnchor).isActive = true
            subview.widthAnchor.constraint(equalTo: showCardView.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: subview.widthAnchor, multiplier: 1.27).isActive = true

        }
    }

}

// MARK: CardStackDummyViewDelegate

extension ViewController: CardStackDummyViewDelegate {
    fileprivate func move(start: StartInfo, target: TargetInfo, tappedView: UIView) {
        let selectedCard = start.viewModel.pop(index: start.index)!
        target.viewModel.push(index: target.index, card: selectedCard)
        let topCard = start.viewModel.top(index: start.index)
        tappedView.removeFromSuperview()
        start.view.pop(index: start.index, previousCard: topCard)
        target.view.push(index: target.index, cardView: tappedView)
    }

    func moveToCardStackDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, startIndex: Int) {
        guard let selectedCard = stackDummyVM.top(index: startIndex),
            cardDummyVM.targetIndex(card: selectedCard) == nil,
            let targetIndex = stackDummyVM.targetIndex(card: selectedCard) else {
                return
        }
        let moveOrigin = cardStackDummyView.movePoint(from: startIndex, to: targetIndex)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                tappedView.frame.origin.x += moveOrigin.x
                tappedView.frame.origin.y += moveOrigin.y
        },
            completion: { _ in
                let start = StartModel(view: cardStackDummyView, viewModel: self.stackDummyVM, index: startIndex)
                let target = TargetModel(view: cardStackDummyView, viewModel: self.stackDummyVM, index: targetIndex)
                self.move(start: start, target: target, tappedView: tappedView)}
        )
    }

    func moveToCardDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, startIndex: Int) {
        let constant: CGFloat = 7.5
        guard let selectedCard = stackDummyVM.top(index: startIndex),
            let targetIndex = cardDummyVM.targetIndex(card: selectedCard) else {
                return
        }
        let topViewPos = cardDummyView.position(index: targetIndex)
        let moveXPos = cardStackDummyView.moveX(from: 0, to: startIndex)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                tappedView.frame.origin.x = -moveXPos
                tappedView.frame.origin.x += topViewPos.x
                tappedView.frame.origin.y = -(constant + Size.cardHeight) },
            completion: { _ in
                let start = StartModel(view: cardStackDummyView, viewModel: self.stackDummyVM, index: startIndex)
                let target = TargetModel(view: self.cardDummyView, viewModel: self.cardDummyVM, index: targetIndex)
                self.move(start: start, target: target, tappedView: tappedView)
        })
    }
}

// MARK: Events
extension ViewController {
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
