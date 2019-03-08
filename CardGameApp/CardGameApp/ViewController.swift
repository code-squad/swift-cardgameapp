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
    private let klondike = Klondike()
    
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPileStackView),
                                               name: .pileDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePileStackView),
                                               name: .pileDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPreviewStackView),
                                               name: .previewDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePreviewStackView),
                                               name: .previewDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addColumnsStackView),
                                               name: .columnDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeColumnsStackView),
                                               name: .columnDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addGoalsStackView),
                                               name: .goalDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeGoalsStackView),
                                               name: .goalDidPop,
                                               object: nil)
        
        klondike.setUp()
    }
    
    //MARK: Notification
    
    @objc private func addPileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        for _ in cards {
            let cardBackImageView = CardBackImageView()
            self.pileStackView.addArrangedSubview(cardBackImageView)
        }
    }
    
    @objc private func removePileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        for subview in self.pileStackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    @objc private func addPreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        for card in cards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(movePreviewTopCard))
            tap.numberOfTapsRequired = 2
            let cardImageView = CardImageView(card: card)
            cardImageView.isUserInteractionEnabled = true
            cardImageView.addGestureRecognizer(tap)
            self.previewStackView.addArrangedSubview(cardImageView)
        }
    }
    
    @objc private func removePreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        for subview in self.previewStackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    @objc private func addColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Column,
            let position = klondike.position(of: sender),
            let stackView = columnsStackView.arrangedSubviews[position] as? UIStackView else { return }

        for card in cards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(moveColumn))
            tap.numberOfTapsRequired = 2
            let cardImageView = CardImageView(card: card)
            cardImageView.isUserInteractionEnabled = true
            cardImageView.addGestureRecognizer(tap)
            stackView.addArrangedSubview(cardImageView)
        }
    }
    
    @objc private func removeColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Column,
            let position = klondike.position(of: sender),
            let stackView = columnsStackView.arrangedSubviews[position] as? UIStackView else { return }
        for subview in stackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }
    
    @objc private func addGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Goal,
            let position = klondike.position(of: sender),
            let stackView = goalsStackView.arrangedSubviews[position] as? UIStackView else { return }
        
        for card in cards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(moveGoalTopCard))
            tap.numberOfTapsRequired = 2
            let cardImageView = CardImageView(card: card)
            cardImageView.isUserInteractionEnabled = true
            cardImageView.addGestureRecognizer(tap)
            stackView.addArrangedSubview(cardImageView)
        }
    }
    
    @objc private func removeGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Goal,
            let position = klondike.position(of: sender),
            let stackView = goalsStackView.arrangedSubviews[position] as? UIStackView else { return }
        for subview in stackView.arrangedSubviews.suffix(count) {
            subview.removeFromSuperview()
        }
    }

    @objc private func movePreviewTopCard() {
        klondike.movePreviewTopCard()
    }
    
    @objc private func moveGoalTopCard(sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CardImageView,
           let position = goalsStackView.positionOfStackViewWith(cardView: cardView) else { return }

        klondike.moveGoalTopCard(position: position)
    }
    
    @objc private func moveColumn(sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CardImageView,
            let position = columnsStackView.columnAndRowOfStackViewWith(cardView: cardView) else { return }

        klondike.moveColumnCardIn(position: position)
    }
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        klondike.flipCardsFromThePileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondike.reset()
        }
    }
}

extension UIStackView {
    func positionOfStackViewWith(cardView: CardImageView) -> Int? {
        guard let stackViews = arrangedSubviews as? [UIStackView] else { return nil }
        return stackViews.firstIndex(where: {$0.arrangedSubviews.contains(cardView)})
    }
    
    func columnAndRowOfStackViewWith(cardView: CardImageView) -> (Int, Int)? {
        guard let stackViews = arrangedSubviews as? [UIStackView] else { return nil }
        
        for stackView in stackViews {
            guard let row = stackView.arrangedSubviews.firstIndex(of: cardView),
                let column = stackViews.firstIndex(of: stackView) else { continue }
            return (column, row)
        }
        return nil
    }
}

