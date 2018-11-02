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

# Step3
> 카드 배치

### 작업 내용
1. (Step3) 제스처 추가 in CardUIImageView
2. 제스처와 카드 뒤집기 연결 
    1. Card 속성 추가 in CardUIImageView
    2. turnOver in Card 와 gesture in CardUIImageView 연결
    3. CardUIImageView init 변경 : override init(image) → init(card) with super.init(image)
3. ReverseBoxView 생성, Background UIView에 addSubView 및 위치 조절 (처음 뒤집어진 상태의 자리)
4. reverseBox 에 위치한 카드들을 Background UIView 가 아닌 ReverseBoxView 위에 addSubView 하도록 수정
5. BoxView 생성, Background UIView 에 addSubView 및 위치 조절 (ReverseBoxView의 카드들을 클릭했을 때 앞면을 보이며 넘어오는 자리)
6. BoxView, ReverseBoxView 싱글톤 구현 - PatternUIView, CardUIImageView 에서 동일한 객체를 사용하기 위함
7. 카드 뒤집기(ReverseBoxView → BoxView 로 옮기기)
    1. 이벤트 중복 처리 : ReverseView에 있는 것만 이동하기 위해 superView로 상위 뷰를 확인하고  분기처리
    2. 카드 이동 : removeFromSuperview 를 사용하려 했으나 제거만 될 뿐 리턴값을 받지 못해 사용할 수 없었고 그 대신 서브스크립트를 사용하여 카드를 addSubView 하여 제거 & 추가(즉, 이동)가 가능하였습니다. (subviews는 맨 뒤 인덱스값이 가장 앞에 위치하는 아이템)
8. ReverseBoxView의 카드가 empty 이면 reset 화면 보이도록 함
9. refreshImage 클릭하는 경우 카드 재배치 : BoxView → ReverseBoxView
10. shake 이벤트 발생하면 BoxView 의 카드 비우는 로직 추가
11. 카드 스택 구현(아래 기본 세팅되는 카드)
    1. UIView 를 리스트로 가지는 변수를 생성
    2. 기본 틀이 되는 UIView를 PatternUIView에 추가 및 1번에서 만든 변수에 추가
    3. 만든 틀에 1번에서 만든 변수와 카드를 이용해서 기본 세팅
    4. 맨 위에 카드만 앞으로 뒤집어 놓기
    
### 첨부파일
![Step3 Demo](CaptureImage/Step3Demo.gif)
