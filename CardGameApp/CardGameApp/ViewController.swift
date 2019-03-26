//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var framePool: Queue? = Queue(pool: [CGRect]())
    private var draggingView: UIView?
    private var realViews: [CardImageView]?
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var pileStackView: PositionStackView!
    @IBOutlet weak var previewStackView: PreviewStackView!
    @IBOutlet weak var goalsStackView: GoalsStackView!
    @IBOutlet weak var columnsStackView: ColumnsStackView!
    
    //MARK: Instance
    private var klondikePresenter = KlondikePresenter()
    
    //MARK: - Methods
    //MARK: Setting
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.klondikePresenter.attach(pileView: self)
        self.klondikePresenter.attach(previewView: self)
        self.klondikePresenter.attach(columnsView: self)
        self.klondikePresenter.attach(goalsView: self)
        self.klondikePresenter.setUp()
    }
    
    //MARK: Gesture Actions
    
    @objc private func movePreviewTopCard() {
        klondikePresenter.movePreviewTopCard()
    }
    
    @objc private func moveGoalTopCard(sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CardImageView,
            let index = goalsStackView.indexOfStackViewWith(cardView: cardView) else { return }
        
        klondikePresenter.moveGoalTopCard(index: index)
    }
    
    @objc private func moveColumn(sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CardImageView,
            let position = columnsStackView.positionOfStackViewWith(cardView: cardView) else { return }
        
        klondikePresenter.moveColumn(position: position)
    }
    
    @IBAction func drag(_ sender: DragGestureRecognizer) {
        if sender.state == .began {
            guard let dragableView = sender.view as? DragableView & UIView else { return }
            let location = self.view.convert(sender.firstLocation, to: dragableView)
            sender.firstPosition = dragableView.draggingPosition(location)
            guard let suffixViews = dragableView.draggingView(location),
                let firstView = suffixViews.first,
                let lastView = suffixViews.last else { return }
            let frame = absoluteFrameOfStackView(firstView: firstView, lastView: lastView)
            let copiedViews = suffixViews.copiedCardViews()
            let animationView = animationCardView(copiedViews, frame: frame)
            self.view.addSubview(animationView)
            self.realViews = suffixViews
            realViews?.hideViews()
            self.draggingView = animationView
        }
        
        if sender.state == .changed {
            guard let draggingView = draggingView else { return }
            draggingView.center.x += sender.translation(in: self.view).x
            draggingView.center.y += sender.translation(in: self.view).y
            sender.setTranslation(.zero, in: self.view)
        }
        
        if sender.state == .ended {
            self.realViews?.showViews()
            self.draggingView?.removeFromSuperview()
            framePool = nil
            if goalsStackView.frame.contains(sender.location(in: self.view)) {
                let dropPoint = sender.location(in: goalsStackView)
                guard let dragPosition = sender.firstPosition,
                    let dropPosition = goalsStackView.draggingPosition(dropPoint) else { return }
                klondikePresenter.move(dragPosition, to: dropPosition)
            } else if columnsStackView.frame.contains(sender.location(in: self.view)) {
                let dropPoint = sender.location(in: columnsStackView)
                guard let dragPosition = sender.firstPosition,
                    let dropPosition = columnsStackView.draggingPosition(dropPoint) else { return }
                klondikePresenter.move(dragPosition, to: dropPosition)
            }
            framePool = Queue(pool: [CGRect]())
        }
    }
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        klondikePresenter.flipCardsFromThePileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondikePresenter.reset()
            framePool?.reset()
        }
    }
}

extension ViewController: PileView {
    
    func addPileStackView(count: Int) {
        guard let beforeFrame = self.framePool?.dequeue() else {
            for _ in 0..<count {
                self.pileStackView.addArrangedSubview(CardBackImageView())
            }
            return
        }
        
        let animationView = CardBackImageView()
        animationView.frame = beforeFrame
        self.view.addSubview(animationView)
        
        let completion: ((Bool) -> Void)? = { [animationView](_) in
            for _ in 0..<count {
                self.pileStackView.addArrangedSubview(CardBackImageView())
            }
            animationView.removeFromSuperview()
        }
        animate(cardView: animationView, to: self.pileStackView.frame.origin, completion: completion)
    }
    
    func removePileStackView(count: Int) {
        self.framePool?.enqueue(self.pileStackView.frame)
        self.pileStackView.removeSubviews(count: count)
    }
}

extension ViewController: PreviewView {
    
