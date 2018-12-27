//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit

struct CardSize {
    init(screenBound: CGRect ){
        self.width = screenBound.width / 7
        self.height = self.width  * 1.25
    }
    
    /// 카드 가로값
    let width : CGFloat
    /// 카드 세로값
    let height : CGFloat
}

class ViewController: UIViewController {
    
    /// 카드 뒷면 7장의 배열
    var cardBackImageViews : [UIImageView] = []
    
    /// status var height
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    /// 카드 개수
    let maxBackCard = 7
    
    var cardSize : CardSize!
    
    /// 앱 배경화면 설정
    func setBackGroundImage() {
        // 배경이미지 바둑판식으로 출력
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_pattern"))
    }
    
    /// 카드뒷면 cardCount장 출력
    func setBackCards(cardCount: Int){
        // 반복문용 변수로 변환
        let count = cardCount - 1
        // 0 ~ cardCount -1 까지
        for x in 0...count {
            // 위치 0에서부터 시작해서 cardCount 만큼 늘려준다
            let backImage : UIImageView = UIImageView(frame: CGRect(x: cardSize.width * CGFloat(x), y: statusBarHeight, width: cardSize.width, height: cardSize.height))
            // 이미지 설정
            backImage.image = #imageLiteral(resourceName: "card-back")
            // 배열에 추가
            cardBackImageViews.append(backImage)
            // 서브뷰 추가
            self.view.addSubview(backImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카드 사이즈 설정
        self.cardSize = CardSize(screenBound: UIScreen.main.bounds)
        
        // 앱 배경 설정
        setBackGroundImage()
        
        // 카드 뒷면 세팅
        setBackCards(cardCount: 7)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

// Configure StatusBar
extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
