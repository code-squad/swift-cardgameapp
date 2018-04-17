## Step1
- 구현화면 : 2018.04.12
<img src="./Screenshot/step1-1.png" width="50%">


### Status Bar Style
- 화면 상단 상태 바의 UI요소들의 색을 변경할 수 있다.
- ViewController에 아래의 코드를 넣어서 설정할 수 있다.
 ```swift
 override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
}
 ```
 | .default | .lightContent     |
 | :---------- | :---------- |
 |<img src="./Screenshot/step1-3.png" width="50%">|<img src="./Screenshot/step1-2.png" width="50%">|

## Step2
- 화면 상단에 파운데이션 네 칸, 카드뒷면을 표시하고 하단엔 카드 앞면 7장을 랜덤으로 표시한다.
- Shake Gesture를 하면 카드가 다시 랜덤으로 표시된다.
- 구현화면 : 2018.04.13
<img src="./Screenshot/step2-1.gif" width="50%">

## Step3
- CardDeck 객체에서 랜덤으로 카드를 섞고, 출력 화면처럼 카드스택 형태로 보이도록 개선한다.
  - 각 스택의 맨위의 카드만 앞카드로 뒤집는다.
- 카드스택에 표시한 카드를 제외하고 남은 카드를 우측 상단에 뒤집힌 상태로 쌓아놓는다.
- 맨위에 있는 카드를 터치하면 좌측에 카드 앞면을 표시하고, 다음 카드 뒷면을 표시한다.
  - 만약 남은 카드가 없는 경우는 우측에도 빈 카드를 대신해서 반복할 수 있다는 이미지(refresh)를 표시한다.
- 앱에서 Shake 이벤트를 발생하면 랜덤 카드를 다시 섞고 처음 상태로 다시 그리도록 구현한다.

- 구현화면 : 2018.04.17
<img src="./Screenshot/step3-2.gif" width="50%">
