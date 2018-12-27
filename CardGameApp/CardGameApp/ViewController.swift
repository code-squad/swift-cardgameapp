//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit

struct CardSize {
    init(width: CGFloat ){
        self.width = width * 0.9
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
    
    /// 카드사이즈
//    var cardSize : CardSize!
    
    /// 카드 덱
    var cardDeck = Deck()
    
    
    
    /// 앱 배경화면 설정
    func setBackGroundImage() {
        // 배경이미지 바둑판식으로 출력
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_pattern"))
    }
    
    /// 카드뒷면 cardCount장 출력
    func setBackCards(cardCount: Int){
        
        let dividedWidth = UIScreen.main.bounds.width / CGFloat(cardCount)
        
        
        let cardSize = CardSize(width: dividedWidth )
        
        // 0 ~ cardCount -1 까지
        for x in 0..<cardCount {
            // 위치 0에서부터 시작해서 cardCount 만큼 늘려준다
            let backImage : UIImageView = UIImageView(frame: CGRect(x: dividedWidth * CGFloat(x), y: cardSize.height, width: cardSize.width, height: cardSize.height))
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
        
        // 앱 배경 설정
        setBackGroundImage()
        
        // 카드덱 초기화
        cardDeck.reset()
        
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
