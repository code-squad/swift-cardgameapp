//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경이미지 바둑판식으로 출력
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Image"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

