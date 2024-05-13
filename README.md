
![APP Icon](https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/2c9f1084-20f6-4b80-8320-d39b0336a840)

### [출시] 내집마련 | 2024.03.08 ~ 2024.03.24 (16일), 업데이트 중

<aside>
⭐ 어려운 임장, 이젠 내집마련과 함께
  
대부분의 사람들은 부동산을 매매하기 전에 임장을 다녀오곤 합니다. 그러나 부동산 투자를 원하지만 부동산 임장을 ‘어려운 일’ 이라고 생각하는 사람들이 있습니다. 저는 그런 사람들을 타겟으로 설정하여 부동산 임장 시 조금 더 쉽게 체크리스트들을 확인 및 체크하고, 손 쉽게 비교할 수 있도록 하였습니다.

</aside>


![myhome](https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/2ea58ad0-cf39-44b6-a7b6-8bbeadd0a16a)



### 🔗 앱스토어 링크

[<img width="220" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://user-images.githubusercontent.com/55099365/196023806-5eb7be0f-c7cf-4661-bb39-35a15146c33a.png">](https://apps.apple.com/kr/app/%EB%82%B4%EC%A7%91%EB%A7%88%EB%A0%A8-%EB%82%B4-%EC%A7%91%EC%9D%84-%EC%9C%84%ED%95%9C-%EB%B6%80%EB%8F%99%EC%82%B0-%EC%9E%84%EC%9E%A5%EA%B8%B0%EB%A1%9D/id6479473879)



### 🧑‍🤝‍🧑 팀구성

- 1인 개발

### 🔨 기술 스택 및 사용한 라이브러리

- UIKit / SnapKit
- MVVM
- Observable Pattern
- Input / Output Pattern
- Realm
- Firebase Analytics / Crashtics
- TestFlight

### 👏 해당 기술을 사용하며 이룬 성과

- Realm Reopository Pattern과 Generic을 통한 모듈화
- Alamofrie와 Generic을 통한 모듈화
- Tabman을 활용하여 UI구현 시간 단축
- Firebase Analytics 및 Crashlytics를 활용하여 앱의 성능 및 안정성 향상
- TestFlight를 이용하여 베타테스트 경험

### 🌠 Trouble Shooting

- 지도를 클릭할때마다 API Request를 하여 비효율 적인 네트워크 통신이 발생하여 Alamofire의 캐싱 기능으로 해결
- 개발 초기에 Map의 Gecoding의 API는 Mapkit을, Map의 SDK는 Naver Map을, 검색 API는 Kakao Map 기반으로 검색을 구현하여서 각각 검색과 지도 등의 정보의 간극 발생
- Geocoding 하는 API를 Naver Map의 API로 통일
  - Naver Map API는 키워드 검색을 지원하지 않아 카카오로 검색 후 주소를 가져와 다시 Naver API를 호출하도록 구현

### 📋 Post Mortem

- 리젝 사유
  - 검색기능을 사용해서 검색하였는데 아무것도 안나왔다는 리젝 사유를 받음
  - Naver Map특성상 외국의 주소는 나오지 않아 몇개의 한국의 주소를 샘플로 보내어 대응
- 업데이트 사항
  - 카메라나 앨범에서 사진을 선택하여 같이 저장할 수 있게 만들 예정
  - RxSwift를 배워 리팩토링을 해볼 예정
  - 아카이브 탭에서 삭제 기능을 구현 할 예정
  - 폴더 기능을 구현 할 예정
  - 온보딩 뷰를 구현 할 예정
- 아쉬웠던 점
  - 개발 초기부터 MVP의 단위를 제대로 정하지 못해 우왕자왕하였던점
  - 개발 초기에 Map의 Gecoding은 Mapkit을, Map은 Naver Map을, 검색은 Kakao 기반으로 검색을 구현하여서 각각 검색과 지도 등의 정보의 간극이 생겼습니다. 이를 초기 / 기획 단계에서 검증하지 않았던 점
