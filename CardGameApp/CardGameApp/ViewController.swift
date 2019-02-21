//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 19/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var spaceViews: [UIView]!
    @IBOutlet weak var cardBack: UIImageView!
    
    var cardStacksView: CardStacksView?
    
    var cardDeck: CardDeck = CardDeck()
    var cardStacks: [CardStack] = []        // 모델 카드스택
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackgroundPattern()
        setSpaceView()
        cardBack.image = UIImage(named: "card-back")
        initialCardStacks()
        initialViews()
    }
    
    private func initialViews() {
        cardStacksView = CardStacksView(frame: CGRect(x: 16, y: 100, width: 378, height: 620), cardStacks)
        self.view.addSubview(cardStacksView!)
    }
    
    private func initialCardStacks() {
        for count in 1..<8 {
            let cardStack: CardStack = CardStack()
            for _ in 0..<count {
                guard let card = cardDeck.removeOne() else { return }
                cardStack.add(card)
            }
            cardStacks.append(cardStack)
        }
    }
    
    private func setBackgroundPattern() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
    }

    private func setSpaceView() {
        for view in spaceViews {
            view.backgroundColor = UIColor.clear
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 7
            view.clipsToBounds = false
        }
    }
    
//    private func constraintCardStacks() {
//        let cardWidth: CGFloat = 50
//        let cardHeight: CGFloat = 70
//
//        for stackView in stackViews {
//            let constraintHeight = cardHeight + (cardHeight+stackView.spacing) * CGFloat(stackView.arrangedSubviews.count-1)
//            stackView.heightAnchor.constraint(equalToConstant: constraintHeight).isActive = true
//            stackView.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true
//        }
//
//    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardDeck.reset()
            cardDeck.shuffle()
        }
    }
}

