//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var pileStackView: PositionStackView!
    @IBOutlet weak var previewStackView: PositionStackView!
    @IBOutlet weak var goalsStackView: UIStackView!
    @IBOutlet weak var columnsStackView: UIStackView!
    
    //MARK: Instance
    private var klondikePresenter: KlondikePresenter?
    
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
        
        self.klondikePresenter = KlondikePresenter(view: self)
    }
    
    //MARK: Gesture Actions

    @objc private func movePreviewTopCard() {
        klondikePresenter?.movePreviewTopCard()
    }
    
    @objc private func moveGoalTopCard(sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CardImageView,
           let index = goalsStackView.indexOfStackViewWith(cardView: cardView) else { return }

        klondikePresenter?.moveGoalTopCard(index: index)
    }
    
    @objc private func moveColumn(sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CardImageView,
            let position = columnsStackView.positionOfStackViewWith(cardView: cardView) else { return }

        klondikePresenter?.moveColumn(position: position)
    }
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        klondikePresenter?.flipCardsFromThePileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondikePresenter?.reset()
        }
    }
}

extension ViewController: KlondikeView {

    func addPileStackView(count: Int) {
        for _ in 0..<count {
            self.pileStackView.addArrangedSubview(CardBackImageView())
        }
    }
    
    func removePileStackView(count: Int) {
        for subview in self.pileStackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    func addPreviewStackView(cards: [Card]) {
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(movePreviewTopCard))
            self.previewStackView.addArrangedSubview(cardImageView)
        }
    }
    
    func removePreviewStackView(count: Int) {
        for subview in self.previewStackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    func addColumnsStackView(cards: [Card], index: Int) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(moveColumn))
            stackView.addArrangedSubview(cardImageView)
        }
    }
    
    func removeColumnsStackView(count: Int, index: Int, card: Card?) {
        guard let stackView = columnsStackView.arrangedSubviews[index] as? UIStackView else { return }
        for subview in stackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
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
        guard let stackView = goalsStackView.arrangedSubviews[index] as? UIStackView else { return }
        
        for card in cards {
            let cardImageView = cardImageViewWithDoubleTapGesture(card: card,
                                                                  action: #selector(moveGoalTopCard))
            stackView.addArrangedSubview(cardImageView)
        }
    }
    
    func removeGoalsStackView(count: Int, index: Int) {
        guard let stackView = goalsStackView.arrangedSubviews[index] as? UIStackView else { return }
        for subview in stackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    private func cardImageViewWithDoubleTapGesture(card: Card, action: Selector) -> UIImageView {
        let tap = UITapGestureRecognizer(target: self, action: action)
        tap.numberOfTapsRequired = 2
        let cardImageView = CardImageView(card: card)
        cardImageView.isUserInteractionEnabled = true
        cardImageView.addGestureRecognizer(tap)
        return cardImageView
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
}

