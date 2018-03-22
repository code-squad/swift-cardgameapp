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
        for index in 0..<4 {
            self.view.addSubview(imgViewMaker.generateCardImgView(index, .top, UIImage(), true))
        }
        let oneCard = cardDeck.removeOne()
        self.view.addSubview(imgViewMaker.generateCardImgView(6, .top, oneCard.generateCardImg(), false))
    }
    
    private func drawBottomCardBack() {
        for index in 0..<7 {
            let oneCard = cardDeck.removeOne().changeSide()
            self.view.addSubview(imgViewMaker.generateCardImgView(index, .bottom, oneCard.generateCardImg(), false))
        }
    }
    
    private func setBackGround() {
        guard let patternImage = UIImage(named : "bg_pattern") else { return }
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

