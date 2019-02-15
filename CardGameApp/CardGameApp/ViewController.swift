//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 15/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardsSegment: UISegmentedControl!
    @IBOutlet weak var playersSegment: UISegmentedControl!
    
    let dealer = Dealer(of: CardDeck())
    let players = Players()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialBackground()
    }
    
    private func initialBackground() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
    }
    
    private func appearCardsAndPlayersOnScreen() {
        
    }
    
    @IBAction func setCardCount(_ sender: Any) {
        let segmentIndex = cardsSegment.selectedSegmentIndex
        let cardCount: ChoiceMenu
        switch segmentIndex {
        case 0: cardCount = .sevenCard
        case 1: cardCount = .fiveCard
        default: return
        }
        dealer.setGameMenu(cardCount)
        
        if dealer.isSetMenu() {
            dealer.distributeCardToPlayer(to: players)
        }
    }
    
    @IBAction func setPlayersCount(_ sender: Any) {
        let segmentIndex = playersSegment.selectedSegmentIndex
        let playersCount: ChoiceParticipate
        switch segmentIndex {
        case 0: playersCount = .two
        case 1: playersCount = .three
        case 2: playersCount = .four
        default: return
        }
        players.makePlayer(by: playersCount, dealer)
        dealer.setPlayersMenu(playersCount)
        
        if dealer.isSetMenu() {
            dealer.distributeCardToPlayer(to: players)
        }
    }
}

