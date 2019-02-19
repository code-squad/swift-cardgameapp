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
