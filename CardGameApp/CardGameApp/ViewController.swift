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
    lazy var widthOfCard: CGFloat = { [unowned self] in
        return (self.view.frame.width - 24) / 7
    }()
    var cardDeck = CardDeck()
    var cardStacks = [CardStack]()
    var remainBackCards = [Card]()
    var remainShowCards: [Card] = [] {
        willSet(newVal) {
            changeShowCardView(newVal)
        }
    }

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
    var backCard = BackCard()

    // MARK: Override...

    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 초기화
        setDatas()
        // 뷰 초기화
        setViews()
        // 배경 초기화
        setBackGroundImage()
        // 뷰 배치하기
        setUIViewLayout()
    }

}

// MARK: Events...

extension ViewController {
    @objc func remainCardsViewDidTap(_ recognizer: UITapGestureRecognizer) {
        switch backCard.state {
        case .refresh:
            // refresh 이미지 일 때, back card는 show card에 있는 카드를 모두 가져온다.
            remainBackCards.append(contentsOf: remainShowCards)
            remainShowCards.removeAll(keepingCapacity: false)
            backCard.view.image = backCard.backImage
        case .normal:
            let card = remainBackCards.removeLast()
            remainShowCards.append(card)
            changeBackCardView()
        }
    }
    private func changeShowCardView(_ cards: [Card]) {
        guard let card = cards.last else {
            // show 카드를 비웠을 때, show 카드는 빈 view image이다.
            showCardView.image = UIImage()
            backCard.state = .normal
            return
        }
        showCardView.image = card.makeImage()
    }

    private func changeBackCardView() {
        // back 카드가 하나도 없다면, refresh 이미지로 바꿔준다.
        if remainBackCards.count == 0 {
            backCard.state = .refresh
            backCard.view.image = backCard.refreshImage
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
        backCard.view = makeBackCardView()
    }

    private func makeCardStackView() -> [CardStackView] {
        var cardStackViews = [CardStackView]()
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
        let cardHeight = widthOfCard * 1.27
        self.view.setGridLayout(emptyStackViews, top: cardHeight + 10)
    }

    // 카드가 쌓인 카드 스택 뷰
    private func setCardStackViewLayout() {
        emptyStackViews.forEach { (stackview: UIView) in
            let i = emptyStackViews.index(of: stackview) ?? emptyStackViews.endIndex
            stackview.addSubview(cardStackViews[i])
            cardStackViews[i].setLayout()
        }
    }

    private func setBackCardViewLayout() {
        self.view.addSubview(backCard.view)
        backCard.view.setRatio()
        backCard.view.top(equal: self.view)
        backCard.view.trailing(equal: self.view.trailingAnchor, constant: -3)
        backCard.view.width(constant: widthOfCard)
    }

    // 남은 카드들을 올려 놓는 곳
    private func setShowCardViewLayout() {
        let halfOfWidth = widthOfCard / 2
        self.view.addSubview(showCardView)
        showCardView.setRatio()
        showCardView.top(equal: self.view)
        showCardView.trailing(equal: backCard.view.leadingAnchor, constant: -(halfOfWidth + 3))
        showCardView.width(constant: widthOfCard)
    }
}
