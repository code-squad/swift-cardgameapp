# 카드게임 앱 step 1.

#### 요구사항

- ViewController 클래스에서 self.view 배경을 다음 이미지 패턴으로 지정
- 카드 뒷면 이미지를 다운로드해서 프로젝트 Assets.xcassets에 추가
- ViewController 클래스에서 코드로 아래 출력 화면처럼 화면을 균등하게 7등분해서 7개 UIImageView를 추가하고 카드 뒷면을 표시
- 카드 가로와 세로 비율은 1:1.27로 지정

![](cardgame_step1_20181227.png)

#### 적용사항

- 이미지 asset 에 추가
- 화면크기를 받아서 7등분 적용
- statusbar type 코드로 적용

-

# step 2.

#### 프로그래밍 요구사항

- 레벨2 CardGame 미션의 Main, InputView, OutputView를 제외하고 전체 클래스를 프로젝트로 복사한다.
- 기존 코드들은 MVC 중에서 대부분 Model의 역할을 담당한다.
- 다음 링크에서 카드 이미지를 다운로드 받아서 Assets에 추가한다. 파일이름을 바꾸지말고 그대로 활용한다.

- https://www.dropbox.com/s/5xbznqbjfq3tn7v/card_decks.zip?dl=0

- Card 객체에 파일명을 매치해서 해당 카드 이미지를 return 하는 메소드를 추가한다.

- Card 객체가 앞면, 뒷면을 처리할 수 있도록 개선한다.
- CardDeck 인스턴스를 만들고 랜덤으로 카드를 섞고 출력 화면처럼 보이도록 개선한다.
- 화면 위쪽에 빈 공간을 표시하는 UIView를 4개 추가하고, 우측 상단에 UIImageView를 추가한다.
- 상단 화면 요소의 y 좌표는 20pt를 기준으로 한다.
- 7장의 카드 이미지 y 좌표는 100pt를 기준으로 한다.
- 앱에서 Shake 이벤트를 발생하면 랜덤 카드를 다시 섞고 다시 그리도록 구현한다.

