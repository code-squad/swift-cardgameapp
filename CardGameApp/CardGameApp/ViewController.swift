//
//  ViewController.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 21..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties...
    var cardDeck = CardDeck()
    lazy var cardStacks: [CardStack] = { [unowned self] in
        return makeCardStack()
    }()

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

    lazy var backCardImageView: UIImageView = { [unowned self] in
        let card = try? pickCards(number: 1)
        let image = card?.first?.makeBackImage()
        return UIImageView(image: image)
    }()

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
        setBackCardViewLayout()
        setCardViewLayout()
        //setCardStackViewLayout()
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

    private func setCardViewLayout() {
        let widthOfCard = (self.view.frame.width - 24) / 7
        for i in 0..<cardStackViews.count {
            self.view.addSubview(cardStackViews[i])
            let ratioOfCardToView = CGFloat( 0.05 * Double(i) )
            cardStackViews[i].top(equal: self.view, constant: 150)
            if i==0 {
                cardStackViews[i].leading(equal: self.view.leadingAnchor, constant: 3)
            } else {
                cardStackViews[i].leading(equal: cardStackViews[i-1].trailingAnchor, constant: 3)
            }
            cardStackViews[i].width(constant: widthOfCard)

            cardStackViews[i].height(equal: self.view, multiplier: ratioOfCardToView)
        }
    }

    private func setBackCardViewLayout() {
        self.view.addSubview(backCardImageView)
        backCardImageView.setRatio()
        backCardImageView.top(equal: self.view)
        backCardImageView.trailing(equal: self.view.trailingAnchor, constant: -3)
        backCardImageView.width(constant: 55)
    }

    private func showAlert(title: String = "잠깐!", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action: UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)

        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

protocol CardViewLayoutProtocol {
    func setRatio()
}

extension UIView: CardViewLayoutProtocol {
    func setRatio() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
    }
}

extension UIView {
    func setAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func top(equal: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: equal.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
    }

    func leading(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func trailing(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func width(constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func height(equal: UIView, multiplier: CGFloat) {
        self.heightAnchor.constraint(equalTo: equal.heightAnchor, multiplier: multiplier).isActive = true
    }
}
