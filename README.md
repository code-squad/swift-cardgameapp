### 카드게임판 시작하기(step-01)

![step-01 실행화면](https://user-images.githubusercontent.com/38850628/51820755-28138300-231a-11e9-9ca1-2f296b1641d2.png)

### 카드 UI(step-02)

#### 학습한 내용

- background에 pattern을 넣을때는 UIColor(patternImage:)를 이용하면 된다.
- StackView안에 있는 UIView들에게 접근하려면 StackView.arrangedSubviews를 이용하면 된다. (이전 자판기앱을 할때도 스택뷰를 이용하여 정렬했었는데 정말 유용하다.)
- preferredStatusBarStyle를 이용하면 StatusBar의 Style을 바꿀수 있다.

![step-02 실행화면](https://user-images.githubusercontent.com/38850628/51850829-ef010000-2365-11e9-9691-c909f212001d.gif)

### 카드스택 화면 표시

- UIStackView안에 있는 뷰들을 제거하려면 `.removeArrangedSubViews` 대신 `.removeFromSuperview` 을 사용해야한다는 것을 알았다.
