## 프로젝트 설명
* GET, POST, PATCH, DELETE 기능을 이용한 마켓 어플리케이션
* 야곰아카데미에서 수행했던 오픈마켓 프로젝트를 포트폴리오로 쓰기 위해 완성 및 리팩토링하였습니다.
<br/>
  
## 프로젝트 진행시 지키려고 한 사항
* 오픈 라이브러리를 사용하지 않았습니다.
* IOS 13끼지의 기능들만 사용했습니다.
* MVC패턴으로 구현하였고, ViewController의 기능을 최대한 분리하고자 노력했습니다.
* 가로화면에서도 동작할 수 있도록 구현했습니다.
<br/>

## Step1 - 네트워크시 사용할 모델 구현 및 GET으로 요청한 데이터로 마켓 리스트 구현
![ListScroll](https://user-images.githubusercontent.com/84059338/152946778-5e47b1a7-b54a-47cf-b727-de5a0598f2e6.gif)
&nbsp;&nbsp;&nbsp;&nbsp;
![gridView](https://user-images.githubusercontent.com/84059338/152945029-d59fcbcb-da01-4bfb-8c0e-ba969c63ae56.png)

* Protocol을 채택한 HTTP메서드 타입을 매개변수로 넣어주어, 하나의 메서드로 네트워크를 처리하도록 구현했습니다.
* ParsingManager 타입을 통해 구현한 모델타입으로 디코딩했습니다.
* 의존성 주입을 통한 네트워크 무관테스트를 구현했습니다.
* 마켓 리스트 화면을 List와 Grid형식으로 구현하기 위해 CollectionView를 사용했습니다.
* URLCache를 이용해서 Cache 기능을 구현했습니다.
* pagenation을 구현하여 현재 페이지를 모두 스크롤 한뒤 다음 페이지를 받아오도록 했습니다.
<br/>

## Step2 - POST, PATCH를 사용한 상품 등록 및 상품 수정 화면 구현
![enroll1](https://user-images.githubusercontent.com/84059338/152953424-d6fcbc3d-49c9-4b7e-8067-5de7dd5e8805.gif)
&nbsp;&nbsp;&nbsp;&nbsp;
![enroll2](https://user-images.githubusercontent.com/84059338/152956453-3937c331-f2d9-4d81-ba14-1be23c66275e.gif)   
<br/>
![enroll44 mov](https://user-images.githubusercontent.com/84059338/152967287-5ecf6eca-0e6f-4ef0-ab34-8642e73e4a60.gif)

* 앨범의 이미지를 멀티픽하기 위해선 오픈 라이브러리나 IOS 14이상의 기능이 필요했기 때문에, Custom 앨범을 만들어 사용했습니다.
* 이미지를 한번에 5장까지만 등록할 수 있게 제한하고, 선택한 이미지 갯수를 표시했습니다.
* 포토앨범에서 선택한 이미지를 버튼 클릭으로 취소할 수 있는 기능을 구현했습니다.
* Protocol을 채택한 타입을 넣어줘서, 하나의 ViewController가 등록 또는 수정 화면이 될 수 있게 했습니다.
* 사용자가 문자입력시 keyboard가 화면을 가리지 않게 처리했습니다.
<br/>

## Setp3 - 마켓 리스트의 상품 선택시 Detail 화면으로 이동 및 Detail 화면에서 글 삭제, 수정 기능 구현
![modify](https://user-images.githubusercontent.com/84059338/152961580-ddce95f5-67ef-445a-aa5c-d4cf22e213a3.gif)
&nbsp;&nbsp;&nbsp;&nbsp;
![delete](https://user-images.githubusercontent.com/84059338/152969298-c68c3cab-1269-4b62-9e57-91afdee28cf9.gif)  
<br/>
![fail](https://user-images.githubusercontent.com/84059338/152968990-ff170e6f-7828-41ea-8c8d-e6c1d09ec0a0.gif)

* Detail 화면을 통한 수정시, alert으로 password를 확인해서 맞을 경우에만 수정 화면으로 이동하도록 구현했습니다.
* 등록, 수정, 삭제시 작업이 완료되면 refresh된 이전 화면으로 돌아가도록 구현했습니다.
* pageControl을 통해 Detail 화면에서 이미지 순서를 확인하고 scroll할 수 있게 구현했습니다.
<br/>

## 고민한 부분

### 이미지 지연 로딩 처리
* 이미지를 받아오는데 시간이 걸리게 되고, `collectionView`의 셀은 재사용하기 때문에, 마켓 리스트를 빠르게 스크롤하게 되면 재사용 되는 셀에 여러 이미지 요청이 겹쳐서 원하지 않는 이미지가 그려질 수 있습니다.   
* 현재 어플리케이션은 이미지 용량이 작아서 이러한 문제가 자주 발생하지 않아 cache로도 어느정도 문제를 해소할 수 있지만, 발생할 수 있는 경우를 생각해서 이미지 지연 로딩 처리를 구현하고자 했습니다.
```swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: changeIdentifier, for: indexPath) as? ProductCell else {
    return UICollectionViewCell() 
    }
	let productForItem = productList[indexPath.item]
	URLSession.shared.dataTask(with: request) { data, response, error in
		if let data = data {
			let image = UIImage(data: data)
			DispatchQueue.main.async {
				if let cellIndexPath = collectionView.indexPath(for: cell),
                                       cellIndexPath == indexPath {
					      cell.thumbnailImage.image = image
				}
			}
		}
	}
}
```
* 위 코드처럼 처음 호출한 `indexPath`와 화면에 나타나는 `cellIndexPath`가 같으면 이미지를 넣어주는 방식으로 문제를 해결하려고 했습니다.
* 위 코드는 `tableView`에서는 잘 동작하지만, `collectionView`에서는 문제가 생겼습니다. `collectionView`는 `collectionView.isPrefetchingEnabled = true`가 default 값으로 지정되어 있어서 화면에 보이지 않는 cell의 값을 미리 받아오게 됩니다. 화면에 나타나는 `cellIndexPath`가 없어서, `cellIndexPath == indexPath`가 성립하지 않아서 `image`가 nil이 되는 문제가 생깁니다.
```swift
class ProductCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    private var imageDataTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDataTask?.cancel()
        thumbnailImage.image = nil
    }
    private func imageConfigure(product: Product, imageManager: ImageManager) {
        if let successImage = product.thumbnails.first {
            imageDataTask = imageManager.fetchImage(url: successImage) { image in
                DispatchQueue.main.async {
                    switch image {
                    case .success(let image):
                        self.thumbnailImage.image = image
                    case .failure(let error):
                        self.thumbnailImage.image = #imageLiteral(resourceName: "LoadedImageFailed")
                        debugPrint(error.errorDescription)
                    }
                }
            }
        }
    }
}
```
* 위 코드처럼 cell이 재사용될 때 `imageDataTask?.cancel()`하여 재사용되기 이전의 네트워크 요청은 무시하고, 재사용 이후의 요청만 허용하는 방법으로 구현했습니다.
<br/>

### CompositionalLayout 타입화
* 현재 어플리케이션에서 화면마다 collectionView를 사용하기 때문에 `CompositionalLayout`을 여러번 사용해야 했습니다. 반복 코드를 줄이고 재사용성을 향상시키기 위해 타입으로 만들어서 사용하고자 했습니다.
* 타입으로 구현하게 되니 실행시 전달 받아야할 매개변수가 너무 많아졌습니다. 많은 매개변수 중에서 사용하지 않는 매개변수를 지정해야했고, 매개변수의 순서가 잘못 되었을 때는 오류가 나기도 했습니다. 또한 가독성에도 문제가 있었습니다. `builder Pattern`을 사용하여 필요한 프로퍼티만 전달받으면 되도록 구현했습니다. 
```swift
struct CompositionalLayoutDirector {
    func createMainList() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setViewMargin(NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        return builder.build()
    }
    
    func createMainGrid() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setPortraitHorizontalSize(.fractionalWidth(1/2))
            .setLandscapeHorizontalSize(.fractionalWidth(1/4))
            .setPortraitVerticalSize(.absolute(250))
            .setCellMargin(
                NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .setViewMargin(
                NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        return builder.build()
    }
```
<br/>

### ViewController의 기능 분배
* MVC 패턴에선 `ViewController`가 비대해진다는 단점이 있습니다. 최대한 `ViewController`의 기능을 분배하여 많은 책임을 지지 않게 하려고 노력했습니다.
* `ViewController`에 구현되어야 될 기능을 `PhotoAlbumManager`, `KeyboardManager` 등 타입으로 만들어서 기능을 분배하거나, `CollectionView`의 `dataSource`, `Delegate` 타입을 따로 만들어서 구현했습니다.
* `ViewController`가 `dataSource`나 `Delegate`와 data 전달을 주고 받을 때, `delegate 패턴`, `Notification`, `KVO`, `closure`를 사용하게 되어 쉬운길을 어렵게 가는게 아닌가 하는 생각도 들었지만, 어플리케이션을 수정하거나 확장하게 됐을 때 기능이 분리되어 있는게 작업에 용이한 방법이라 생각되어 이같은 방법으로 구현했습니다.

