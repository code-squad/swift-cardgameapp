//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardGameView: CardGameView!
    private var cardGameViewModel: CardGameViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setCardGameView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setBackground() {
        guard let image = UIImage(named: "bg_pattern.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    private func setCardGameView() {
        cardGameViewModel = CardGameViewModel()
        cardGameView = CardGameView(frame: view.frame, viewModel: cardGameViewModel)
        view.addSubview(cardGameView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            
        }
    }

}
