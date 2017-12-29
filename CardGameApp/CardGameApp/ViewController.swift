//
//  ViewController.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 21..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Object Properties

    var cardDeck = CardDeck()
    var remainShowCards = [Card]()
    lazy var remainBackCards: [Card] = { [unowned self] in
        return cardDeck.cards
    }()

    lazy var cardStacks: [CardStack] = { [unowned self] in
        return makeCardStack()
    }()

    // MARK: View Properties

    // 상단 비어 있는 뷰
    lazy var emptyViews: [UIView] = { [unowned self] in
        var views = [UIView]()
        for _ in 0...3 {
            let emptyView = UIView()
            emptyView.layer.borderWidth = 1
            emptyView.layer.borderColor = UIColor.white.cgColor
            views.append(emptyView)
        }
        return views
    }()

    // 상단 맨 오른쪽 남은 카드들
    lazy var remainBackCardsView: UIView = { [unowned self] in
        var view = UIView()
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.remainCardsViewDidTap(_:))
        )
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var remainShowCardsView = UIView()
//    lazy var backCardImageView: UIImageView = { [unowned self] in
//        let card = try? pickCards(number: 1)
//        let image = card?.first?.makeBackImage()
//        return UIImageView(image: image)
//    }()

    // 카드 스택이 들어 있는 뷰
    lazy var cardStackViews: [CardStackView] = { [unowned self] in
        var cardStackViews = [CardStackView]()
        cardStacks.forEach { (cardStack: CardStack) in
            var cardStackView = CardStackView()
            cardStackView.setCardStack(cardStack)
            cardStackViews.append(cardStackView)
        }
        return cardStackViews
    }()

    lazy var cardImageViews: [UIImageView] = { [unowned self] in
        guard let cards = try? pickCards(number: 7) else {
            return []
        }
        return makeRandomCardImageViews(cards: cards)
    }()

    // MARK: Override...

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGroundImage()
        setUIViewLayout()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            do {
                let cards = try pickCards(number: 7)
                cardImageViews.forEach {$0.removeFromSuperview()}
                cardImageViews = makeRandomCardImageViews(cards: cards)
                //setCardViewLayout()
            } catch let error {
                showAlert(message: error.localizedDescription)
            }
        }
    }

    // MARK: Events...
    @objc func remainCardsViewDidTap(_ recognizer: UITapGestureRecognizer) {
        print("remainCardsViewDidTap")
    }

    // MARK: Methods...

    private func makeBackGroundImage() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor.init(patternImage: patternImage)
    }

    // 카드 스택 초기화
    private func makeCardStack() -> [CardStack] {
        // 카드를 섞는다.
        cardDeck.shuffle()
        var newCardStacks = [CardStack]()
        for i in 1...7 {
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

    private func pickCards(number: Int) throws -> [Card] {
        cardDeck.shuffle()
        do {
            let cards = try cardDeck.pickCards(number: number)
            return cards
        } catch let error {
            throw error
        }
    }

    private func makeRandomCardImages(_ cards: [Card]) -> [UIImage] {
        var images = [UIImage]()
        cards.forEach { images.append($0.makeImage()) }
        return images
    }

    private func makeRandomCardImageViews(cards: [Card]) -> [UIImageView] {
        var imageViews = [UIImageView]()
        let images = makeRandomCardImages(cards)
        images.forEach {imageViews.append(UIImageView(image: $0))}
        return imageViews
    }

    private func setUIViewLayout() {
        setEmptyViewLayout()
        setRemainBackCardsViewLayout()
        setCardStackViewLayout()
    }

    private func setEmptyViewLayout() {
        for i in 0..<emptyViews.count {
            self.view.addSubview(emptyViews[i])
            emptyViews[i].setRatio()
            emptyViews[i].top(equal: self.view)
            if i==0 {
                emptyViews[i].leading(equal: self.view.leadingAnchor, constant: 3)
            } else {
                emptyViews[i].leading(equal: emptyViews[i-1].trailingAnchor, constant: 3)
            }
            emptyViews[i].width(constant: 55)
        }
    }

    private func setCardStackViewLayout() {
        let widthOfCard = (self.view.frame.width - 24) / 7
        for i in 0..<cardStackViews.count {
            // horizontal
            for j in 0..<cardStackViews[i].cardStackImageViews.count {
                // vertical
                view.addSubview(cardStackViews[i].cardStackImageViews[j])
                cardStackViews[i].cardStackImageViews[j].setRatio()
                cardStackViews[i].cardStackImageViews[j].top(equal: view, constant: 100 + CGFloat(j) * 30)
                if i==0 {
                     cardStackViews[i].cardStackImageViews[j].leading(equal: view.leadingAnchor, constant: 3)
                } else {
                    cardStackViews[i].cardStackImageViews[j].leading(
                        equal: cardStackViews[i-1].cardStackImageViews[0].trailingAnchor,
                        constant: 3)
                }
                cardStackViews[i].cardStackImageViews[j].width(constant: widthOfCard)
            }
        }
    }

    private func setRemainBackCardsViewLayout() {
        self.view.addSubview(remainBackCardsView)
        remainBackCardsView.setRatio()
        remainBackCardsView.top(equal: self.view)
        remainBackCardsView.trailing(equal: self.view.trailingAnchor, constant: -3)
        remainBackCardsView.width(constant: 55)
    }

    private func showAlert(title: String = "잠깐!", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
