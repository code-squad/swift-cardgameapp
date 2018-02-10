//
//  ViewController.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 30..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    private var position: Position!
    private var deckViewModel: DeckViewModel! {
        didSet {
            bindDataWithSpareCard()
            bindDataWithRevealedCard()
            bindDataWithArrangedCards()
            bindDataWithFetchedCards()
        }
    }

    // 우측 상단에 위치. fetch 후 남은 카드 놓임.
    private lazy var spareCardView: UIImageView = { [unowned self] in
        let size = CGSize(width: cardSize.width-Constants.horizontalStackSpacing, height: cardSize.height)
        let imageView = UIImageView(frame: CGRect(origin: position.spareCardsPosition, size: size))
        imageView.setCardSizeTo(cardSize)
        imageView.setDefaultCardBorderStyle(showBorder: false)
        if let topCardViewModelOnSpareDummy = deckViewModel.spareCardDummy.topCardViewModel(false) {
            // 뷰에 데이터 설정
            imageView.image = topCardViewModelOnSpareDummy.image
        }
        // 제스처인식기 설치
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                action: #selector(handleSingleTapOnSpare(_:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(singleTapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    @objc func handleSingleTapOnSpare(_ sender: UITapGestureRecognizer) {
        deckViewModel.updateSpareTopCard()
    }

    // spare 카드뷰 왼쪽편에 위치. spare 카드뷰에서 뒤집은 카드 놓임.
    private lazy var revealedCardView: UIImageView = { [unowned self] in
        let size = CGSize(width: cardSize.width-Constants.horizontalStackSpacing, height: cardSize.height)
        let imageView = UIImageView(frame: CGRect(origin: position.revealedCardsPosition, size: size))
        imageView.setCardSizeTo(cardSize)
        imageView.setDefaultCardBorderStyle(showBorder: true)
        return imageView
    }()

    // 좌측 상단에 위치될 카드뷰 4개 (처음엔 비어있음). 카드 순서에 맞게 정리되어 놓일 카드뷰.
    private lazy var arrangedCardViews: UIStackView = { [unowned self] in
        let size = CGSize(width: view.frame.width-cardSize.width*3, height: cardSize.height)
        let stackView = UIStackView(frame: CGRect(origin: position.arrangedCardsPosition, size: size))
        for _ in 0..<DeckViewModel.InitialGameSettings.spareViewCount {
            let imageView = UIImageView()
            imageView.frame.size = cardSize
            imageView.setCardSizeTo(cardSize)
            imageView.setDefaultCardBorderStyle(showBorder: true)
            stackView.addArrangedSubview(imageView)
        }
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.horizontalStackSpacing
        return stackView
    }()

    // 하단에 놓일 스택뷰 7개. 각 스택뷰 내부에는 fetch된 카드들이 놓임.
    private lazy var fetchedStackViews: [UIStackView] = { [unowned self] in
        var stacks: [UIStackView] = []
        for stud in 1...DeckViewModel.InitialGameSettings.maxStud {
            let stack = UIStackView(frame: .zero)
            let currentFetchedCardDummy = deckViewModel.fetchedCardDummys[stud-1]
            let imageViews = currentFetchedCardDummy.existCardViewModels(true).map { viewModel -> UIImageView in
                let imageView = UIImageView(image: viewModel.image)
                imageView.setCardSizeTo(cardSize)
                imageView.setDefaultCardBorderStyle(showBorder: false)
                return imageView
            }
            stack.addArrangedSubviews(view: imageViews)
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = -cardSize.height*0.7
            let bottomMarginToLastCard =
                (view.frame.height-position.fetchedCardsPosition.y)-(CGFloat(stud-1)*cardSize.height*0.3+cardSize.height)
            stack.setBottomMargin(bottomMarginToLastCard)
            stacks.append(stack)
        }
        return stacks
    }()

    // 하단 7개 스택뷰들을 가로로 정리하는 컨테이너 스택.
    private lazy var fetchedStackViewContainer: UIStackView = { [unowned self] in
        let size = CGSize(width: view.frame.width, height: view.frame.height-position.fetchedCardsPosition.y)
        let stackContainer = UIStackView(frame: CGRect(origin: position.fetchedCardsPosition, size: size))
        self.fetchedStackViews.forEach {
            stackContainer.addArrangedSubview($0)
        }
        stackContainer.axis = .horizontal
        stackContainer.distribution = .fillEqually
        stackContainer.spacing = Constants.horizontalStackSpacing
        return stackContainer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 배경 패턴 그림
        drawBackground()
        // 위치값
        position = Position(on: self.view, with: cardSize)
        // 뷰모델 생성 (-> 뷰모델 초기설정 -> 바인딩)
        deckViewModel = DeckViewModel()

        // 뷰 배치
        view.addSubview(spareCardView)
        view.addSubview(revealedCardView)
        view.addSubview(arrangedCardViews)
        view.addSubview(fetchedStackViewContainer)
    }

    private lazy var cardSize: CGSize = { [unowned self] in
        guard let view = view else { return CGSize() }
        let width = view.frame.size.width/7
        let height = width*1.27
        return CGSize(width: width, height: height)
    }()

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            deckViewModel.reset()
        }
    }

    private func drawBackground() {
        view.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: Constants.background))
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 0,
                                          bottom: 5,
                                          right: 0)
    }

}

