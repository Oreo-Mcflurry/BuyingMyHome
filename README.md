
![APP Icon](https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/2c9f1084-20f6-4b80-8320-d39b0336a840)

## [출시] 내집마련 (2024.03 ~ ing)

<aside>
⭐ 어려운 임장, 이젠 내집마련과 함께
  
대부분의 사람들은 부동산을 매매하기 전에 임장을 다녀오곤 합니다. 그러나 부동산 투자를 원하지만 부동산 임장을 ‘어려운 일’ 이라고 생각하는 사람들이 있습니다. 저는 그런 사람들을 타겟으로 설정하여 부동산 임장 시 조금 더 쉽게 체크리스트들을 확인 및 체크하고, 손 쉽게 비교할 수 있도록 하였습니다.

</aside>

![스크린샷 2024-03-24 21 30 36](https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/1a18ee4b-d02d-498c-8718-be786f05c475)

## 🔗 앱스토어 링크

[<img width="220" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://user-images.githubusercontent.com/55099365/196023806-5eb7be0f-c7cf-4661-bb39-35a15146c33a.png">](https://apps.apple.com/kr/app/%EB%82%B4%EC%A7%91%EB%A7%88%EB%A0%A8-%EB%82%B4-%EC%A7%91%EC%9D%84-%EC%9C%84%ED%95%9C-%EB%B6%80%EB%8F%99%EC%82%B0-%EC%9E%84%EC%9E%A5%EA%B8%B0%EB%A1%9D/id6479473879)



## 🧑‍🤝‍🧑 팀구성

- 1인 개발

### 🔨 기술 스택 및 사용한 라이브러리

- UIKit / SnapKit
- MVVM
- Observable Pattern
- Input / Output Pattern
- Realm
- Firebase Analytics / Crashtics
- Alamofire
- Tabman
- TestFlight

### 👏 해당 기술을 사용하며 이룬 성과

- Realm Reopository Pattern과 Generic을 통한 모듈화
- Alamofrie와 Generic을 통한 모듈화
- Tabman을 활용하여 UI구현 시간 단축
- Firebase Analytics 및 Crashlytics를 활용하여 앱의 성능 및 안정성 향상
- TestFlight를 이용하여 베타테스트 경험

### 📝 성과 및 결과

- 3/25일부로 출시 되었습니다.
- 추후 업데이트로 리팩토링 및 기능 업데이트를 할 예정입니다.

### 🌠 Trouble Shooting 및 배운 점

- 추가하기 / 수정하기 뷰의 클로저 구문에서 메모리 누수가 발생하여 weak를 통해 해결하였습니다.
- 지도를 클릭할때마다 API Request를 하여 비효율 적인 네트워크 통신이 발생하여 Alamofire의 캐싱 기능으로 해결하였습니다.
- UIScrollView를 사용할 때, Constraints, 특히 Bottom을 잘 설정해주지 않는 경우에 화면에는 정상적으로 표기가 되지만 UITextField의 경우 입력 등의 제스처에 제한이 생긴다는 점을 배웠습니다.

### 📋 Post Mortem

- 리젝 사유
  - 검색기능을 사용해서 검색하였는데 아무것도 안나왔다는 내용으로 리젝을 받았습니다.
  - Naver Map특성상 외국의 주소는 나오지 않아 몇개의 한국의 주소를 샘플로 보내어 대응하였습니다.
- 업데이트 사항
  - 카메라나 앨범에서 사진을 선택하여 같이 저장할 수 있게 만들 예정입니다.
  - RxSwift를 배워 리팩토링을 해볼 예정입니다.
  - 아카이브 탭에서 삭제 기능을 구현 할 예정입니다.
  - 폴더 기능을 구현 할 예정입니다.
  - 온보딩 뷰를 구현 할 예정입니다.
- 아쉬웠던 점
  - 개발 초기부터 MVP의 단위를 제대로 정하지 못해 우왕자왕하였던점이 아쉬웠습니다.
  - 개발 초기에 Map의 Gecoding은 Mapkit을, Map은 Naver Map을, 검색은 Kakao 기반으로 검색을 구현하여서 각각 검색과 지도 등의 정보의 간극이 생겼습니다. 이를 초기 / 기획 단계에서 검증하지 않았던 점이 아쉬웠습니다.
