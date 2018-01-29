# 카드게임 앱 Step1
## 프로그래밍 요구사항
* ViewController 클래스에서 코드로 아래 출력 화면처럼 화면을 균등하게 7등분해서 7개 UIImageView를 추가하고 카드 뒷면을 보여준다.

디바이스의 크기마다 카드의 가로크기와 마진을 조절해줘야하기 때문에 다음과 같은 코드가 필요하다.
```swift
class CardView: UIView {
    func makeCardView(screenWidth: CGFloat, index: Int) -> UIImageView {
        let marginRatio: CGFloat = 70
        let cardsNumber: CGFloat = 7
        let cardWidth = (screenWidth / cardsNumber) - (screenWidth / marginRatio)
        let margin = (screenWidth - (cardWidth * cardsNumber)) / (cardsNumber + 1)
        let card = UIImageView(image: UIImage(named: "card_back"))
        let xCoordinate = ((cardWidth + margin) * CGFloat(index)) + margin
        card.frame = CGRect(x: xCoordinate, y: 32, width: cardWidth, height: (screenWidth / cardsNumber) * 1.27)
        return card
    }
}
```
screenWidth는 디바이스의 가로크기를 받아온다. ```let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width```그리고 받아온 크기별로
카드의 가로크기를 marginRatio로 지정하여준다. 그리고 마진은 7장이필요하다면 8개의 마진이 필요하기 때문에 8로 나누어 준다.
![Step1](./ScreenShot/step1.png)

# 카드게임 앱 Step2
## 프로그래밍 요구사항
* CardDeck 인스턴스를 만들고 랜덤으로 카드를 섞고 출력 화면처럼 보이도록 개선한다.
* 화면 위쪽에 빈 공간을 표시하는 UIView를 4개 추가하고, 우측 상단에 UIImageView를 추가한다.
     * 상단 화면 요소의 y 좌표는 20pt를 기준으로 한다.
     * 7장의 카드 이미지 y 좌표는 100pt를 기준으로 한다.
     * 앱에서 Shake 이벤트를 발생하면 랜덤 카드를 다시 섞고 다시 그리도록 구현한다.

![Step2](./ScreenShot/step2.png)