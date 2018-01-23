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
    @IBOutlet var showCardView: ShowCardView!
    @IBOutlet var backCardView: UIImageView!
    @IBOutlet var cardStackDummyView: CardStackDummyView!

    var stackDummyVM = CardStackDummyViewModel()
    var cardDummyVM = CardDummyViewModel()
    var showCardVM = ShowCardViewModel()
    var remainBackCards = [Card]() {
        willSet {
            changeRemainBackCardView(cards: newValue)
        }
    }

    struct Image {
        static let refreshImage = UIImage(named: "cardgameapp-refresh-app")!
        static let backImage = UIImage(named: "card-back")!
        static let bgImage = UIImage(named: "bg_pattern")!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initProperties()
        initViews()
        initBackGroundImage()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.popView(_:)),
            name: .didPopCardNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.pushView(_:)),
            name: .didPushCardNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.pushShowCardView(_:)),
            name: .didPushShowCardNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.removeAllShowCardView),
            name: .removeAllShowCardNotification,
            object: nil
        )

    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            stackDummyVM.reset()
            cardDummyVM.reset()
            remainBackCards = stackDummyVM.remainCards
            showCardVM.removeAll()
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
        cardStackDummyView.addDoubleTapGesture(
            action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))))
        showCardView.addDoubleTapGesture(
            action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))))
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

    @objc func removeAllShowCardView() {
        showCardView.removeAll()
    }

    @objc func pushShowCardView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let card = userInfo["card"] as? Card else {
                return
        }
        let carView = CardView()
        carView.image = card.makeImage()
        showCardView.push(cardViews: [carView])
    }
}

// MARK: Notification
extension ViewController {
    @objc func popView(_ noti: Notification) {
        guard let sender = noti.object as? MovableViewModel,
            let userInfo = noti.userInfo,
            let index = userInfo["index"] as? Int else {
                return
        }
        let card = userInfo["card"] as? Card
        let view = makeView(sender)
        view.pop(index: index, previousCard: card)
    }

    @objc func pushView(_ noti: Notification) {
        guard let sender = noti.object as? MovableViewModel,
            let userInfo = noti.userInfo,
            let cards = userInfo["card"] as? [Card],
            let index = userInfo["index"] as? Int else {
                return
        }
        let view = makeView(sender)
        var cardViews = [CardView]()
        cards.forEach {
            let cardView = CardView()
            cardView.image = $0.makeImage()
            cardViews.append(cardView)
        }
        view.push(index: index, cardViews: cardViews)
    }

    private func makeView(_ sender: MovableViewModel) -> MovableView {
        var view: MovableView!
        switch sender {
        case is CardStackDummyViewModel: view = cardStackDummyView
        case is CardDummyViewModel: view = cardDummyView
        default: break }
        return view
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
            remainBackCards.append(contentsOf: showCardVM.allCards())
            showCardVM.removeAll()
        case Image.backImage:
            // 카드를 꺼낸다.
            let card = remainBackCards.removeLast()
            showCardVM.push(cards: [card])
        default: break
        }
    }

    @objc func cardViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        let tappedLocation = sender.location(in: self.view)
        guard let tappedView = sender.view as? MovableView else { return }
        guard let currentPos = tappedView.position(pos: tappedLocation) else { return }
        guard let move = originOfTargetView(view: tappedView, startIndex: currentPos.stackIndex) else {return}
        guard let cardView = tappedView.selectedView(pos: currentPos) else { return }
        UIView.animate(
            withDuration: 0.5,
            animations: {
                cardView.frame.origin.x += move.x
                cardView.frame.origin.y += move.y

        },
            completion: { _ in
                self.moveCardViews(view: tappedView, tappedView: cardView, startIndex: currentPos.stackIndex)
        })
    }

    func makeVM(view: MovableView) -> MovableViewModel? {
        switch view {
        case is ShowCardView:
            return showCardVM
        case is CardStackDummyView:
            return stackDummyVM
        default: return nil
        }
    }
}
