//
//  ViewController.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var imgViewMaker : ImageViewMaker!
    var cardDeck : BaseControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewMaker = ImageViewMaker(UIScreen.main.bounds.width)
        cardDeck.shuffle()
        setBackGround()
        drawBaseImgViews()
        drawBottomCardBack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func drawBaseImgViews() {
        for indexOfOneCard in 0..<Key.Card.foundations.count {
            self.view.addSubview(imgViewMaker.generateCardImgView(indexOfOneCard,
                                                                  Key.Card.noStack.count,
                                                                  .top,
                                                                  UIImage(),
                                                                  true))
        }
        let oneCard = cardDeck.removeOne()
        self.view.addSubview(imgViewMaker.generateCardImgView(Key.Card.lastIndex.count,
                                                              Key.Card.noStack.count,
                                                              .top,
                                                              oneCard.generateCardImg(),
                                                              false))
    }
    
    private func drawBottomCardBack() {
        for indexOfOneCard in 0..<Key.Card.baseCards.count {
            drawOneCardStack(indexOfOneCard)
        }
    }
    
    private func drawOneCardStack(_ indexOfCard: Int) {
        var cardImg : UIImage!
        for stackIndex in 0..<indexOfCard {
            cardImg = cardDeck.removeOne().generateCardImg()
            self.view.addSubview(imgViewMaker.generateCardImgView(indexOfCard,stackIndex,.bottom,cardImg,false))
        }
        cardImg = cardDeck.removeOne().changeSide().generateCardImg()
        self.view.addSubview(imgViewMaker.generateCardImgView(indexOfCard,indexOfCard,.bottom,cardImg,false))
    }
    
    private func setBackGround() {
        guard let patternImage = UIImage(named : Key.Img.background.name) else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            cardDeck.shuffle()
            drawBaseImgViews()
            drawBottomCardBack()
        }
    }

}

