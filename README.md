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

