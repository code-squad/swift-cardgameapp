//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 15/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let distributedCardToPlayers = NSNotification.Name("cardChanged")
}

class ViewController: UIViewController {
    @IBOutlet weak var cardsSegment: UISegmentedControl!
    @IBOutlet weak var playersSegment: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    
    var cardImages: [UIImageView] = []
    var playerLabels: [UILabel] = []
    
    let dealer = Dealer(of: CardDeck())
    let players = Players()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialBackground()
        initialButton()
        initialGame()
        NotificationCenter.default.addObserver(self, selector: #selector(setView), name: .distributedCardToPlayers, object: nil)
    }
    
    private func initialBackground() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
    }
    
    private func initialButton() {
        playButton.layer.cornerRadius = 7
        playButton.clipsToBounds = true
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 1.0
    }
    
    private func initialGame() {
        dealer.setGameMenu(.sevenCard)
        dealer.setPlayersMenu(.two)
        players.makePlayer(by: .two, dealer)
    }
    
    @objc func setView() {
        clearView()
        createSubView()
        appearView()
    }
    
    private func clearView() {
        for cardImage in cardImages { cardImage.removeFromSuperview() }
        for playerLabel in playerLabels { playerLabel.removeFromSuperview() }
        cardImages.removeAll()
        playerLabels.removeAll()
    }
    
    private func appearView() {
        for cardImage in cardImages { self.view.addSubview(cardImage) }
        for player in playerLabels { self.view.addSubview(player) }
    }
    
    @IBAction func playGame(_ sender: Any) {
        if dealer.isSetMenu() {
            dealer.distributeCardToPlayer(to: players)
        }
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
        dealer.setPlayersMenu(playersCount)
        players.makePlayer(by: playersCount, dealer)
    }
    
    private func createSubView() {
        var cardPositionX: CGFloat = 40
        var cardPositionY: CGFloat = 140
        let labelPositionX: CGFloat = 40
        var labelPositionY: CGFloat = 115
        
        for index in 0..<players.countPlayers() {
            players.iterate(at: index) { name, cards in
                let playerTextLabel = createPlayerLabel(name, labelPositionX, labelPositionY)
                playerLabels.append(playerTextLabel)
                
                for card in cards {
                    let cardImageView = createCardImage(card, cardPositionX, cardPositionY)
                    cardImages.append(cardImageView)
                    cardPositionX += 40
                }
                
                labelPositionY += 100
                cardPositionX = 40
                cardPositionY += 100
            }
        }
    }
    
    private func createCardImage(_ card: Card, _ positionX: CGFloat, _ positionY: CGFloat) -> UIImageView {
        let cardWidth: CGFloat = 45
        let cardHeight: CGFloat = 57.15
        let cardImageView = UIImageView(frame: CGRect(x: positionX, y: positionY, width: cardWidth, height: cardHeight))
        cardImageView.image = UIImage(named: card.description)
        return cardImageView
    }
    
    private func createPlayerLabel(_ playerName: String, _ positionX: CGFloat, _ positionY: CGFloat) -> UILabel {
        let labelWidth: CGFloat = 100
        let labelHeight: CGFloat = 20
        let playerLabel = UILabel(frame: CGRect(x: positionX, y: positionY, width: labelWidth, height: labelHeight))
        playerLabel.text = playerName
        playerLabel.textColor = UIColor.white
        return playerLabel
    }
}

