### 👨‍🔧 flutter_calendar

### 🤷‍♂️ What
DB CRUD 기능을 곁들인 캘린더 앱입니다.

### 🚀 How
#### iOS 15.5
    날짜 선택 및 이동

![Jun-15-2022 13-09-07](https://user-images.githubusercontent.com/85836879/173736386-6dfab343-adb2-44ea-b24b-264faa232dce.gif)

    일정 생성 기능

![just_insert](https://user-images.githubusercontent.com/85836879/173736101-d2785bb2-ba10-4451-bc76-534cd6c9bea0.gif)

    유효성 검사 후 일정 생성 기능

![validation_insert](https://user-images.githubusercontent.com/85836879/173736299-a1058b96-583e-4367-991b-030025a74f9f.gif)

    일정 조회 및 업데이트 기능

![update](https://user-images.githubusercontent.com/85836879/173736450-797fa61c-03d2-4792-81a7-c4a61b562d30.gif)

    일정 삭제 기능 

![calandar_delete](https://user-images.githubusercontent.com/85836879/173736504-4219e79d-7805-4bd5-beb1-15e4347dc1e6.gif)



### 💡 Tips
Form 위젯에 속한 TextFormField의 validator 속성을 컨트롤해 서로 다른 유효성 검사를 할 수 있습니다.

pubspec.yaml에서 의존성 버전 충돌이 생긴다면

    path 1.8.1 and flutter_calendar depends on path ^1.8.2, flutter_test from sdk is forbidden.

    dependency_overrides:
        path: ^1.8.2

옵션을 통해 충돌이 나는 의존성을 해결할 수 있습니다.


### 📖 Review
StreamBuilder와 FutureBuilder의 반환값으로 반응형 앱을 구현할 수 있었다.

Drift로 SQLite의 ORM을 채택하였는데 
이전에 프로젝트에서 경험했던 Java의 JPA와 많이 비슷하여 CRUD를 구현하는데 수월했다.

DateTime과 DateTime.utc가 전혀 다르다는 사실을 알게되어 이후에 글로벌 앱을 제작할 떄 도움이 많이 될듯하다.

GetIt으로 SQLite의 상태값을 다루어 위젯별로 인자를 적게 주고받아서 코드짜는게 수월했다.