    func addPreviewStackView(cards: [Card]) {
        guard let beforeFrame = self.framePool?.dequeue() else {
            for card in cards {
                let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                      action: #selector(movePreviewTopCard))
                self.previewStackView.addArrangedSubview(cardImageView)
            }
            return
        }
        
        let views = cardViews(cards: cards)
        let animationView = animationCardView(views, frame: beforeFrame)
        self.view.addSubview(animationView)
        
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(movePreviewTopCard))
            cardImageView.isHidden = true
            self.previewStackView.addArrangedSubview(cardImageView)
        }
        let completion: ((Bool) -> Void)? = { [animationView](_) in
            for subview in self.previewStackView.arrangedSubviews.suffix(cards.count) {
                subview.isHidden = false
            }
            animationView.removeFromSuperview()
        }
        animate(cardView: animationView, to: self.previewStackView.frame.origin, completion: completion)
    }
    
    func removePreviewStackView(count: Int) {
        self.framePool?.enqueue(self.previewStackView.frame)
        self.previewStackView.removeSubviews(count: count)
    }
}

extension ViewController: ColumnsView {
    
    func addColumnsStackView(cards: [Card], index: Int) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        guard let beforeFrame = self.framePool?.dequeue() else {
            for card in cards {
                let cardImageView = self.cardImageViewWithDoubleTapGesture(card: card,
                                                                           action: #selector(self.moveColumn))
                stackView.addArrangedSubview(cardImageView)
            }
                return
        }
        
        let views = cardViews(cards: cards)
        let animationView = animationCardView(views, frame: beforeFrame)
        self.view.addSubview(animationView)
        
        let spacing = animationView.frame.width * 1.27 * (3/10)
        var origin = self.view.convert(stackView.frame.origin, from: self.columnsStackView)
        origin.y += spacing * CGFloat(stackView.arrangedSubviews.count)
        
        for card in cards {
            let cardImageView = self.cardImageViewWithDoubleTapGesture(card: card,
                                                                       action: #selector(self.moveColumn))
            cardImageView.isHidden = true
            stackView.addArrangedSubview(cardImageView)
        }
        let completion: ((Bool) -> Void)? = { [animationView](_) in
            for subview in stackView.arrangedSubviews.suffix(cards.count) {
                subview.isHidden = false
            }
            animationView.removeFromSuperview()
        }
        animate(cardView: animationView, to: origin, completion: completion)
    }
    
    func removeColumnsStackView(count: Int, index: Int, card: Card?) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        
        let subviews = stackView.arrangedSubviews.suffix(count)
        guard let first = subviews.first, let last = subviews.last else { return }
        self.framePool?.enqueue(absoluteFrameOfStackView(firstView: first, lastView: last))
        stackView.removeSubviews(count: count)
        
        if let card = card {
            stackView.arrangedSubviews.last?.removeFromSuperview()
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(moveColumn))
            stackView.addArrangedSubview(cardImageView)
        }
    }
    
    func initialSettingColumns(count: Int, index: Int, card: Card) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        for _ in 0..<count {
            stackView.addArrangedSubview(CardBackImageView())
        }
        let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                              action: #selector(moveColumn))
        stackView.addArrangedSubview(cardImageView)
        
        stackView.isHidden = true
        
        var cardImageViews: [UIView] = []
        for _ in 0..<count {
            cardImageViews.append(CardBackImageView())
        }
        cardImageViews.append(CardImageView(card: card))
        let animationView = animationCardView(cardImageViews, frame: self.pileStackView.frame)
        animationView.frame.size = stackView.frame.size
        self.view.addSubview(animationView)
        
        let completion: ((Bool) -> Void)? = { [animationView](_) in
            stackView.isHidden = false
            animationView.removeFromSuperview()
        }
        animate(cardView: animationView, to: self.view.convert(stackView.frame.origin, from: self.columnsStackView), completion: completion)
    }
}

extension ViewController: GoalsView {
    
