# CardGameApp

### 1. 시작하기 

##### 프로그래밍 요구사항
* 앱 기본 설정을 지정해서 StatusBar 스타일을 LightContent로 보이도록 함
* ViewController 클래스에서 self.view 배경을 다음 이미지 패턴으로 지정한다. 이미지 파일은 Assets에 추가함
* 다음 카드 뒷면 이미지를 다운로드해서 프로젝트 Assets.xcassets에 추가함

<img src="./images/cardgame-app-bg-pattern.png" />

* ViewController 클래스에서 코드로 아래 출력 화면처럼 화면을 균등하게 7등분해서 7개 UIImageView를 추가하고 카드 뒷면을 보여줌

<img src="./images/cardgame-app-card-back.png" />

* 카드 가로와 세로 비율은 1:1.27로 지정함

##### 실행결과 

<img src="./images/cardgame-app-result-1.png" />

##### 학습거리
* 화면 크기에 따라 코드로 View를 생성하고 화면에 추가하는 방식을 학습함
* 앱 기본 설정(Info.plist)을 변경하는 방식에 대해 학습함
