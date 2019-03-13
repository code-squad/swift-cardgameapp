//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var framePool = Queue(pool: [CGRect]())
    
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var pileStackView: PositionStackView!
    @IBOutlet weak var previewStackView: PositionStackView!
    @IBOutlet weak var goalsStackView: UIStackView!
    @IBOutlet weak var columnsStackView: UIStackView!
    
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
        
        self.klondikePresenter.attach(view: self)
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
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        klondikePresenter.flipCardsFromThePileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondikePresenter.reset()
            framePool.reset()
        }
    }
}

extension ViewController: KlondikeView {
    
    func addPileStackView(count: Int) {
        guard let beforeFrame = self.framePool.dequeue() else {
            for _ in 0..<count {
                self.pileStackView.addArrangedSubview(CardBackImageView())
            }
            return
        }
        
        let animationView = CardBackImageView()
        animationView.frame = beforeFrame
        self.view.addSubview(animationView)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        animationView.frame.origin = self.pileStackView.frame.origin
        }, completion: { (_) in
            for _ in 0..<count {
                self.pileStackView.addArrangedSubview(CardBackImageView())
            }
            animationView.removeFromSuperview()
        })
    }
    
    func removePileStackView(count: Int) {
        self.framePool.enqueue(self.pileStackView.frame)
        self.pileStackView.removeSubviews(count: count)
    }
    
    func addPreviewStackView(cards: [Card]) {
        guard let beforeFrame = self.framePool.dequeue() else { return }
        
        let animationView = animationCardView(cards: cards, frame: beforeFrame)
        self.view.addSubview(animationView)
        
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(movePreviewTopCard))
            cardImageView.isHidden = true
            self.previewStackView.addArrangedSubview(cardImageView)
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        animationView.frame.origin = self.previewStackView.frame.origin
        }, completion: { (_) in
            for subview in self.previewStackView.arrangedSubviews.suffix(cards.count) {
                subview.isHidden = false
            }
            animationView.removeFromSuperview()
        })
    }
    
    func removePreviewStackView(count: Int) {
        self.framePool.enqueue(self.previewStackView.frame)
        self.previewStackView.removeSubviews(count: count)
    }
    
    func addColumnsStackView(cards: [Card], index: Int) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView,
            let beforeFrame = self.framePool.dequeue() else { return }
        
        let animationView = animationCardView(cards: cards, frame: beforeFrame)
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
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        animationView.frame.origin = origin
        }, completion: { (_) in
            for subview in stackView.arrangedSubviews.suffix(cards.count) {
                subview.isHidden = false
            }
            animationView.removeFromSuperview()
        })
        
    }
    
    func removeColumnsStackView(count: Int, index: Int, card: Card?) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        
        let subviews = stackView.arrangedSubviews.suffix(count)
        guard let first = subviews.first, let last = subviews.last else { return }
        self.framePool.enqueue(absoluteFrameOfStackView(firstView: first, lastView: last))
        stackView.removeSubviews(count: count)
        
        if let card = card {
            stackView.arrangedSubviews.last?.removeFromSuperview()
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(moveColumn))
            stackView.addArrangedSubview(cardImageView)
        }
    }
    
    func initialSettingColumns(count: Int, index: Int, card: Card) {
        guard let subview = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        for _ in 0..<count {
            subview.addArrangedSubview(CardBackImageView())
        }
        let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                              action: #selector(moveColumn))
        subview.addArrangedSubview(cardImageView)
    }
    
    func addGoalsStackView(cards: [Card], index: Int) {
        guard let stackView = goalsStackView.arrangedSubviews[index] as? UIStackView,
            let beforeFrame = self.framePool.dequeue() else { return }
        
        let animationView = animationCardView(cards: cards, frame: beforeFrame)
        self.view.addSubview(animationView)
        
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(moveGoalTopCard))
            cardImageView.isHidden = true
            stackView.addArrangedSubview(cardImageView)
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        animationView.frame.origin = self.view.convert(stackView.frame.origin, from: self.goalsStackView)
        }, completion: {(_) in
            for subview in stackView.arrangedSubviews.suffix(cards.count) {
                subview.isHidden = false
            }
            animationView.removeFromSuperview()
        })
    }
    
    func removeGoalsStackView(count: Int, index: Int) {
        guard let stackView = goalsStackView.arrangedSubviews[index] as? UIStackView else { return }
        
        let frameOfStackView = self.view.convert(stackView.frame, from: self.goalsStackView)
        self.framePool.enqueue(frameOfStackView)
        
        stackView.removeSubviews(count: count)
    }
    
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
    
    private func animationCardView(cards: [Card], frame: CGRect) -> UIView {
        let animationView = UIView()
        animationView.frame = frame
        var cardImageViews: [CardImageView] = []
        for card in cards {
            let cardImageView = CardImageView(card: card)
            cardImageViews.append(cardImageView)
        }
        let cardStackView = UIStackView(arrangedSubviews: cardImageViews)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.axis = .vertical
        cardStackView.alignment = .leading
        cardStackView.distribution = .fill
        animationView.addSubview(cardStackView)
        
        cardStackView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor, constant: 0).isActive = true
        cardStackView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 0).isActive = true
        cardStackView.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 0).isActive = true
        cardStackView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 0).isActive = true
        
        let heightOfCard = animationView.frame.width * 1.27
        cardStackView.spacing = -heightOfCard * (7/10)
        
        return animationView
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
}

