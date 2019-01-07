//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    /// 플레이카드가 들어가는 스택뷰
    @IBOutlet weak var playCardMainStackView: UIStackView!
    
    /// 최대 카드 개수 장수로 카드사이즈 세팅
    private var cardSize = CardSize(maxCardCount: 7)
    
    /// 카드 덱
    private var cardDeck = Deck()
    /// 카드 전체 위치 배열
    private var widthPositions : [CGFloat] = []
    /// 플레이카드 Y 좌표
    private var heightPositions : [CGFloat] = []
    
    /// 게임보드 생성
    private var gameBoard = GameBoard(slotCount: 7)
    
    /// 앱 배경화면 설정
    private func setBackGroundImage() {
        // 배경이미지 바둑판식으로 출력
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_pattern"))
    }
    
    /// 전체 위치를 설정
    private func calculateWidthPosition(cardSize: CardSize){
        // 0 ~ maxCardCount -1 추가
        for x in 0..<cardSize.maxCardCount {
            widthPositions.append(cardSize.originWidth * CGFloat(x))
        }
    }
    private func calculateHeightPosition(cardSize: CardSize){
        // 트럼프 카드의 종류는 13종
        for x in 0..<13 {
            // 시작지점 높이 100
            heightPositions.append(cardSize.originHeight * 0.25 * CGFloat(x) + 100)
        }
    }
    
    /// 뷰 테두리 생성
    private func makeViewBorder(imageView: UIImageView){
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
    /// 최대 카드 수량 체크
    private func checkMaxCardCount(startNumber: Int, cardCount: Int) -> Bool {
        return startNumber > cardSize.maxCardCount || cardCount > cardSize.maxCardCount
    }
    
    /// 첫줄 카드배경 출력
    private func setObjectPositions(height: CGFloat, cardSize: CardSize){
        // 원하는 빈칸은 4칸
        for x in 1...4 {
        // 카드 빈자리 4장 출력
            addCardView(widthPosition: x, height: 20, cardSize: cardSize, cardImage: nil)
        }
    }
    
    
    /// 카드 * cardCount 출력
    private func addCardViews(startNumber: Int, cardCount: Int, height: CGFloat, cardSize: CardSize, cards: Slot){
        // 최대 카드 수량을 넘어가면 강제리턴
        if checkMaxCardCount(startNumber: startNumber, cardCount: startNumber) {
            return ()
        }
        
        // 0 ~ cardCount-1 까지
        for x in startNumber..<(startNumber + cardCount) {
            // slot 인덱스를 넘어가면 리턴
            guard let card = cards.pop() else { return () }
            // 카드 이름으로 카드이미지 연결
            let cardImage = UIImage(named: card.image())
            // 이미지를 뷰로 출력
            addCardView(widthPosition: x, height: height, cardSize: cardSize, cardImage: cardImage)
        }
    }
    
    /// 뷰를 받아서 패딩 적용된 이미지뷰를 추가한다
    private func addSubImageVIew(superView: UIView, cardSize: CardSize, image: UIImage?){
        // 카드사이즈로 뷰 생성
        let cardImageView : UIImageView = UIImageView(frame: CGRect(x: superView.bounds.origin.x + cardSize.widthPadding, y: superView.bounds.origin.y + cardSize.heightPadding, width: cardSize.width, height: cardSize.height))
        
        // 뒷 테두리 추가
        makeViewBorder(imageView: cardImageView)
        
        // 카드사이즈 뷰에 이미지 생성
        cardImageView.image = image
        
        // 카드사이즈 뷰를 배경뷰에 추가
        superView.addSubview(cardImageView)
    }
    
    /// 카드 이미지 출력
    private func addCardView(widthPosition: Int, height: CGFloat, cardSize: CardSize, cardImage: UIImage?){
        // 배경 뷰 생성
        let cardView : UIImageView = UIImageView(frame: CGRect(x: widthPositions[widthPosition - 1], y: height, width: cardSize.originWidth, height: cardSize.originHeight))
        // 카드사이즈로 뷰 생성
        addSubImageVIew(superView: cardView, cardSize: cardSize, image: cardImage)
        
        // 서브뷰 추가
        self.view.addSubview(cardView)
    }
    
    
    /// 덱을 뷰와 함께 출력
    func drawDeckView(){
        // 덱을 카드객체가 아닌 프로토콜로 받는다
        let cardInfos : [CardInfo] = self.cardDeck.info()
        for cardInfo in cardInfos {
            let cardImage = UIImage(named: cardInfo.image())
            addCardView(widthPosition: 7, height: 20, cardSize: cardSize, cardImage: cardImage)
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        gameBoard.reset()
    }
    
    /// 라인번호와 카드배열을 받아서 해당 라인에 카드를 출력한다
    func drawCardLine(lineNumber: Int, cardSize: CardSize){
        let cardInfos = gameBoard.getPlayCardLine(lineNumber: lineNumber)
        for x in 0..<cardInfos.count {
            let cardImage = UIImage(named: cardInfos[x].image())
            addCardView(widthPosition: lineNumber, height: heightPositions[x], cardSize: cardSize, cardImage: cardImage)
        }
    }
    
    /// 맥스카드카운트로 모든 플레이카드 를 출력한다
    func drawAllPlayCard(cardSize: CardSize) {
        for x in 1...cardSize.maxCardCount {
            drawCardLine(lineNumber: x, cardSize: cardSize)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카드 사이즈 계산
        cardSize.calculateCardSize(screenWidth: UIScreen.main.bounds.width)
        
        // 화면 가로사이즈를 받아서 카드출력 기준점 계산
        calculateWidthPosition(cardSize: cardSize)
        // 세로 위치 설정
        calculateHeightPosition(cardSize: cardSize)
        
        // 앱 배경 설정
        setBackGroundImage()
        
        // 카드덱 초기화
        cardDeck.reset()
        
        // 카드 빈자리 4장 출력
        setObjectPositions(height: 20, cardSize: cardSize)
        
        // 덱 출력
        drawDeckView()
        
        // 플레이카드 출력
        drawAllPlayCard(cardSize: cardSize)
        
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
