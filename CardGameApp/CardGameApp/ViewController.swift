//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit

struct CardSize {
    init(width: CGFloat, MaxCount: Int ){
        // 입력값 원본
        self.originWidth = width / CGFloat(MaxCount)
        self.originHeight = self.originWidth * 1.25
        
        // 패딩 좌우 0.1 * 2 를 제외한 0.8
        self.width = self.originWidth * 0.8
        // 가로세로 비율 1.25
        self.height = self.width  * 1.25
        
        // 한쪽 패딩 사이즈 * 0.1
        self.widthPadding = self.originWidth * 0.1
        self.heightPadding = self.originHeight * 0.1
    }
    
    /// 입력받은 가로값
    let originWidth : CGFloat
    /// 입력받은 가로 * 1.25
    let originHeight : CGFloat
    /// 카드 가로값. origin * 0.9
    let width : CGFloat
    /// 카드 세로값
    let height : CGFloat
    /// originWidth * 0.1
    let widthPadding : CGFloat
    /// originHeight * 0.1
    let heightPadding : CGFloat
}


class ViewController: UIViewController {
    
    /// 카드 뷰 배열
    var cardBackImageViews : [UIView] = []
    
    /// status var height
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    /// 카드 개수
    let maxCardCount = 7
    
    /// 카드 덱
    var cardDeck = Deck()
    
    /// 카드 전체 위치 배열
    var widthPositions : [CGFloat] = []
    
    /// 앱 배경화면 설정
    func setBackGroundImage() {
        // 배경이미지 바둑판식으로 출력
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_pattern"))
    }
    
    /// 전체 위치를 설정
    func calculateRawPosition(cardSize: CardSize) {
        // 0 ~ maxCardCount -1 추가
        for x in 0..<maxCardCount {
            widthPositions.append(cardSize.originWidth * CGFloat(x))
        }
    }
    
    /// 뷰 테두리 생성
    func makeViewBorder(imageView: UIImageView){
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    /// 
    
    /// 카드 * cardCount 출력
    func drawCardViews(startNumber: Int, cardCount: Int, height: CGFloat, cardSize: CardSize, cardImage: UIImage?){
        // 최대 카드 수량을 넘어가면 강제리턴
        if startNumber > maxCardCount || cardCount > maxCardCount{
            return ()
        }
        
        // 0 ~ cardCount-1 까지
        for x in startNumber..<(startNumber + cardCount) {
            // 위치 0에서부터 시작해서 cardCount 만큼 늘려준다
            let cardView : UIImageView = UIImageView(frame: CGRect(x: widthPositions[x - 1], y: height, width: cardSize.originWidth, height: cardSize.originHeight))
            
            let cardImageView : UIImageView = UIImageView(frame: CGRect(x: cardView.bounds.origin.x + cardSize.widthPadding, y: cardView.bounds.origin.y + cardSize.heightPadding, width: cardSize.width, height: cardSize.height))
            
            
            makeBlankSlot(imageView: cardImageView)
            
            if cardImage != nil {
                cardImageView.image = cardImage
            }
            
            cardView.addSubview(cardImageView)
            
            // 배열에 추가
            cardBackImageViews.append(cardView)
            // 서브뷰 추가
            self.view.addSubview(cardView)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카드 사이즈 계산
        let cardSize = CardSize(width: UIScreen.main.bounds.width, MaxCount: maxCardCount)
        
        calculateRawPosition(cardSize: cardSize)
        
        // 앱 배경 설정
        setBackGroundImage()
        
        // 카드덱 초기화
        cardDeck.reset()
        
        // 카드 빈자리 4장 출력
        drawCardViews(startNumber: 1, cardCount: 4, height: 20, cardSize: cardSize, cardImage: nil)
        
        // 카드 뒷면 생성
        drawCardViews(startNumber: 7, cardCount: 1, height: 20, cardSize: cardSize, cardImage: #imageLiteral(resourceName: "card-back"))
        
        // 랜덤카드 7장 생성
        drawCardViews(startNumber: 7, cardCount: 1, height: 20, cardSize: cardSize, cardImage: #imageLiteral(resourceName: "card-back"))
        
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
