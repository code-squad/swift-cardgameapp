### 카드게임판 시작하기(step-01)

![step-01 실행화면](https://user-images.githubusercontent.com/38850628/51820755-28138300-231a-11e9-9ca1-2f296b1641d2.png)

### 카드 UI(step-02)

#### 학습한 내용

- background에 pattern을 넣을때는 UIColor(patternImage:)를 이용하면 된다.
- StackView안에 있는 UIView들에게 접근하려면 StackView.arrangedSubviews를 이용하면 된다. (이전 자판기앱을 할때도 스택뷰를 이용하여 정렬했었는데 정말 유용하다.)
- preferredStatusBarStyle를 이용하면 StatusBar의 Style을 바꿀수 있다.

![step-02 실행화면](https://user-images.githubusercontent.com/38850628/51850829-ef010000-2365-11e9-9691-c909f212001d.gif)

### 카드스택 화면 표시(step-03)

- UIStackView안에 있는 뷰들을 제거하려면 `.removeArrangedSubViews` 대신 `.removeFromSuperview` 을 사용해야한다는 것을 알았다.

- enum을 Pattern Matching하는 방법을 배웠다.

`case let` 을 사용하면 된다.

ex)
```Swift
for e in entities() {
switch e {
case let .Soldier(x, y):
drawImage("soldier.png", x, y)
case let .Tank(x, y):
drawImage("tank.png", x, y)
case let .Player(x, y):
drawImage("player.png", x, y)
}
}
```

![step-03 실행화면](https://user-images.githubusercontent.com/38850628/52999633-a242ad80-3469-11e9-994c-07f63f860f9b.gif)

### 제스처 인식과 게임 동작(step-04)

- `isUserInteractionEnabled` 속성에 대하여 view의 기본값은 true지만, image views와 labels의 기본값은 false이기 때문에 Tap Gesture를 사용할땐 유의해야한다.

![step-04 실행화면](https://user-images.githubusercontent.com/38850628/53711063-b03df880-3e83-11e9-8fe3-d66b13c66c6a.gif)
![step-04 애니메이션1](https://user-images.githubusercontent.com/38850628/54326872-6a372080-464b-11e9-9177-7b795929a90e.gif)
![step-04 애니메이션2](https://user-images.githubusercontent.com/38850628/54326873-6acfb700-464b-11e9-8079-2cf0ee3bf5f0.gif)
