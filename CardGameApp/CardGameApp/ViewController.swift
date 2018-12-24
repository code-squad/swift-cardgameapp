//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// 카드 뒷면 7장의 배열
    var cardBackImageViews : [UIImageView] = []

    // Screen width
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경이미지 바둑판식으로 출력
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_pattern"))
        
        let cardWidth : CGFloat = screenWidth / 7
        let cardHeight : CGFloat = cardWidth * 1.25
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        for x in 0...6 {
            let backImage : UIImageView = UIImageView(frame: CGRect(x: cardWidth * CGFloat(x), y: statusBarHeight, width: cardWidth, height: cardHeight))
            backImage.image = #imageLiteral(resourceName: "card-back")
            cardBackImageViews.append(backImage)
            self.view.addSubview(backImage)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

