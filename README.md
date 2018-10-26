# CardGameApp

# Step1
> 이미지 작업 및 배치

### 작업내용
1. status bar .lightContent 로 변경
2. PatternUIView 커스텀 생성
3. CardBackUIImageView 커스텀 생성
     - UIImageView를 만들 때 상위뷰의 frame을 알 수 없기에 resize 함수를 만들어 크기 조절
     - 여유공간을 전체크기의 10%로 기준을 잡고 나머지를 7등분하여 카드크기 계산

### 시간이 걸린 부분
 - xcode의 타겟을 8+로 지정했지만 스토리보드에서는 8+로 지정하지 않아 frame 계산할 때 원하는대로 나오지 않음

### 첨부파일
![Step1](CaptureImage/Step1.png)

# Step2
> 카드 UI

### 작업내용
1. 레벨2 CardGame 코드 복사
2. 카드 이미지 다운로드
3. Card 객체에 파일명 매치 및 해당 카드 이미지 리턴 메소드 추가
4. Card 객체가 앞, 뒤면 처리하도록 개선
5. CardDeck 인스턴스 생성 및 랜덤 카드 섞고 컬렉션(Collection)에 쌓기
6. 컬렉션에서 카드 7개 가져와서 아래 기본 세팅
7. 화면 위쪽에 빈 공간 표시(CardStorage)하는 UIImageView 4개 추가 , 우측 상단에 UIImageView 추가
    - 상단 화면 요소의 y 좌표는 20pt 기준
    - 7장의 카드 이미지 y 좌표는 100pt 기준
8. 앱에서 Shake 이벤트 발생하면 랜덤 카드를 다시 섞고 다시 그리도록 구현

### 첨부파일
![Step2_1](CaptureImage/Step2_1.png)
![Step2_2](CaptureImage/Step2_2.png)
![Step2_3](CaptureImage/Step2_3.png)
![Step2_4](CaptureImage/Step2_4.png)
![Step2 Demo](CaptureImage/Step2Demo.gif)
