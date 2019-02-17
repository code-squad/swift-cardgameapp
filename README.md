## CardGameApp 정리

### Step 1

* UIStatusBarStyle -> LightContent로 변경하기
* UIView 배경 이미지 패턴으로 변경하기



**StatusBarStyle 변경하기**

 앱 기본설정에서 바꾸는게 가능하고 ViewController내에서 코드로 바꾸는 것이 존재한다.

* 우선 **Info.plist**파일에서 설정을 변경해주어야한다.

![first](./2.png)



1. 앱의 기본 설정에서 바꾸기 위해서는 왼쪽의 프로젝트를 선택하고 다음 그림과 같이 설정을 바꾼다.

![secondSceen](./1.png)

2. 코드로 바꾸기 위해서는 ViewController내의 `preferredStatusBarStyle` 프로퍼티를 오버라이드 하여준다.

```swift
class FirstSceen: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
    }
}
```



**UIView에 이미지 패턴 적용하기**

1. 적용할 이미지를 Asset 폴더에 넣어준다.
2. 뷰의 BackgroundColor에 다음과 같은 코드를 적용하여준다.

```swift
class FirstSceen: UIViewController {
    override func viewDidLoad() {
        self.viewDidLoad()
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!) // "bg_pattern"은 Asset에 있는 이미지 파일의 이름이다.
    }
}
```





### Step2

![screeen](./3.png)

* 다음과 같이 포커게임 화면 구성하기



**UIButton 탭했다 땠을 시 색상 변경 구현**

1. UIButton을 탭했을 시 눌린 것을 확인하기 위해 `touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)` 메소드를 오버라이드하여 색상을 바꾸어준다.
2. 버튼을 눌렀다 땠을 시 다시 원래 색상으로 변경하기 위해 `touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)` 메소드를 오버라이드하여 구현해준다.

```swift
extension UIButton {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.clear
    }
}
// **이렇게 구현하였을 시, 버튼에 대한 @IBAction 구현 시 함수가 실행되지 않는 문제가 발생**
```



 여기서 `open` 접근자가 사용되었는데, `open` 접근자란 `public`과 비슷한 개념인데 `public`의 경우는 다른 프로젝트 폴더에서 사용되었을 때, 서브클래싱이나 오버라이드가 불가능하다. 그러나 open 접근자로 열린 경우는 다른 프로젝트에서 서브클래싱이나 오버라이드가 가능하다.



**Segmented Control Button**

![sca](./5.png)

 다음과 같이 여러 메뉴중 하나를 선택할 때 활용하는 `Segmented Control Button` 을 활용하는 법이다.

 애플 공식문서 설명

![ㅁㅈㅇ](./6.Png)

```swift 
@IBOutlet weak var segment: UISegmentedControl!

@IBAction func setCardCount(_ sender: Any) {
        let segmentIndex = segment.selectedSegmentIndex
        switch segmentIndex {
        case 0: print("0 segment Selected")
        case 1: print("1 segment Selected")
        default: return
        }
}

// 다음과 같이 세그먼트들은 각각 선택되었을 시, Index를 통해 구분이 가능하다. selectedSegmentIndex를 사용하여 현재 선택된 Index를 확인가능하다.

```





**Button 테두리 둥글게 하기**

```swift
@IBOutlet weak var playButton: UIButton!

func makeCornerRadius() {
	playButton.layer.cornerRadius = 7
    playButton.layer.masksToBounds = false
    // 또는 playButton.clipsToBounds = true
}
```

 실제 코너를 둥글게하기 위해서는 `layer.cornerRadius` 코드만 있어도 가능하다.

 `UIView` 를 서브클래싱한 클래스들에는 `var layer: CALayer` 와 `var clipsToBounds: Bool` 들이 들어가있다. 이 두 프로퍼티들은 실제 똑같은 동작을 한다. 둘 중 하나를 사용하면 되는데 역할은 애플문서에는 다음과 같이 명시되어 있다.

![awd](./7.png)

 즉 `UIView` 내의 내용들이 영역의 모서리를 기준으로 표시되는지 그렇지 않은지를 선택하는 옵션이다. 만약 `false` 로 선택할 시 코너가 둥글게 되면서 구석에 있는 내용들은 화면에 가려지게 된다.





**View에서 SubView 추가하고 지우기**

```swift
class ViewController: UIViewController {
    var cardImages: [UIImageView] = []
    var playerLabels: [UILabel] = []

    func appearView() {
        for cardImage in cardImages { self.view.addSubview(cardImage) }
    	for player in playerLabels { self.view.addSubview(player) }
    } // ViewController에 뷰 추가
    
    func removeView() {
        for cardImage in cardImages { cardImage.removeFromSuperview() }
    	for player in playerLabels { player.removeFromSuperview() }
    } // ViewController에 뷰 삭제
}
```

