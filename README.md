
![APP Icon](https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/2c9f1084-20f6-4b80-8320-d39b0336a840)

### [출시] 내집마련 | 2024.03.08 ~ 2024.03.24 (16일), 업데이트 중

<aside>
⭐ 어려운 임장, 이젠 내집마련과 함께
  
대부분의 사람들은 부동산을 매매하기 전에 임장을 다녀오곤 합니다. 그러나 부동산 투자를 원하지만 부동산 임장을 ‘어려운 일’ 이라고 생각하는 사람들이 있습니다. 저는 그런 사람들을 타겟으로 설정하여 부동산 임장 시 조금 더 쉽게 체크리스트들을 확인 및 체크하고, 손 쉽게 비교할 수 있는 앱 입니다.

</aside>


![homeddd](https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/125fd327-0b0a-46fa-aef7-65df7f098e0e)



### 🔗 앱스토어 링크

[<img width="220" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://user-images.githubusercontent.com/55099365/196023806-5eb7be0f-c7cf-4661-bb39-35a15146c33a.png">](https://apps.apple.com/kr/app/%EB%82%B4%EC%A7%91%EB%A7%88%EB%A0%A8-%EB%82%B4-%EC%A7%91%EC%9D%84-%EC%9C%84%ED%95%9C-%EB%B6%80%EB%8F%99%EC%82%B0-%EC%9E%84%EC%9E%A5%EA%B8%B0%EB%A1%9D/id6479473879)



### 🧑‍🤝‍🧑 팀, 프로젝트 구성

- 1인 개발
- iOS 16.0+

### 🔨 기술 스택 및 사용한 라이브러리

- UIKit / SnapKit
- MVVM
- Observable Pattern
- Realm
- Firebase Analytics / Crashtics
- TestFlight

### 🥕 기능

- Map Annotation 기반 건물 조회 기능
- 임장 체크리스트 작성 / 저장
- 건물 검색

### 👏 해당 기술을 사용하며 이룬 성과

- Realm Reopository Pattern과 Generic을 통한 모듈화

~~~swift
final class RealmDataManager {
    
    private var realm: Realm = {
        return try! Realm()
    }()
    
    func fetchData<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func saveData<T: Object>(_ data: T) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    // ....
}
~~~

- Firebase Analytics 및 Crashlytics를 활용하여 앱의 성능 및 안정성 향상
- TestFlight를 이용하여 베타테스트 경험

### 🌠 Trouble Shooting

#### 1. Map Annotation을 터치할때마다 요청하여 중복되는 API 요청이 자주 발생될 우려, Alamofire의 Session cachePolicy를 returnCacheDataElseLoad로 설정하여 캐싱의 우선순위를 높여 반복되는 요청 처리

~~~swift
func request<T: Decodable>(_ api: APIkind, _ type: T.Type, completionHandler: @escaping (T?, APIError?) -> ()) {
    AF.request(api.url, parameters: api.parameter, headers: api.header) { request in
        // cachePolicy 설정
        request.cachePolicy = .returnCacheDataElseLoad
    }.responseDecodable(of: T.self) { response in
        debugPrint(response)
        switch response.result {
        case .success(let success):
            completionHandler(success, nil)
            return
        case .failure(_):
            completionHandler(nil, .error)
        }
    }
}
~~~

#### 2. Realm과 API로 받아오는 Model이 상이하여 값 전달 데이터 일관성 이슈, 데이터를 전달하는 공통의 DTO Model을 이용, init을 여러개 만들어 데이터 일관성을 높이고 코드의 가독성을 용이하게 설계  
~~~swift
final class SearchToMapDataPassingModel {
    let lat: Double
    let lng: Double
    let address: String
    let symbol: String

    init(from data: NaverGeocodingModel) {
        self.lat = data.lat
        self.lng = data.lng
        self.address = data.address
        self.symbol = data.symbol
    }

    init(from data: SearchHistoryModel) {
        self.lat = data.latitude
        self.lng = data.longitude
        self.address = data.roadAddressName
        self.symbol = data.symbol
    }

    init(lat: Double, lng: Double, address: String, symbol: String) {
        self.lat = lat
        self.lng = lng
        self.address = address
        self.symbol = symbol
    }
}
~~~

### 🗂️ 폴더 구조
~~~
📦BuyingMyHome
 ┣ 📂Enum
 ┣ 📂Extension
 ┣ 📂Font
 ┣ 📂Model
 ┣ 📂Protocol
 ┣ 📂Scene
 ┃ ┣ 📂AddEditScene
 ┃ ┣ 📂ArchiveScene
 ┃ ┣ 📂Base
 ┃ ┣ 📂CheckListScene
 ┃ ┣ 📂MapScene
 ┃ ┣ 📂OnboardingScene
 ┃ ┣ 📂SearchScene
 ┃ ┗ 📂TabScene
 ┗ 📂Service
~~~

| 뷰 | 이미지 |
| --- | --- |
| 메인 뷰 | <img src="https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/9b8ce277-f4e7-4cbc-a4f2-4c7abec656ea" width="188" height="408"> |
| 검색 뷰 | <img src="https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/892673ab-c8d9-474c-9c3b-0a3cf821ee6e" width="188" height="408"> |
| 보관함 뷰 | <img src="https://github.com/Oreo-Mcflurry/BuyingMyHome/assets/96654328/12ad34b1-506c-4d2a-8db5-ae5e608e67ce" width="188" height="408"> |

