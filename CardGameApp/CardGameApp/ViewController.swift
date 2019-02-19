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
    static let notEnoughCard = NSNotification.Name("notEnoughCard")
}

class ViewController: UIViewController {
    @IBOutlet weak var cardsSegment: UISegmentedControl!
    @IBOutlet weak var playersSegment: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    
    var cardImages: [UIImageView] = []
    var playerLabels: [UILabel] = []
    var medalImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialBackground()
        initialButton()
        initialGame()
        NotificationCenter.default.addObserver(self, selector: #selector(setView), name: .distributedCardToPlayers, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appearWarning), name: .notEnoughCard, object: nil)
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
        Dealer.sharedInstance.setGameMenu(.sevenCard)
        Dealer.sharedInstance.setPlayersMenu(.two)
        Players.sharedInstance.makePlayer(by: .two, Dealer.sharedInstance)
    }
    
    @objc func setView() {
        clearView()
        createSubView()
        appearView()
    }
    
    private func clearView() {
        for cardImage in cardImages { cardImage.removeFromSuperview() }
        for playerLabel in playerLabels { playerLabel.removeFromSuperview() }
        medalImage?.removeFromSuperview()
        cardImages.removeAll()
        playerLabels.removeAll()
    }
    
    private func appearView() {
        for cardImage in cardImages { self.view.addSubview(cardImage) }
        for player in playerLabels { self.view.addSubview(player) }
    }
    
    @objc func appearWarning() {
        let warningWindow = UIAlertController(title: "Wanring", message: "Card Deck is Not Enough", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        warningWindow.addAction(okAction)
        present(warningWindow, animated: true, completion: nil)
    }
    
    @IBAction func playGame(_ sender: Any) {
        guard Dealer.sharedInstance.isSetMenu() else { return }
        guard Dealer.sharedInstance.distributeCardToPlayer(to: Players.sharedInstance) else { return }
        Players.sharedInstance.judgePlayersState()
        let name = Players.sharedInstance.judgeWinner()
        markWinner(of: name)
    }
    
    private func markWinner(of name: String) {
        for label in playerLabels {
            if name == label.text {
                let perPersonCards = cardImages.count / Players.sharedInstance.countPlayers()
                let positionY = label.frame.minY + label.frame.height + 5
                let positionX = label.frame.minX + CGFloat(40 * perPersonCards + 10)
                
                medalImage = UIImageView(frame: CGRect(x: positionX, y: positionY, width: 45, height: 57.15))
                medalImage?.image = UIImage(named: "medal.png")
                guard let medalImage = self.medalImage else { return }
                self.view.addSubview(medalImage)
            }
        }
    }
    
    @IBAction func setCardCount(_ sender: Any) {
        let segmentIndex = cardsSegment.selectedSegmentIndex
        PlayCardGame.selectCard(menu: segmentIndex)
    }
    
    @IBAction func setPlayersCount(_ sender: Any) {
        let segmentIndex = playersSegment.selectedSegmentIndex
        PlayCardGame.selectPlayer(menu: segmentIndex)
    }
    
    private func createSubView() {
        var cardPositionX: CGFloat = 40
        var cardPositionY: CGFloat = 140
        let labelPositionX: CGFloat = 40
        var labelPositionY: CGFloat = 115
        
        for index in 0..<Players.sharedInstance.countPlayers() {
            Players.sharedInstance.iterate(at: index) { name, cards in
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

extension ViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            clearView()
            Dealer.sharedInstance.resetGame()
        }
    }
}

