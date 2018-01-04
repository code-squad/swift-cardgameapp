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
    let constant: CGFloat = 3
    lazy var widthOfCard: CGFloat = { [unowned self] in
        return (self.view.frame.width - 24) / 7
    }()
    lazy var heightOfSaftyArea: CGFloat = { [unowned self] in
        return UIApplication.shared.statusBarFrame.size.height
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
        var views = [UIView?](repeating: nil, count: 4)
        var newViews = views.map { _ in return UIView().makeEmptyView()}
        return newViews
    }()

    // 비어있는 스택 뷰 셋팅
    lazy var emptyStackViews: [UIView] = { [unowned self] in
        var views = [UIView?](repeating: nil, count: 7)
        var newViews = views.map { _ in return UIView() }
        return newViews
    }()

    // 카드가 들어있는 스택 뷰
    var cardStackViews = [CardStackView]()

    var showCardView = UIImageView()
    lazy var backCardView: BackCardView = { [unowned self] in
        return BackCardView(
            frame: CGRect(
                x: constant*7 + widthOfCard*6,
                y: heightOfSaftyArea,
                width: widthOfCard,
                height: widthOfCard * 1.27)
        )
    }()

    // MARK: Override...

    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 초기화
        initData()
        // 뷰 초기화
        initViews()
        // 배경 초기화
        initBackGroundImage()
        // 뷰 배치하기
        initUIViewLayout()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resetData()
            resetCardStackView()
        }
    }
}

// MARK: Events...

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

// MARK: Data Initialize Methods
extension ViewController {
    private func initData() {
        // 카드 스택을 할당.
        cardStacks = makeCardStack()
        // 카드 스택에 할당하고 남은 카드
        remainBackCards = cardDeck.cards
    }

    private func resetData() {
        self.cardDeck = CardDeck()
        initData()
        remainShowCards.removeAll()
        backCardView.state = .normal
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
    private func initViews() {
        cardStackViews = makeCardStackView()
        backCardView.addGesture(self, action: #selector(self.remainCardsViewDidTap(_:)))
    }

    private func resetCardStackView() {
        var copyCardStacks = self.cardStacks
        cardStackViews.forEach { $0.changeImages(copyCardStacks.removeFirst()) }
    }

    private func makeCardStackView() -> [CardStackView] {
        var cardStackViews = [CardStackView]()
        let heightOfView = self.view.frame.height
        cardStacks.forEach { (cardStack: CardStack) in
            let cardStackView = CardStackView(
                frame: CGRect(x: 0, y: 0, width: widthOfCard, height: heightOfView - 100)
            )
            cardStackView.makeCardStackImageView(cardStack)
            cardStackViews.append(cardStackView)
        }
        return cardStackViews
    }
}

 // MARK: Methods...
extension ViewController {
    private func initBackGroundImage() {
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
    private func initUIViewLayout() {
        initEmptyViewLayout()
        initBackCardViewLayout()
        initEmptyStackViewsLayout()
        initCardStackViewLayout()
        initShowCardViewLayout()
    }

    // 왼쪽 상단 비어있는 네 개의 뷰
    private func initEmptyViewLayout() {
        self.view.setGridLayout(emptyViews)
    }

    // 비어있는 카드 스택 뷰
    private func initEmptyStackViewsLayout() {
        let cardHeight = widthOfCard * 1.27
        self.view.setGridLayout(emptyStackViews, top: cardHeight + 10)
    }

    // 카드가 쌓인 카드 스택 뷰
    private func initCardStackViewLayout() {
        emptyStackViews.forEach { (stackview: UIView) in
            let i = emptyStackViews.index(of: stackview) ?? emptyStackViews.endIndex
            stackview.addSubview(cardStackViews[i])
            cardStackViews[i].setLayout()
        }
    }

    private func initBackCardViewLayout() {
        self.view.addSubview(backCardView)
    }

    // 남은 카드들을 올려 놓는 곳
    private func initShowCardViewLayout() {
        let halfOfWidth = widthOfCard / 2
        self.view.addSubview(showCardView)
        showCardView.setRatio()
        showCardView.top(equal: self.view)
        showCardView.trailing(equal:backCardView.leadingAnchor, constant: -(halfOfWidth + constant))
        showCardView.width(constant: widthOfCard)
    }
}
