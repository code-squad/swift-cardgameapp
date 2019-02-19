//
//  ViewController.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2018. 12. 24..
//  Copyright © 2018년 Drake. All rights reserved.
//

import UIKit
import os

extension Notification.Name {
    static let cardMoved = Notification.Name("cardMoved")
}


class ViewController: UIViewController {
    /// 플레이카드가 들어가는 스택뷰
    @IBOutlet weak var playCardMainStackView: UIStackView!
    
    /// 포인트덱뷰
    var pointDeckView = PointDeckView()
    
    
    /// 덱뷰 생성
    var deckView = DeckView()
    /// 오픈덱뷰 생성
    var openedDeckView = OpenedDeckView()
    
    
    
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
        for x in 0..<Numbering.allCases().count {
            // 시작지점 높이 100
            heightPositions.append(cardSize.originHeight * 0.25 * CGFloat(x) + 100 + cardSize.heightPadding)
        }
    }
    
    
    /// 최대 카드 수량 체크
    private func checkMaxCardCount(startNumber: Int, cardCount: Int) -> Bool {
        return startNumber > cardSize.maxCardCount || cardCount > cardSize.maxCardCount
    }
    
    
    /// 첫줄 카드배경 출력
//    private func setPointDeckPosition(){
//        // 원하는 빈칸은 4칸
//        for x in 0..<Mark.allCases().count {
//            // 카드 기준점 설정
//            let viewPoint = CGPoint(x: widthPositions[x], y: heightPositions[0])
//            // 기준점에서 카드사이즈로 이미지뷰 생성
//            let emptyCardView = EmptyPointCardView(origin: viewPoint, size: cardSize.cardSize)
//            // 뷰를 메인뷰에 추가
//            self.view.addSubview(emptyCardView)
//        }
//    }
    
    
    /// 카드 이미지 출력
    private func makeCardView(widthPosition: Int, heightPosition: Int, cardSize: CardSize, cardInfo: CardInfo) -> CardView {
        // 배경 뷰 생성
        let cardView = CardView(cardInfo: cardInfo, frame: CGRect(origin: CGPoint(x: widthPositions[widthPosition - 1], y: heightPositions[heightPosition - 1]), size: cardSize.cardSize))
        // 서브뷰 추가
        return cardView
    }
    
    /// 뷰를 받아서 메인 뷰에 추가
    func addViewToMain(view: UIView){
        self.view.addSubview(view)
        return ()
    }
    
    /// 덱인포를 받아서 카드인포배열을 리턴
    func getDeckInfo(deckInfo: DeckInfo) -> [CardInfo] {
        return deckInfo.allInfo()
    }
    
    
    /// 덱을 카드뷰로 출력
    func drawDeckView(){
        // 덱을 카드객체가 아닌 프로토콜로 받는다
        let cardInfos = getDeckInfo(deckInfo: self.gameBoard)
        
        // 각 카드정보를 모두 카드뷰로 전환
        for cardInfo in cardInfos {
            // 카드뷰 생성
            let cardView = CardView(cardInfo: cardInfo, size: cardSize.cardSize)
            // 덱을 위한 탭 제스쳐를 생성, 추가한다
            cardView.addGestureRecognizer(makeTapGetstureForDeck())
            
            // 덱카드뷰에 넣는다
            self.deckView.addSubview(cardView)
        }
    }
    
    /// 라인번호와 카드배열을 받아서 해당 라인에 카드를 출력한다
    func drawCardLine(lineNumber: Int){
        // 게임보드에서 플레이카드를 카드인포 배열로 받는다
        let cardInfos = gameBoard.getPlayDeckLineCardInfos(line: lineNumber)
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
        for x in 0..<cardSize.maxCardCount {
            drawCardLine(lineNumber: x)
        }
    }
    
    
    /// 덱 탭 제스처시 발생하는 이벤트
    @objc func deckTapEvent(_ sender: UITapGestureRecognizer) {
        // 옮겨진 뷰가 카드뷰가 맞는지 체크
        guard let openedCardView = sender.view as? CardView else {
            os_log("터치된 객체가 카드뷰가 아닙니다.")
            return ()
        }
        
        // 꺼낸 카드가 덱뷰의 마지막 카드가 맞는지 체크
        guard openedCardView == self.deckView.subviews.last else {
            os_log("덱뷰의 마지막 카드가 아닙니다")
            return ()
        }
        
        let _ = openDeck(cardInfo: openedCardView.cardInfo)
    }
    
    /// 덱을 오픈한다
    func openDeck(cardInfo: CardInfo) -> CardInfo? {
        // 덱의 카드를 오픈덱으로 이동
        guard let openedCardInfo = gameBoard.deckToOpened(cardInfo: cardInfo) else { return nil }
        
        // 카드인포 리턴
        return openedCardInfo
    }
    
    /// 덱을 위한 탭 제스처
    func makeTapGetstureForDeck() -> UITapGestureRecognizer {
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
        self.deckView.setPosotion(origin: viewPoint, size: cardSize.cardSize)
        // 제스처를 적용
        let refreshGesture = makeRefreshGesture()
        self.deckView.addGestureRecognizer(refreshGesture)
        // 뷰를 메인뷰에 추가
        addViewToMain(view: self.deckView)
    }
    
    /// 리프레시 아이콘 함수. 오픈덱 카드뷰를 역순으로 뒤집어서 덱뷰에 삽입
    @objc func refreshDeck(_ sender: UITapGestureRecognizer){
        // 게임보드도 이동해 준다
        gameBoard.openedDeckToDeck()
    }
    
    /// 리프레시 아이콘 용 제스처 생성
    func makeRefreshGesture() -> UITapGestureRecognizer {
        // 탭 제스처 선언
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.refreshDeck(_:)))
        // 작동에 필요한 탭 횟수
        gesture.numberOfTapsRequired = 1
        // 작동에 필요한 터치 횟수
        gesture.numberOfTouchesRequired = 1
        // 제스처를 리턴한다
        return gesture
    }
    
    /// 카드게임 시작시 카드뷰 전체 배치 함수
    func gameStart(){
        // 카드 빈자리 4장 출력
//        setPointDeckPosition()
        
        // 리프레시 아이콘 뷰 생성
        makeRefreshIconView()
        
        // 오픈덱뷰 생성
        makeOpenedDeckView()
        
        // 포인트덱뷰 생성
        setPointDeckView()
        
        // 덱 출력
        drawDeckView()
        
        // 플레이카드 출력
//        drawAllPlayCard()
    }
    
    /// shake 함수.
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        // 뷰를 모두 지운다
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        // 게임보드 카드들 초기화
        gameBoard.reset()
        // 카드배치를 뷰로 생성
        gameStart()
    }
    
    /// 오픈덱뷰 생성
    func makeOpenedDeckView(){
        // 뷰 기준점 설정. 5,6번째 카드 중간값 위치
        let xPosition = (widthPositions[4] + widthPositions[5]) / 2
        let viewPoint = CGPoint(x: xPosition, y: heightPositions[0])
        // 기준점에서 카드사이즈로 이미지뷰 생성
        self.openedDeckView.setPosotion(origin: viewPoint, size: cardSize.cardSize)
        addViewToMain(view: self.openedDeckView)
    }
    
    /// 노티 생성 함수
    func makeNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(afterCardMovedNoti(notification:)), name: .cardMoved, object: nil)
    }
    
    /// 카드 이동 노티를 받으면 뷰이동 함수를 실행
    @objc func afterCardMovedNoti(notification: Notification){
        /// 이동된 카드에 맞게 카드뷰를 이동시킨다
        if let deckType = notification.object as! DeckType? {
            /// 덱타입을 넣어서 이동해야되는 뷰 추출
            guard let cardView = getCardView(deckType: deckType) as? CardView else { return () }
            
            /// 이전덱타입과 뷰를 넣어서 뷰 이동
            rePositinoCardView(pastDeckType: deckType, cardView: cardView)
            
        }
    }
    
    /// 덱타입을 받아서 맞는 카드뷰를 리턴
    func getCardView(deckType: DeckType) -> UIView? {
        switch deckType {
        case .deck : return self.deckView.subviews.last
        case .openedDeck : return self.openedDeckView.subviews.last
//        case .playDeck : return self.pla
        default : return nil
        }
    }
    
    /// 덱타입, 카드뷰를 받아서 카드뷰 타입과 다르면 위치이동 함수 실행
    func rePositinoCardView(pastDeckType: DeckType, cardView: CardView){
        // 노티가 온 덱타입과 받은 카드뷰 덱타입이 다르면 이동시켜준다
        if pastDeckType != cardView.cardInfo.getDeckType() {
            // 이동함수 실행
            moveCardView(cardView: cardView)
        }
    }
    
    /// 뷰를 받아서 덱타입에 맞는 위치로 이동
    func moveCardView(cardView: CardView){
        // 수퍼뷰에서 제거하고
        cardView.removeFromSuperview()
        // 가야할 위치를 받는다
        guard let deckView = getDeck(deckType: cardView.cardInfo.getDeckType()) else { return () }
        // 위치를 재조정 한다
        deckView.addSubview(cardView)
        // 이동후 맞는 이미지로 변경
        cardView.refreshImage()
    }
    
    /// 덱타입을 받아서 맞는 덱뷰를 리턴
    func getDeck(deckType: DeckType) -> UIView? {
        switch deckType {
        case .deck : return self.deckView
        case .openedDeck : return self.openedDeckView
            // 이부분 로직 아직 구상중
//        case .playDeck : return self.plaDeck
//        case .pointDeck : return self.pointDeck????
        default : return nil
        }
    }

    /// 포인트덱뷰 위치 설정
    func setPointDeckView(){
        // 시작점은 1첫번쨰 카드 기준
        let viewPoint = CGPoint(x: widthPositions[0], y: heightPositions[0])
        self.pointDeckView.setPointDeckView(origin: viewPoint, cardSize: self.cardSize)
        addViewToMain(view: self.pointDeckView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 노티 생성
        makeNoti()
        // 카드 사이즈 계산
        cardSize.calculateCardSize(screenWidth: UIScreen.main.bounds.width)
        
        // 화면 가로사이즈를 받아서 카드출력 기준점 계산
        calculateWidthPosition(cardSize: cardSize)
        // 세로 위치 설정
        calculateHeightPosition(cardSize: cardSize)
        
        // 앱 배경 설정
        setBackGroundImage()
        
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

