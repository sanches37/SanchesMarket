## 프로젝트 설명
* GET, POST, PATCH, DELETE 기능을 이용한 마켓 어플리케이션
* 야곰아카데미에서 수행했던 오픈마켓 프로젝트를 포트폴리오로 쓰기 위해 완성 및 리팩토링하였습니다.

## 프로젝트 진행시 지키려고 한 사항
* 오픈 라이브러리를 사용하지 않았습니다.
* IOS 13끼지의 기능들만 사용했습니다.
* MVC패턴으로 구현하였고, ViewController의 기능을 최대한 분리하고자 노력했습니다.
* 가로화면에서도 동작할 수 있도록 구현했습니다.

## Step1 - 네트워크시 사용할 모델 구현 및 GET으로 요청한 데이터로 마켓 리스트 구현
![ListScroll](https://user-images.githubusercontent.com/84059338/152946778-5e47b1a7-b54a-47cf-b727-de5a0598f2e6.gif)
![gridView](https://user-images.githubusercontent.com/84059338/152945029-d59fcbcb-da01-4bfb-8c0e-ba969c63ae56.png)

* Protocol을 채택한 HTTP메서드 타입을 매개변수로 넣어주어, 하나의 메서드로 네트워크를 처리하도록 구현했습니다.
* ParsingManager 타입을 통해 구현한 모델타입으로 디코딩했습니다.
* 의존성 주입을 통한 네트워크 무관테스트를 구현했습니다.
* 마켓 리스트 화면을 List와 Grid형식으로 구현하기 위해 CollectionView를 사용했습니다.
* CompositionalLayout을 사용했고, builder Pattern으로 CompositionalLayout을 타입으로 만들어 사용했습니다.
* URLCache를 이용해서 Cache 기능을 구현했습니다.
* pagenation을 구현하여 현재 페이지를 모두 스크롤 한뒤 다음 페이지를 받아오도록 했습니다.

## Step2 - POST, PATCH를 사용한 상품 등록 및 상품 수정 화면 구현
![enroll1](https://user-images.githubusercontent.com/84059338/152953424-d6fcbc3d-49c9-4b7e-8067-5de7dd5e8805.gif)
![enroll2](https://user-images.githubusercontent.com/84059338/152956453-3937c331-f2d9-4d81-ba14-1be23c66275e.gif)
![enroll3](https://user-images.githubusercontent.com/84059338/152955789-f989e95d-23f7-461c-9b9e-084cf9341309.gif)

* 앨범의 이미지를 멀티픽하기 위해선 오픈 라이브러리나 IOS 14이상의 기능이 필요했기 때문에, Custom 앨범을 만들어 사용했습니다.
* 이미지를 한번에 5장까지만 등록할 수 있게 제한하고, 선택한 이미지 갯수를 표시했습니다.
* 포토앨범에서 선택한 이미지를 버튼 클릭으로 취소할 수 있는 기능을 구현했습니다.
* Protocol을 채택한 타입을 넣어줘서, 하나의 ViewController가 등록 또는 수정 화면이 될 수 있게 했습니다.
* 사용자가 문자입력시 keyboard가 화면을 가리지 않게 처리했습니다.

## Setp3 - 마켓 리스트 선택시 Detail 화면으로 이동 및 Detail 화면에서 글 삭제, 수정 기능 구현

* Detail 화면을 통한 수정시, alert으로 password를 확인해서 맞을 경우에만 수정 화면으로 이동하도록 구현했습니다.
* 수정 화면에서 수정이 정상적으로 완료되면 refresh된 Detail 화면으로 돌아가도록 구현했습니다.
* 등록 화면에서 등록이 정상적으로 완료되면 refresh된 마켓 리스트로 돌아가도록 구현했습니다.
* Detail 화면을 통한 삭제시, 삭제가 완료되면 refresh된 마켓 리스트로 돌아가도록 구현했습니다.


