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

    @IBOutlet var foundationPilesView: FoundationPilesView!
    @IBOutlet var tableauPilesView: TableauPilesView!
    @IBOutlet var wasteView: WasteView!
    @IBOutlet var stockView: StockView!
    var dragInfo: DragInfo!

    var tableauPilesVM = TableauPilesViewModel()
    var foundationPilesVM = FoundationPilesViewModel()
    var wasteVM = WasteViewModel()
    var stockVM: StockViewModel!

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

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.changeStockView(_:)),
            name    : .didChangeStockCardNotification,
            object  : nil
        )

    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            tableauPilesVM.reset()
            foundationPilesVM.reset()
            stockVM = StockViewModel(tableauPilesVM.stockCards)
            wasteVM.removeAll()
            foundationPilesView.removeAllCardDummy()
            tableauPilesView.removeTableauPilesView()
            tableauPilesView.setTableauPilesView(tableauPilesVM.cardStacks)
        }
    }
}

extension ViewController {
    private func initProperties() {
        Size.cardWidth = (self.view.frame.width - Size.constant * 8) / CGFloat(Size.cardStackCount)
        Size.cardHeight = Size.cardWidth * 1.27
        stockVM = StockViewModel(tableauPilesVM.stockCards)
    }

    private func initViews() {
        tableauPilesView.setTableauPilesView(tableauPilesVM.cardStacks)
        tableauPilesView.addDoubleTapGesture(
            action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))))
        tableauPilesView.addPangesture(
            action: Action(target: self, selector: #selector(self.drag(_:))))
        stockView.addTapGesture(
            action: Action(target: self, selector: #selector(self.stockViewDidTap(_:))))
        wasteView.addDoubleTapGesture(
            action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))))
        wasteView.addPangesture(action: Action(target: self, selector: #selector(self.drag(_:))))
    }

    // Initialize Views

    private func initBackGroundImage() {
        view.backgroundColor = UIColor.init(patternImage: Image.bgImage)
    }

    @objc func removeAllShowCardView() {
        wasteView.removeAll()
    }

    @objc func pushShowCardView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let card = userInfo["card"] as? Card else {
                return
        }
        let carView = CardView()
        carView.image = card.makeImage()
        wasteView.push(cardViews: [carView])
    }

    @objc func changeStockView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let stockCards = userInfo["cards"] as? [Card] else {
                return
        }
        if stockCards.isEmpty {
            stockView.image = Image.refreshImage
        } else { stockView.image = Image.backImage }
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
        case is TableauPilesViewModel: view = tableauPilesView
        case is FoundationPilesViewModel: view = foundationPilesView
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
    @objc func stockViewDidTap(_ recognizer: UITapGestureRecognizer) {
        guard let imageView = recognizer.view as? UIImageView,
            let cardImage = imageView.image else {
                return
        }
        switch cardImage {
        case Image.refreshImage:
            stockVM.refresh(with: wasteVM.allCards())
            wasteVM.removeAll()
        case Image.backImage:
            // 카드를 꺼낸다.
            let card = stockVM.pop()
            wasteVM.push(cards: [card])
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
            dragInfo = DragInfo(view: self.view)
            dragInfo.setDragInfo(gesture)
        case .changed:
            dragInfo.dragViews(gesture)
        case .ended:
            let targetLocation = gesture.location(in: self.view)
            guard let startView = dragInfo.startView,
                let startIndex = dragInfo.startPos?.stackIndex else { return }
            dragCardViews(
                startView: startView, tappedView: dragInfo.changes,
                startIndex: startIndex,
                targetPoint: targetLocation
            )
            dragInfo.backToStartState()
            dragInfo = nil
        default: break
        }
    }
}
