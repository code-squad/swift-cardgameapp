//
//  ViewController.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func addBackgroundImage() {
        guard let backgroundImage = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }

}

