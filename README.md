### 👨‍🔧 flutter_calendar

#### 🤷‍♂️ What
SQLite 이용한 캘린더 앱입니다.

#### 🚀 How

#### 💡 Tips
Form 위젯에 속한 TextFormField의 validator 속성을 컨트롤해 서로 다른 유효성 검사를 할 수 있습니다.

pubspec.yaml에서 의존성 버전 충돌이 생긴다면

    path 1.8.1 and flutter_calendar depends on path ^1.8.2, flutter_test from sdk is forbidden.

    dependency_overrides:
        path: ^1.8.2

옵션을 통해 충돌이 나는 의존성을 해결할 수 있습니다.


#### 📖 Review
StreamBuilder와 FutureBuilder의 반환값으로 반응형 앱을 구현할 수 있었다.

Drift로 SQLite의 ORM을 채택하였는데 
이전에 프로젝트에서 경험했던 Java의 JPA와 많이 비슷하여 CRUD를 구현하는데 수월했다.

DateTime과 DateTime.utc가 전혀 다르다는 사실을 알게되어 이후에 글로벌 앱을 제작할 떄 도움이 많이 될듯하다.

GetIt으로 SQLite의 상태값을 다루어 위젯별로 인자를 적게 주고받아서 코드짜는게 수월했다.