extension ViewController {
    struct Constants {
        static let background: String = "bg_pattern"
        static let horizontalStackSpacing: CGFloat = 4
    }

    struct Position {
        var fetchedCardsPosition: CGPoint
        var arrangedCardsPosition: CGPoint
        var spareCardsPosition: CGPoint
        var revealedCardsPosition: CGPoint

        init(on view: UIView, with cardSize: CGSize) {
            fetchedCardsPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
            arrangedCardsPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
            spareCardsPosition =
                CGPoint(x: view.frame.width-(view.layoutMargins.right+cardSize.width)+Constants.horizontalStackSpacing,
                        y: view.layoutMargins.top)
            revealedCardsPosition =
                CGPoint(x: spareCardsPosition.x-cardSize.width-Constants.horizontalStackSpacing,
                        y: view.layoutMargins.top)
        }
    }
}

extension ViewController {
    private func bindDataWithSpareCard() {
        // 뷰모델-뷰 바인딩
        deckViewModel.spareCardDummy.cards.bindAndFire { [unowned self] in
            if let currCard = $0.last {
                let cardViewModel = CardViewModel(card: currCard, isFaceUp: false)
                self.spareCardView.image = cardViewModel.image
            } else {
                self.spareCardView.image =
                    UIImage(imageLiteralResourceName: DeckViewModel.InitialGameSettings.refresh)
            }
        }
    }

    private func bindDataWithRevealedCard() {
        deckViewModel.revealedCardDummy.cards.bindAndFire { [unowned self] in
            if let currCard = $0.last {
                let cardViewModel = CardViewModel(card: currCard, isFaceUp: true)
                self.revealedCardView.image = cardViewModel.image
            } else {
                self.revealedCardView.image = nil
            }
        }
    }

    private func bindDataWithArrangedCards() {
        for (stackIndex, cardStack) in deckViewModel.arrangedCardDummys.enumerated() {
            cardStack.cards.bindAndFire { [unowned self] in
                guard let imageView =
                    self.arrangedCardViews.arrangedSubviews[stackIndex] as? UIImageView else { return }
                if let currCard = $0.last {
                    let cardViewModel = CardViewModel(card: currCard, isFaceUp: true)
                    imageView.image = cardViewModel.image
                } else {
                    imageView.image = nil
                }
            }
        }
    }

    private func bindDataWithFetchedCards() {
        for (stackIndex, cardStack) in deckViewModel.fetchedCardDummys.enumerated() {
            guard let imageViews = self.fetchedStackViews[stackIndex].arrangedSubviews as? [UIImageView] else { break }
            cardStack.cards.bindAndFire { cards in
                for (cardIndex, card) in cards.enumerated() {
                    let cardViewModel = CardViewModel(card: card)
                    if cardIndex == cards.endIndex-1 {
                        cardViewModel.turnOver(toFrontFace: true)
                    }
                    imageViews[cardIndex].image = cardViewModel.image
                }
            }
        }
    }

}
