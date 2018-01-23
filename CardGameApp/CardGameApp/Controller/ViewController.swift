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
    var dragInfo: DragInfo!

    var stackDummyVM = CardStackDummyViewModel()
    var cardDummyVM = CardDummyViewModel()
    var showCardVM = ShowCardViewModel()
    var remainBackCards = [Card]() {
        willSet {
            changeRemainBackCardView(cards: newValue)
        }
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
        cardStackDummyView.addPangesture(
            action: Action(target: self, selector: #selector(self.drag(_:))))
        showCardView.addDoubleTapGesture(
            action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))))
        showCardView.addPangesture(action: Action(target: self, selector: #selector(self.drag(_:))))
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

    private func showAlert(title: String = "Game Clear!", message: String) {
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
        guard let startView = sender.view as? MovableView else { return }
        guard let currentPos = startView.position(tappedLocation) else { return }
        guard startView.isLast(currentPos) == true else { return }
        guard let move = originOfTargetView(view: startView, startIndex: currentPos.stackIndex) else {return}
        guard let cardView = startView.selectedView(currentPos) else { return }
        UIView.animate(
            withDuration: 0.5,
            animations: {
                cardView.frame.origin.x += move.x
                cardView.frame.origin.y += move.y

        },
            completion: { _ in
                self.moveCardViews(view: startView, tappedView: cardView, startIndex: currentPos.stackIndex)
        })
    }

    @objc func drag(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            setDragInfo(gesture)
        case .changed:
            dragViews(gesture)
        case .ended:
            let targetLocation = gesture.location(in: self.view)
            guard let startView = dragInfo.startView,
                let startIndex = dragInfo.startPos?.stackIndex else { return }
            dragCardViews(
                startView: startView, tappedView: dragInfo.changes,
                startIndex: startIndex,
                targetPoint: targetLocation
            )
            backToStartState()
        default: break
        }
    }

    fileprivate func backToStartState() {
        var i = 0
        dragInfo.changes.forEach {
            $0.center.x = dragInfo.originals[i].x
            $0.center.y = dragInfo.originals[i].y
            i += 1
        }
        dragInfo = nil
    }

    func setDragInfo(_ gesture: UIPanGestureRecognizer) {
        dragInfo = DragInfo()
        let tappedLocation = gesture.location(in: self.view)
        guard let tappedView = gesture.view as? MovableView,
            let startPos = tappedView.position(tappedLocation) else { return }
        let belowViews = tappedView.belowViews(startPos)
        dragInfo.startView = tappedView
        dragInfo.startPos = startPos
        dragInfo.changes = belowViews
        dragInfo.changes.forEach {
            dragInfo.originals.append($0.center)
        }
    }

    fileprivate func dragViews(_ gesture: UIPanGestureRecognizer) {
        dragInfo.changes.forEach {
            let translation = gesture.translation(in: self.view)
            $0.center = CGPoint(
                x: $0.center.x + translation.x,
                y: $0.center.y + translation.y)
        }
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
}
