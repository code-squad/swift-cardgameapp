# ViewModel과 Protocol
- ModelView 구현 시, 프로토콜 타입으로 설정해보자.
- 예를 들어, 테이블 셀을 설정해야 할 때

```swift
func configure(
        title: String,
        titleFont: UIFont,
        titleColor: UIColor,
        switchOn: Bool,
        switchColor: UIColor = .purpleColor(),
        onSwitchToggleHandler: onSwitchTogglerHandlerType? = nil)
    {
        // Configure views here
    }
```

- 메소드 인자는 최소화한다 -> 인스턴스 변수로 분리 -> configure 메소드에서만 사용하는 변수들 -> 클래스나 추상화 클래스(프로토콜)로 분리 가능
- 셀 설정 시 필요한 사항들을 프로토콜로 정의한다.

```swift
protocol SwitchWithTextCellProtocol {
    var title: String { get }
    var titleFont: UIFont { get }
    var titleColor: UIColor { get }    
    var switchOn: Bool { get }
    var switchColor: UIColor { get }
    func onSwitchToggleOn(on: Bool)
}
```

이렇게 하면 이전에는 6개 이상의 인자가 필요했지만, 이제 인자 하나만 있으면 된다.

```swift
class SwitchWithTextTableViewCell: UITableViewCell {
    func configure(withDelegate delegate: SwitchWithTextCellProtocol)
    {
        // Configure views here
    }
}
```

이 프로토콜을 채택하는 클래스/구조체를 구현하여 넘기면 된다.


### 더 많이 추상화하기
위 프로토콜을 사용자 입력을 받아야하는 정보(DataSource)와 디폴트로 설정되는 정보(Delegate)로 나누면 더 깔끔하다.

```swift
protocol SwitchWithTextCellDataSource {
    var title: String { get }
    var switchOn: Bool { get }
}

protocol SwitchWithTextCellDelegate {
    func onSwitchToggleOn(on: Bool)
    var switchColor: UIColor { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
}
```

그러면 인자를 2개 넘겨야 하는데, Delegate 프로토콜의 정보는 extension을 활용하여 모두 설정 가능하므로, 옵셔널 타입으로 받아도 된다.

```swift
func configure(withDataSource dataSource: SwitchWithTextCellDataSource, delegate: SwitchWithTextCellDelegate?)
{
    // Configure views here
}
```

데이터 소스를 채택하여 원본정보를 변환하여 뷰로 넘기는 뷰모델

```swift
struct MinionModeViewModel: SwitchWithTextCellDataSource {
    var title = "Minion Mode!!!"
    var switchOn = true
}
```

폰트나 색을 보유하고 내부적으로 처리하는 델리게이트를 확장

```swift
extension MinionModeViewModel: SwitchWithTextCellDelegate {
    var switchColor: UIColor {
        return .yellowColor()
    }
    
    func onSwitchToggleOn(on: Bool) {
        if on {
            print("The Minions are here to stay!")
        } else {
            print("The Minions went out to play!")
        }
    }
}
```

* UI 관련 Presentable 프로토콜을 만들면 뷰 설정을 간결하게 할 수 있다.

```swift
protocol ImagePresentable {
    var imageName: String { get }
}

protocol TextFieldPresentable {
    var placeholder: String { get }
    var text: String { get }
    
    func onTextFieldDidEndEditing(textField: UITextField)
}
```

위 프로토콜에 extension을 사용하면 기본 설정값을 따르는 뷰도 설정할 수 있다.

```swift
extension TextPresentable {
    
    var textColor: UIColor {
        return .blackColor()
    }
    
    var font: UIFont {
        return .systemFontOfSize(17)
    }
}
```

* 자기자신이 직접 프로토콜을 따르지는 않지만, 이를 따를 무언가가 올 것이란 예상 하에 제네릭을 사용할 수 있다. 

```swift
class SwitchWithTextTableViewCell<T where T: TextPresentable, T: SwitchPresentable>: UITableViewCell {
    private var delegate: T?
    func configure(withDelegate delegate: T) {
        // Configure views here
    }
}
```
```swift
// 변경 전 코드
class SwitchWithTextTableViewCell: UITableViewCell {
	func configure(withDelegate delegate: SwitchWithTextCellProtocol)
	{
		// Configure views here
	}
}
```


## 요약
* 뷰 설정을 위해 프로토콜 사용
* 주로 subclassing을 하게되는 부분인 폰트와 색, 설정 기본 값을 전체 앱에서 공통으로 사용할 수 있도록 프로토콜 익스텐션 사용
* 프로토콜을 위한 데이터 제공을 위해 테스트가 편한 뷰 모델 사용, 어떤 뷰 모델 버전을 사용할지 뷰 컨트롤러가 결정 가능

**[참고: Introduction to Protocol-Oriented MVVM](https://academy.realm.io/posts/doios-natasha-murashev-protocol-oriented-mvvm/)**