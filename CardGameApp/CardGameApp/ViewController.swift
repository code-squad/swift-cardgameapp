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
    var cardStacks = [CardStack]()
    var remainBackCards = [Card]()
    var remainShowCards = [Card]()

    // MARK: View Properties

    // 상단 비어 있는 뷰
    lazy var emptyViews: [UIView] = { [unowned self] in
        var views = [UIView]()
        for _ in 1...4 { views.append(UIView().makeEmptyView()) }
        return views
    }()

    // 비어있는 스택 뷰 셋팅
    lazy var emptyStackViews: [UIView] = { [unowned self] in
        var views = [UIView]()
        for _ in 1...7 { views.append(UIView())}
        return views
    }()

    // 카드가 들어있는 스택 뷰
    var cardStackViews = [CardStackView]()

    var showCardView = UIImageView()
    var backCardView = UIImageView()

    // MARK: Override...

    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 초기화
        setDatas()
        // 뷰 초기화
        setViews()
        // 배경 초기화
        setBackGroundImage()
        setUIViewLayout()
    }

    // MARK: Events...

    var backCardViewState: State = .normal
    enum State {
        case refresh
        case normal
    }
    @objc func remainCardsViewDidTap(_ recognizer: UITapGestureRecognizer) {
        switch backCardViewState {
        case .refresh:
            remainBackCards.append(contentsOf: remainShowCards)
            remainShowCards.removeAll(keepingCapacity: false)
            showCardView.image = UIImage()
            guard let backCard = remainBackCards.last else {
                return
            }
            backCardView.image = backCard.makeBackImage()
            backCardViewState = .normal
        case .normal:
            let card = remainBackCards.removeLast()
            remainShowCards.append(card)
            if remainBackCards.count == 0 {
                backCardViewState = .refresh
                let image = UIImage(named: "cardgameapp-refresh-app")
                backCardView.image = image
            } else {
                guard let backCard = remainBackCards.last else {
                    return
                }
                backCardView.image = backCard.makeBackImage()
            }
            showCardView.image = card.makeImage()
        }
    }
}

// MARK: Data Initialize Methods
extension ViewController {
    private func setDatas() {
        // 카드 스택을 할당.
        cardStacks = makeCardStack()
        // 카드 스택에 할당하고 남은 카드
        remainBackCards = cardDeck.cards
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
}

// MARK: View Initialize Methods
extension ViewController {
    private func setViews() {
        cardStackViews = makeCardStackView()
        backCardView = makeBackCardView()
    }

    private func makeCardStackView() -> [CardStackView] {
        var cardStackViews = [CardStackView]()
        let widthOfCard = (self.view.frame.width - 24) / 7
        let heightOfView = self.view.frame.height
        cardStacks.forEach { (cardStack: CardStack) in
            let cardStackView = CardStackView(
                frame: CGRect(x: 0, y: 0, width: widthOfCard, height: heightOfView - 100)
            )
            cardStackView.setCardStack(cardStack)
            cardStackViews.append(cardStackView)
        }
        return cardStackViews
    }

    private func makeBackCardView() -> UIImageView {
        guard let pickedCard = cardDeck.top else {
            return UIImageView()
        }
        let view = UIImageView(image: pickedCard.makeBackImage())
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.remainCardsViewDidTap(_:))
        )
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }
}
 // MARK: Methods...
extension ViewController {
    private func setBackGroundImage() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor.init(patternImage: patternImage)
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

// MARK: Draw
extension ViewController {
    private func setUIViewLayout() {
        setEmptyViewLayout()
        setBackCardViewLayout()
        setEmptyStackViewsLayout()
        setCardStackViewLayout()
        setShowCardViewLayout()
    }

    // 왼쪽 상단 비어있는 네 개의 뷰
    private func setEmptyViewLayout() {
        self.view.setGridLayout(emptyViews)
    }

    // 비어있는 카드 스택 뷰
    private func setEmptyStackViewsLayout() {
        self.view.setGridLayout(emptyStackViews, top: 100)
    }

    // 카드가 쌓인 카드 스택 뷰
    private func setCardStackViewLayout() {
        emptyStackViews.forEach { (stackview: UIView) in
            let i = emptyStackViews.index(of: stackview) ?? emptyStackViews.endIndex
            stackview.addSubview(cardStackViews[i])
            cardStackViews[i].setCardStackViewLayout()
        }
    }

    private func setBackCardViewLayout() {
        let widthOfCard = (self.view.frame.width - 24) / 7
        self.view.addSubview(backCardView)
        backCardView.setRatio()
        backCardView.top(equal: self.view)
        backCardView.trailing(equal: self.view.trailingAnchor, constant: -3)
        backCardView.width(constant: widthOfCard)
    }

    // 남은 카드들을 올려 놓는 곳
    private func setShowCardViewLayout() {
        let widthOfCard = (self.view.frame.width - 24) / 7
        let halfOfWidth = widthOfCard / 2
        self.view.addSubview(showCardView)
        showCardView.setRatio()
        showCardView.top(equal: self.view)
        showCardView.trailing(equal: backCardView.leadingAnchor, constant: -(halfOfWidth + 3))
        showCardView.width(constant: widthOfCard)
    }
}
