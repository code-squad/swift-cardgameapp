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
    
    var deck: Deck?
    @IBOutlet weak var deckView: UIView!
    
    //MARK: IBOutlet
    
    @IBOutlet weak var cardsStackView: UIStackView!
    
    //MARK: - Methods
    //MARK: Setting
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
        
        setCards()
    }
    
    //MARK: Private
    
    private func setCards() {
        
        self.deck = Deck()
        self.deck?.shuffle()
        
        addCardsStackViews()
        addDeckView()
    }
    
    private func addDeckView() {
        
        let addDeckView = { [unowned self] (card: Card) -> Void in
            
            let cardView = CardImageView(card: card)
            cardView.frame = self.deckView.frame
            self.view.addSubview(cardView)
        }
        deck?.performByDeck(addDeckView)
    }
    
    private func addCardsStackViews() {
        
        let countOfArrangeViews = cardsStackView.arrangedSubviews.count
        guard let cardStacks = self.deck?.willSetDeck(few: countOfArrangeViews) else { return }
        for index in 0..<countOfArrangeViews {
            guard let subStackView = cardsStackView.arrangedSubviews[index] as? CardStackView else { return }
            subStackView.removeCardsViews()
            subStackView.addCardViews(by: cardStacks[index])
        }
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            setCards()
        }
    }
}
