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
