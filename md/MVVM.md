# MVVM
## 개요
- **Model(비즈니스로직/데이터)과 ViewModel(Presentation Logic)**이 쌍이고, **View(Presentation)와 Controller**가 짝을 이루는 구조.
- Controller는 더 이상 Model에게 말을 걸 수 없다. ViewModel을 통한다.
- ViewModel은 UI를 다루지 않는다.(UIKit import 금지)

**[참고: 얄미대디의 블로그](https://m.blog.naver.com/PostView.nhn?blogId=jdub7138&logNo=220979742234&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F)**

<br/>

## 원칙
- 모델은 아무에게도 얘기하지 않는다.
    - What data we show
- 뷰모델만이 모델에게 얘기할 수 있다.
    - How the inforamation is presented
    - UIKit을 import할 수 없다. 즉, UI에 관여할 수 없다.
    - 일반적으로, 컨트롤러는 뷰모델을 관찰하여 디스플레이할 새로운 데이터가 없는지 확인한다. (KVO나 FRP 사용)
- 컨트롤러는 모델에게 직접적으로 얘기할 수 없다. 뷰모델, 뷰하고만 상호작용한다.
- 뷰는 뷰컨트롤러에게만 얘기할 수 있다. (이벤트 발생시 알림)
- MVC와 다른 점:
    - 뷰모델 클래스 추가됨: 뷰모델은 뷰 설정 등의 뷰에 대한 데이터인 것 같다.
    - 컨트롤러는 모델에게 접근할 수 없다.
- 사용자 ↔︎ (뷰 ↔︎ 뷰컨트롤러) ↔︎ (뷰모델 ↔︎ 모델)
- MVC와 공통적인 문제점: 앱의 네트워크 로직이 들어갈 곳을 정의하지 않음. 

**[출처: Artsy.net](http://artsy.github.io/blog/2015/09/24/mvvm-in-swift/)**

<br/>

## 적용
### 구조
- View(Controller) ---[owns]--> ViewModel ---[owns]--> Model
- View(Controller) <-[updates]- ViewModel <-[updates]- Model

### 책임
- View: Presentation, User Interaction
- ViewModel: Presentation logic
- Model: Business logic

### 장점
- ViewController의 양을 줄임
- 테스트 용이성: View는 테스트할 수 없는데, View를 추상화하여 테스트 가능
- 구조 개선
- 재사용성 높음

### 단점
- 바인딩 필요
- 보일러플레이트 코드가 될 수 있음(상용구 코드)
- 간단한 뷰와 로직을 구현하기에는 과할 수 있음
- 모든 케이스를 커버할 수는 없음

### 데이터 바인딩
- UI와 Business logic을 연결하는 것
- Two-way Binding: User Input -> Model 변경, Model -> UI 변경
- Swift에서 바인딩하는 방법
    - KVO
    - Delegation
    - Functional Reactive Programming (FRP)
    - Property Observers + 제네릭 클래스 = Boxing

### 바인딩 클래스로 작성하기
- **파라미터로 클로저를 넘기는 것의 의미**
	- 파라미터는 함수를 호출하는 쪽에서 넘겨줄 데이터이다. 
	- 파라미터 타입을 클로저 타입으로 넘기게 되면 함수를 호출한 쪽에서 어떤 함수 로직을 넘긴다는 뜻이다. 
	- 우선, 파라미터로 지정할 클로저의 파라미터와 리턴타입을 정의한다. 
	- 호출부에서 클로저를 파라미터로 받으면, 클로저를 이용해서 파라미터로 데이터를 넘겨서 동작하게 한다. 
- **바인딩 클래스 적용: 반대로 생각하면 된다.**
	- 함수 구현부에서 데이터를 받아서 로직을 처리하는 것이 아니라, 구현부에서 로직을 받아서 내 데이터를 가지고 처리해주는 것이다.
	- 컨트롤러에서 뷰모델의 bind() 함수를 부르고 데이터를 가지고 처리할 로직만 구현해주면, (뷰모델이 소유한) 모델 값이 변경될 때마다 해당 로직에 맞춰서 동작한다. (모델값 변경은 뷰모델이 하며, 뷰컨트롤러는 뷰에 표시만)
	- 따라서 뷰모델에서 변경될 모델 프로퍼티를 제네릭 Box 타입으로 설정한다. (변화 감지 가능한 타입)

```swift
class Box<T> {
	// T 타입(모델의 밸류 타입)을 인자로 받는 클로저
	typealias Listener = T -> Void
	var value: T {
		didSet {
			// Notify Listener(s)
			listener?(value)
		}
	}

	init(_ value: T) {
		self.value = value
	}

	// 클로저(로직)를 받아서 모델 값을 사용하여 클로저 실행 (뷰컨트롤러에 로직이 있다)
	func bind(listener: Listener?) {
		self.listener = listener
		listener?(value)
	}
}

// 42를 초기값으로 넘기되, boxed되었다는 건 값이 변경될 때마다 알린다는 뜻
let boxedInt = Box(42)
// 아래 클로저 로직에 boxedInt를 바인딩한다.
boxedInt.bind {
	print(“value changed: ”, $0)
}
boxedInt.value = 100 // 변경된 값이 클로저에 적용된다.
```

- 이 외에도, Bindable, UIControls + Bindable 형태를 이용할 수 있다.

**[출처: MVVM in Practice - RWDevCon Session (raywenderlich.com)](https://www.youtube.com/watch?v=sWx8TtRBOfk)**
**[출처: Swift + MVVM + Two Way Binding = Win!](https://codeburst.io/swift-mvvm-two-way-binding-win-b447edc55ff5)**

<br/>

## 노트
### 클로저 내 순환참조
- **클로저**(함수포함)는 **레퍼런스형**이기 때문에 **메모리 관리 대상**이다.
- lazy 프로퍼티처럼 클로저를 사용하는 경우, 클로저 내부에서 **외부 변수를 사용하는 경우(캡쳐), 변수에 대해 값을 획득하기 때문에 순환 참조가 발생**할 수 있다. 순환참조가 되면 인스턴스의 강한참조를 끊어도 **인스턴스가 소멸되지 않는다**.(**레퍼런스 카운트가 남아있기 때문**)
- 따라서 self(클로저 외부변수)에 접근하는 경우, 캡쳐리스트인 **[unowned self]**나 **[weak self]**를 사용하여 self에 대해 접근한다. (weak self를 사용하면 self?로 접근)

#### weak, unowned 다시 상기하기:
- 대상 객체의 **레퍼런스 카운트에 영향을 주지 않으면서** 참조를 만든다.
- **강한 참조**는 대상 객체를 가지고 있기 때문에 **자기자신이 없어지지 않는 한** 레퍼런스 카운트가 0이 될 수 없기 때문에 **메모리에서 해제되지 않는다**.
- 반면, **약한/미소유 참조**는 **레퍼런스 카운트가 0이 되는 순간 메모리에서 삭제**되는데, 이 때 **weak**는 **nil**로 설정되지만 **unowned**는 **값의 변화가 없다**. 따라서 **weak는 옵셔널**이어야 하고, **unowned는 옵셔널이 될 수 없다**.
- 메모리가 해제될 때 weak는 nil로 설정되어 더이상 유효하지 않다는 것을 알 수 있지만, unowned는 존재하지 않는 메모리를 참조하게 되는 문제가 발생할 수 있다.

**[참고: 잉여개발자의 블로그](http://minsone.github.io/mac/ios/rules-of-weak-and-unowned-in-swift)**

**[참고: Out of Bedlam의 블로그](https://outofbedlam.github.io/swift/2016/01/31/Swift-ARC-Closure-weakself/)**

<br/>

### Dynamic 키워드
- swift 런타임 말고 **objective-c 런타임에 쓸 변수나 함수 앞에 사용되는 키워드**
    - 코어데이터나 KVO같은 것들은 동적인 objective-c 런타임 덕분에 가능하다.
    - 이는 **모델 변수에 대한 변경사항을 알리고, 결과적으로 이를 데이터베이스에 반영할 수 있도록 허용**한다.
    - 참고로, dynamic 키워드는 클래스 멤버에만 사용 가능하다.

#### dynamic 키워드가 사용되는 이유
- objective-c는 동적 디스패치만 사용하지만, swift는 다른 선택이 없을 때 사용하는데,
- 따라서, swift와 objective-c의 상호운용성 때문에 dynamic 키워드를 사용한다. 

#### dynamic dispatch(동적 디스패치)
- objective-c는 런타임이 호출해야 하는 특정 메소드나 함수 구현을 런타임에 결정할 수 있다. 
- 즉, objective-c는 객체가 메세지를 받으면 진짜 메소드가 구현돼 있는 곳으로 가서 실행을 하는데, 이 과정이 런타임에 일어난다.
- 예를 들어, 하위 클래스가 상위 클래스의 메소드를 재정의하는 경우, 동적 디스패치는 메소드의 구현을 호출해야 하는지, 하위 클래스의 메소드 또는 부모클래스의 메소드를 호출해야 하는 지 파악한다.
- 하지만 이는 성능 저하로 이어진다. 

#### static dispatch(정적 디스패치)
- 컴파일타임에 메소드의 실제 코드 위치를 알면, 바로 해당 주소로 점프해서 실행할 수 있다. 따라서 동적 디스패치보다 성능이 좋다.

```swift
class ObjectToObserve: NSObject {
	dynamic var foo = 0
}

class MyObserver: NSObject {
	var objectToObserve = ObjectToObserve()
	
	override init() {
		super.init()
		objectToObserve.addObserver(self, forKeyPath: “foo”, options: .New, context: nil)
	}

	override func observeValueForKeyPath(변수들) {
		if let newValue = change?[NSKeyValueChangedNewKey] {
			print(“value changed: ”, newValue)
		}
	}

	deinit {
		objectToObserve.removeObserver(self, forKeyPath: “foo”, context: nil)
	}
}
```

[출처를..잊음]()