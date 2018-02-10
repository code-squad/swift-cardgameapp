## RxSwift와 MVVM
RxSwift는 ReactiveX의 Swift 버전으로, 비동기적인 데이터 흐름을 쉽고 효율적으로 처리할 수 있게 도와주는 라이브러리

### 핵심: 비동기(Async) 이벤트와 Observer 디자인 패턴
#### 비동기적인 작업이란? 
유저의 인터페이스를 방해하지 않고 데이터를 가져오는 작업. 요청한 데이터를 모두 가져오게 되면 앱이나 서버가 완료를 통보하는데, 이것이 바로 비동기 이벤트가 발생한 것이다.

#### Observer 디자인패턴이란? 
유저가 입력할 때마다 즉각적으로 반응하려면, 프로그램이 지속적으로 값을 관찰하고, 값에 변화가 일어날 때마다 특정 연산이 수행돼야 한다. 해당 스트림에 가입(subscribe)했다고 표현한다.

- 일반적인 iOS 객체 간 소통방법: Callback, Delegate, Notification
- RxSwift 객체 간 소통방법: Observable 디자인 패턴 사용 (Notification/KVO와 같은 패턴)
- Callback보다 Observer: 대부분의 비동기 작업을 처리하는 메소드들은 콜백구조로 설계돼 있는데, 굉장히 복잡한 구조가 될 소지가 있다.
- Funtional Programming(FRP): 비동기적인 데이터 처리를 간단한 함수롤 통해 수행하는 프로그래밍. 과정이나 공식에 매몰되지 않고 이미 만들어진 함수를 활용하자는 취지로, 함수 자체가 ‘숨겨진 input과 output’이 없도록 설계돼야 한다.
- Rx는 이런 FRP 원리를 활용하여 비동기적인 이벤트를 손쉽게 처리하기 위해 만들어진 API이다.

**[참고: 얄미대디의 블로그](https://jdub7138.blog.me/220983291803)**

## RxSwift를 사용한 MVVM 설계 방식

```
target ‘프로젝트명’ do
use_frameworks!
pod 'RxCocoa'
pod 'RxSwift'
end
```

- RxCocoa는 UIKit의 확장판이다. 예를 들어 UIButton().rx_tap 과 같이 사용할 수 있으며, ControlEvent를 사용하여 ObservableType으로 액션을 받을 수 있다.
- 기존에는 뷰컨트롤러를 delegate로 사용하여 프로퍼티의 변화를 감지하게 되는데, RxSwift를 이용하면 다음과 같이 사용할 수 있다:

```swift
searchBar
   .rx_text
   .subscribeNext { (text) in
 	print(text)
}
```

- UICollectionView와 같은 컨테이너뷰도 마찬가지다. 기존에는 뷰컨트롤러를 컬렉션뷰의 delegate로 사용했지만, RxSwift를 사용하면 뷰모델 객체를 생성한 후 뷰모델 객체에서 데이터를 가져와(getData) 이 중 필요한 데이터만 추출(filter)하여 뷰에 연결(bind)하여 뿌려줄 수 있다.

```swift
 override func viewDidLoad() {
    super.viewDidLoad()
    setup()
}
 
func setup() {
 
    //initialize viewModel
    viewModel = ViewModel()
 
    viewModel.getData()
        //set pageCtr.numberOfPages
        //images should not be nil
        .filter { [unowned self] (images) -> Bool in
            self.pageCtrl.numberOfPages = images.count
            return images.count > 0
        }
 
        //bind to collectionView
        //set pageCtrl.currentPage to selected row
        .bindTo(collView.rx_itemsWithCellIdentifier("Cell", cellType: Cell.self)) { [unowned self] (row, element, cell) in
            cell.cellImageView.image = element
            self.pageCtrl.currentPage = row
        }
 
        //add to disposeableBag, when system will call deinit - we`ll get rid of this connection
        .addDisposableTo(disposeBag)
}
```

- subscribeOn(): 이벤트 체인이 어느 스트림에서 시작할 건지
- observeOn(): 다음 이벤트가 어디에서 시작되어야 하는지

**[출처: Beyond MVC - how to use MVVM in iOS](https://stfalcon.com/en/blog/post/beyond-mvc-how-to-use-MVVM-in-iOS)**
