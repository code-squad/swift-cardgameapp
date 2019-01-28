//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

