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