    func addGoalsStackView(cards: [Card], index: Int) {
        guard let stackView = goalsStackView.arrangedSubviews[index] as? UIStackView else { return }
        guard let beforeFrame = self.framePool?.dequeue() else {
                for card in cards {
                    let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                          action: #selector(moveGoalTopCard))
                    stackView.addArrangedSubview(cardImageView)
                }
                return
        }
        
        let views = cardViews(cards: cards)
        let animationView = animationCardView(views, frame: beforeFrame)
        self.view.addSubview(animationView)
        
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(moveGoalTopCard))
            cardImageView.isHidden = true
            stackView.addArrangedSubview(cardImageView)
        }
        let destination = self.view.convert(stackView.frame.origin, from: self.goalsStackView)
        let completion: ((Bool) -> Void)? = { [animationView](_) in
            for subview in stackView.arrangedSubviews.suffix(cards.count) {
                subview.isHidden = false
            }
            animationView.removeFromSuperview()
        }
        animate(cardView: animationView, to: destination, completion: completion)
    }
    
    func removeGoalsStackView(count: Int, index: Int) {
        guard let stackView = goalsStackView.arrangedSubviews[index] as? UIStackView else { return }
        
        let frameOfStackView = self.view.convert(stackView.frame, from: self.goalsStackView)
        self.framePool?.enqueue(frameOfStackView)
        
        stackView.removeSubviews(count: count)
    }
}

extension ViewController {
    
    private func cardImageViewWithDoubleTapGesture(card: Card, action: Selector) -> UIImageView {
        let tap = UITapGestureRecognizer(target: self, action: action)
        tap.numberOfTapsRequired = 2
        let cardImageView = CardImageView(card: card)
        cardImageView.isUserInteractionEnabled = true
        cardImageView.addGestureRecognizer(tap)
        return cardImageView
    }
    
    private func absoluteFrameOfStackView(firstView: UIView, lastView: UIView) -> CGRect {
        let origin = self.view.convert(firstView.frame.origin, from: firstView.superview)
        let width = firstView.frame.width
        let lastOrigin = self.view.convert(lastView.frame.origin, from: lastView.superview)
        let height = lastOrigin.y + lastView.frame.height - origin.y
        
        return CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
    
    private func animationCardView(_ views: [UIView], frame: CGRect) -> UIView {
        let animationView = UIView()
        animationView.frame = frame
        let cardStackView = animationStackView(views: views)
        animationView.addSubview(cardStackView)
        
        cardStackView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor, constant: 0).isActive = true
        cardStackView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 0).isActive = true
        cardStackView.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 0).isActive = true
        cardStackView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 0).isActive = true
        
        let heightOfCard = animationView.frame.width * 1.27
        cardStackView.spacing = -heightOfCard * (7/10)
        
        return animationView
    }
    
    private func animationStackView(views: [UIView]) -> UIStackView {
        let cardStackView = UIStackView(arrangedSubviews: views)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.axis = .vertical
        cardStackView.alignment = .leading
        cardStackView.distribution = .fill
        return cardStackView
    }
    
    private func animate(cardView: UIView, to destination: CGPoint, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        cardView.frame.origin = destination
        }, completion: completion)
    }
    
    private func cardViews(cards: [Card]) -> [UIView] {
        var views = [UIView]()
        for card in cards {
            views.append(CardImageView(card: card))
        }
        return views
    }
}

extension UIStackView {
    
    func indexOfStackViewWith(cardView: CardImageView) -> Int? {
        guard let stackViews = arrangedSubviews as? [UIStackView] else { return nil }
        return stackViews.firstIndex(where: {$0.arrangedSubviews.contains(cardView)})
    }
    
    func positionOfStackViewWith(cardView: CardImageView) -> Position? {
        guard let stackViews = arrangedSubviews as? [UIStackView] else { return nil }
        
        for stackView in stackViews {
            guard let row = stackView.arrangedSubviews.firstIndex(of: cardView),
                let column = stackViews.firstIndex(of: stackView) else { continue }
            return Position(column: column, row: row)
        }
        return nil
    }
    
    func removeSubviews(count: Int) {
        for subview in self.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    func suffix(of view: UIView) -> [UIView]? {
        guard let index = self.arrangedSubviews.firstIndex(of: view) else { return nil }
        let views = self.arrangedSubviews.suffix(from: index)
        return Array(views)
    }
}

extension Array where Element: CardImageView {
    func copiedCardViews() -> [CardImageView] {
        var copiedCardViews = [CardImageView]()
        for view in self {
            copiedCardViews.append(view.copied())
        }
        return copiedCardViews
    }
    
    func hideViews() {
        for view in self {
            view.isHidden = true
        }
    }
    
    func showViews() {
        for view in self {
            view.isHidden = false
        }
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let dragGesture = gestureRecognizer as? DragGestureRecognizer {
            dragGesture.firstLocation = touch.location(in: self.view)
        }
        return true
    }
}
