# Card Game App

## 카드게임판 준비
![](img/1_screenshot.png)

### iPhone 프로젝트 설정
- 시뮬레이터: iPhone 8
- Deployment Info > Status Bar Style: Light
- **info.plist > View controller-based status bar appearance: NO**

### 이미지 패턴으로 배경 설정
- 이미지 패턴으로 배경 설정

```swift
view.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
```

- 뷰컨트롤러의 뷰 내부에 inset 설정

```swift
viewRespectsSystemMinimumLayoutMargins = false
view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height, left: 5, bottom: 5, right: 5)
```

- 화면을 균등하게 7등분하여 UIImageView를 추가하고 카드 뒷면 표시
- 카드 가로세로 비율 = 1 : 1.27
- 화면에 카드 나열

```swift
private func layCards() {
    var cardPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
    while cardPosition.x+cardSize.width <= view.frame.maxX-view.layoutMargins.right {
        let cardView = generateCard(cardPosition)
        view.addSubview(cardView)
        cardPosition = CGPoint(x: cardView.frame.maxX+cardMargins,
                               y: view.layoutMargins.top)
    }
}

```

2017-01-30 (작업시간: 1일)

## 카드 UI
![](img/2_screenshot.png)

### 레벨2 프로젝트 코드 복사
- **기존 코드**들은 대부분 **Model 역할**을 담당
- iOS 앱 구조는 MVC 중에서도 우선 **ViewController-Model 관계부터 집중**하고, ViewController-View 관계는 다음 단계에서 개선한다.

### 빈 카드뷰, 스페어 카드뷰 추가
- 빈 카드뷰도 CardView 클래스 사용함
- CardView에 isVacant 프로퍼티를 추가하여 true일 시 image = nil
	- 이 때, 뒤에 기타 컨트롤들이 비칠 수 있으므로 isOpaque는 true로 설정함
- 빈 카드뷰(vacant), 스페어 카드뷰(spare), 게임카드 뷰(dealed)의 위치를 지정해 놓고 해당 개수만큼 ViewController의 view에 붙임

```swift
private func initGameBoard() {
    drawBackground()
    // Deck 생성 및 셔플.
    reset()
    // 각 카드 역할별 위치
    vacantPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
    sparePosition = CGPoint(x: view.frame.width-(view.layoutMargins.right+cardSize.width),
                            y: view.layoutMargins.top)
    dealedPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
    // 빈 공간 4장 그림
    drawVacantSpaces(4, on: vacantPosition)
    // 스페어 카드 1장 그림
    lay(cards: deck?.drawMany(selectedCount: 1), on: sparePosition, false)
    // 게임카드 7장 그림
    lay(cards: deck?.drawMany(selectedCount: 7), on: dealedPosition, true)
}
```

### Shake 이벤트 시 카드 다시 섞어 그리기
- deck을 다시 만들고 shuffle하나 후 스페어카드와 게임카드만 다시 그림.
- 위치는 전역변수로 박아놓고 써야 한다. 함수 내부에 넣거나 연산 프로퍼티 등으로 쓸 때마다 계산하게 되면 첫 번째 shake 때 위치가 변경되므로 주의.

### 학습 내용
>- **[디바이스 종류에 따른 화면크기 처리](https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions)**

2017-02-01 (작업시간: 2일)

<br/>