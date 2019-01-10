//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit
import os

/// 카드 표현을 담당하는 이미지뷰
class CardView : UIImageView {
    /// 카드정보를 가진다
    var cardInfo : CardInfo
    
    init(cardInfo: CardInfo, frame: CGRect){
        self.cardInfo = cardInfo
        super.init(frame: frame)
        self.image = UIImage(named: cardInfo.image())
    }
    
    /// 저장기능은 아직 없음
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 카드뷰를 뒤집을 경우 뒤집은 후의 이미지로 교체한다
    func flip(){
        // 카드정보에서 뒤집기
        cardInfo.flip()
        // 이미지를 추출
        guard let flipedCardImage = UIImage(named: cardInfo.image()) else {
            os_log("카드뷰 뒤집기 실패 : %@",cardInfo.name())
            return ()
            
        }
        // 추출된 이미지로 교체
        self.image = flipedCardImage
    }
    
    /// 카드인포 내부에서 카드가 뒤집힐 경우를 위한 이미지 갱신
    func refreshImage(){
        // 이미지 추출
        let changedImage = UIImage(named: cardInfo.image())
        // 이미지 갱신
        self.image = changedImage
    }
}

class ViewController: UIViewController {
    /// 덱 카드들이 뷰로 생성되면 모이는 배열
    private var deckCardViews : [CardView] = []
    /// 오픈덱 카드들이 뷰로 생성되면 모이는 배열
    private var openedCardViews : [CardView] = []
    
    
    /// 플레이카드가 들어가는 스택뷰
    @IBOutlet weak var playCardMainStackView: UIStackView!
    
    /// 최대 카드 개수 장수로 카드사이즈 세팅
    private var cardSize = CardSize(maxCardCount: 7)
    
    /// 카드 전체 위치 배열
    private var widthPositions : [CGFloat] = []
    /// 플레이카드 Y 좌표
    private var heightPositions : [CGFloat] = []
    
    /// 게임보드 생성
    private var gameBoard = GameBoard(slotCount: 7)
    
    /// 앱 배경화면 설정
    private func setBackGroundImage() {
        // 배경이미지 바둑판식으로 출력
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_pattern"))
    }
    
    /// 전체 위치를 설정
    private func calculateWidthPosition(cardSize: CardSize){
        // 0 ~ maxCardCount -1 추가
        for x in 0..<cardSize.maxCardCount {
            widthPositions.append(cardSize.originWidth * CGFloat(x) + cardSize.widthPadding)
        }
    }
    private func calculateHeightPosition(cardSize: CardSize){
        // 첫 지점은 20
        heightPositions.append(20 + cardSize.heightPadding)
        // 트럼프 카드의 종류는 13종
        for x in 0..<13 {
            // 시작지점 높이 100
            heightPositions.append(cardSize.originHeight * 0.25 * CGFloat(x) + 100 + cardSize.heightPadding)
        }
    }
    
    /// 뷰 테두리 생성
    private func makeViewBorder(imageView: UIView){
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
    /// 최대 카드 수량 체크
    private func checkMaxCardCount(startNumber: Int, cardCount: Int) -> Bool {
        return startNumber > cardSize.maxCardCount || cardCount > cardSize.maxCardCount
    }
    
    
    
    
    /// 첫줄 카드배경 출력
    private func setObjectPositions(){
        // 원하는 빈칸은 4칸
        for x in 0...3 {
            // 카드 기준점 설정
            let viewPoint = CGPoint(x: widthPositions[x], y: heightPositions[0])
            // 기준점에서 카드사이즈로 이미지뷰 생성
            let emptyCardView = UIView(frame: CGRect(origin: viewPoint, size: cardSize.cardSize))
            // 뷰 테두리 설정
            makeViewBorder(imageView: emptyCardView)
            // 뷰를 메인뷰에 추가
            self.view.addSubview(emptyCardView)
        }
    }
    
    
    /// 카드 이미지 출력
    private func makeCardView(widthPosition: Int, heightPosition: Int, cardSize: CardSize, cardInfo: CardInfo) -> CardView {
        // 배경 뷰 생성
        let cardView = CardView(cardInfo: cardInfo, frame: CGRect(origin: CGPoint(x: widthPositions[widthPosition - 1], y: heightPositions[heightPosition - 1]), size: cardSize.cardSize))
            
        cardView.isUserInteractionEnabled = true
        // 서브뷰 추가
        return cardView
    }
    
    /// 뷰를 받아서 메인 뷰에 추가
    func addViewToMain(view: UIView){
        self.view.addSubview(view)
        return ()
    }
    
    /// 덱을 카드뷰로 출력
    func drawDeckView(){
        // 덱,오픈덱 카드뷰 배열을 초기화 한다. 게임 리셋 기능시 쓰인다.
        deckCardViews = []
        openedCardViews = []
        
        // 덱을 카드객체가 아닌 프로토콜로 받는다
        let cardInfos : [CardInfo] = self.gameBoard.allDeckInfo()
        
        // 각 카드정보를 모두 카드뷰로 전환
        for cardInfo in cardInfos {
            // 카드뷰 생성
            let cardView = makeCardView(widthPosition: 7, heightPosition: 1, cardSize: cardSize, cardInfo: cardInfo)
            // 덱을 위한 탭 제스쳐를 생성, 추가한다
            cardView.addGestureRecognizer(makeTabGetstureForDeck())
            // 메인뷰에 추가
            addViewToMain(view: cardView)
            
            // 덱카드뷰 배열에 넣는다
            deckCardViews.append(cardView)
        }
    }
    
    /// shake 함수.
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        // 게임보드 카드들 초기화
        gameBoard.reset()
        // 카드배치를 뷰로 생성
        gameStart()
    }
    
