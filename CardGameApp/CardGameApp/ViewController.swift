//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 19/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardBack: UIImageView!
    
    var cardStacksView: CardStacksView?     // 카드 스택들 뷰
    var spacesView: CardStacksView?         // 카드 빈공간들 뷰
    
    var cardDeck: CardDeck = CardDeck()     // 모델 카드 덱
    var cardStacks: [CardStack] = []        // 모델 카드 스택들
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackgroundPattern()
        initialCardStacks()
        initialSpacesView()
        initialViews()
        
        cardBack.image = UIImage(named: "card-back")
    }
    
    private func setBackgroundPattern() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
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
    
    private func initialSpacesView() {
        var spaces: [SpaceView] = []
        for _ in 0...3 {
            let spaceView = SpaceView(frame: CGRect(x: Sizes.originX, y: Sizes.originY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
            spaces.append(spaceView)
        }
        let spacesViewWidth = Sizes.cardWitdh * spaces.count + (spaces.count-1) * 5
        spacesView = CardStacksView(frame: CGRect(x: 16, y: 20, width: spacesViewWidth, height: Sizes.cardHeight), spaces)
        self.view.addSubview(spacesView!)
    }
    
    private func initialViews() {
        cardStacksView = CardStacksView(frame: CGRect(x: 16, y: 100, width: 378, height: 620), cardStacks)
        self.view.addSubview(cardStacksView!)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardDeck.reset()
            cardDeck.shuffle()
        }
    }
}

