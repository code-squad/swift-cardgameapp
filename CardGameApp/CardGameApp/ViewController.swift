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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewMaker = ImageViewMaker(UIScreen.main.bounds.width)
        setBackGround()
        drawCardBack(7)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func drawCardBack(_ countOfCards : Int) {
        for xIndex in 0..<countOfCards {
            self.view.addSubview(imgViewMaker.generateCardbackImgView(xIndex))
        }
    }
    
    private func setBackGround() {
        guard let patternImage = UIImage(named : "bg_pattern") else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }

}