    /// 라인번호와 카드배열을 받아서 해당 라인에 카드를 출력한다
    func drawCardLine(lineNumber: Int){
        // 게임보드에서 플레이카드를 카드인포 배열로 받는다
        let cardInfos = gameBoard.getPlayCardLine(lineNumber: lineNumber)
        // 모든 카드인포가 목표
        for x in 0..<cardInfos.count {
            let cardView = makeCardView(widthPosition: lineNumber, heightPosition: x + 2, cardSize: cardSize, cardInfo: cardInfos[x])
            // 유저와 상호작용 on
            cardView.isUserInteractionEnabled = true
            addViewToMain(view: cardView)
        }
    }
    
    /// 맥스카드카운트로 모든 플레이카드 를 출력한다
    func drawAllPlayCard() {
        for x in 1...cardSize.maxCardCount {
            drawCardLine(lineNumber: x)
        }
    }
    
    
    /// 덱 탭 제스처시 발생하는 이벤트
    @objc func deckTapEvent(_ sender: UITapGestureRecognizer) {
        // 이벤트발생시 게임보드안 카드를 덱에서 오픈덱으로 이동
        guard let openedCardInfo = openDeck() else { return () }
        
        // 옮겨진 뷰가 카드뷰가 맞는지 체크
        guard let openedCardView = sender.view as? CardView else { return () }
        
        // 옮기려는 카드뷰와 오픈된카드인포가 맞는지 체크
        guard openedCardInfo.name() == openedCardView.cardInfo.name() else {
            os_log("터치된 덱뷰와 오픈된 카드의 카드인포 불일치")
            os_log("%@","\(openedCardInfo.name()) vs \(openedCardView.cardInfo.name())")
            return ()
        }
        
        
        // 오픈된 카드뷰 위치 이동.  5번과 6번 사이. 둘을 더해서 /2 하면 가운데값이 나옴
        openedCardView.frame.origin.x = (widthPositions[4] + widthPositions[5]) / 2
        
        // 카드뷰를 뒤집는다
        openedCardView.flip()
        
        // 옮겨진 카드가 안보이니 맨 위로 올린다
        self.view.bringSubview(toFront: openedCardView)
        
        // 상호작용 금지
        openedCardView.isUserInteractionEnabled = false
        
        // 해당 뷰를 덱>오픈덱 뷰 배열로 옮긴다
        guard let popedDeckCardView = deckCardViews.popLast() else {
            os_log("덱카드뷰 에서 뷰 추출 실패")
            return ()
        }
        openedCardViews.append(popedDeckCardView)
        
    }
    
    /// 덱을 오픈한다
    func openDeck() -> CardInfo? {
        // 덱의 카드를 오픈덱으로 이동
        guard let openedCardInfo = gameBoard.deckToOpened() else { return nil }
        // 카드인포 리턴
        return openedCardInfo
    }
    
    /// 덱을 위한 탭 제스처
    func makeTabGetstureForDeck() -> UITapGestureRecognizer {
        // 탭 제스처 선언
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.deckTapEvent(_:)))
        // 작동에 필요한 탭 횟수
        gesture.numberOfTapsRequired = 1
        // 작동에 필요한 터치 횟수
        gesture.numberOfTouchesRequired = 1
        // 제스처를 리턴한다
        return gesture
    }
    
    /// 덱 가장 밑부분의 리프레시 아이콘뷰
    func makeRefreshIconView(){
        // 뷰 기준점 설정.
        let viewPoint = CGPoint(x: widthPositions[6], y: heightPositions[0])
        // 기준점에서 카드사이즈로 이미지뷰 생성
        let refreshIconView = UIImageView(frame: CGRect(origin: viewPoint, size: cardSize.cardSize))
        // 리프레시 아이콘 적용
        refreshIconView.image = #imageLiteral(resourceName: "cardgameapp-refresh-app")
        // 뷰를 메인뷰에 추가
        addViewToMain(view: refreshIconView)
    }
    
    
    /// 카드게임 시작시 카드뷰 전체 배치 함수
    func gameStart(){
        
        // 덱 출력
        drawDeckView()
        
        // 플레이카드 출력
        drawAllPlayCard()
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
        
        // 카드 빈자리 4장 출력
        setObjectPositions()
        
        // 리프레시 아이콘 뷰 생성
        makeRefreshIconView()
        
        // 카드배치 시작
        gameStart()
        
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
