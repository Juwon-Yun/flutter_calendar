### ๐จโ๐ง flutter_calendar

### ๐คทโโ๏ธ What
DB CRUD ๊ธฐ๋ฅ์ ๊ณ๋ค์ธ ์บ๋ฆฐ๋ ์ฑ์๋๋ค.

### ๐ How

<details>
    <summary> iOS 15.5 </summary>

    ๋ ์ง ์ ํ ๋ฐ ์ด๋ ๊ธฐ๋ฅ

![Jun-15-2022 13-09-07](https://user-images.githubusercontent.com/85836879/173736386-6dfab343-adb2-44ea-b24b-264faa232dce.gif)

    ์ผ์  ์์ฑ ๊ธฐ๋ฅ

![just_insert](https://user-images.githubusercontent.com/85836879/173736101-d2785bb2-ba10-4451-bc76-534cd6c9bea0.gif)

    ์ ํจ์ฑ ๊ฒ์ฌ ํ ์ผ์  ์์ฑ ๊ธฐ๋ฅ

![validation_insert](https://user-images.githubusercontent.com/85836879/173736299-a1058b96-583e-4367-991b-030025a74f9f.gif)

    ์ผ์  ์กฐํ ๋ฐ ์๋ฐ์ดํธ ๊ธฐ๋ฅ

![update](https://user-images.githubusercontent.com/85836879/173736450-797fa61c-03d2-4792-81a7-c4a61b562d30.gif)

    ์ผ์  ์ญ์  ๊ธฐ๋ฅ 

![calandar_delete](https://user-images.githubusercontent.com/85836879/173736504-4219e79d-7805-4bd5-beb1-15e4347dc1e6.gif)

</details>

<details>
    <summary> Andriod API 33 </summary>

    ๋ ์ง ์ ํ ๋ฐ ์ด๋ ๊ธฐ๋ฅ

![select_date](https://user-images.githubusercontent.com/85836879/173739957-bd0437ec-87fd-4b85-801f-52365c75f980.gif)

    ์ผ์  ์์ฑ ๊ธฐ๋ฅ

![just_insert](https://user-images.githubusercontent.com/85836879/173739954-4bc01ab2-a574-4341-8ae8-b2e36d32060d.gif)

    ์ ํจ์ฑ ๊ฒ์ฌ ํ ์ผ์  ์์ฑ ๊ธฐ๋ฅ

![validation_insert](https://user-images.githubusercontent.com/85836879/173739966-8a91a670-c7ab-4739-af2a-7c6dfa27ddf4.gif)

    ์ผ์  ์กฐํ ๋ฐ ์๋ฐ์ดํธ ๊ธฐ๋ฅ

![update](https://user-images.githubusercontent.com/85836879/173739963-d23cce1d-406b-440d-9458-e6b3af02746e.gif)

    ์ผ์  ์ญ์  ๊ธฐ๋ฅ 

![delete_schedule](https://user-images.githubusercontent.com/85836879/173739948-49bffaf6-64fc-4cd1-ac7d-8229300d4d9d.gif)
    
</details>

### ๐ก Tips
Form ์์ ฏ์ ์ํ TextFormField์ validator ์์ฑ์ ์ปจํธ๋กคํด ์๋ก ๋ค๋ฅธ ์ ํจ์ฑ ๊ฒ์ฌ๋ฅผ ํ  ์ ์์ต๋๋ค.

pubspec.yaml์์ ์์กด์ฑ ๋ฒ์  ์ถฉ๋์ด ์๊ธด๋ค๋ฉด

    path 1.8.1 and flutter_calendar depends on path ^1.8.2, flutter_test from sdk is forbidden.

    dependency_overrides:
        path: ^1.8.2

์ต์์ ํตํด ์ถฉ๋์ด ๋๋ ์์กด์ฑ์ ํด๊ฒฐํ  ์ ์์ต๋๋ค.


### ๐ Review
StreamBuilder์ FutureBuilder์ ๋ฐํ๊ฐ์ผ๋ก ๋ฐ์ํ ์ฑ์ ๊ตฌํํ  ์ ์์๋ค.

Drift๋ก SQLite์ ORM์ ์ฑํํ์๋๋ฐ 
์ด์ ์ ํ๋ก์ ํธ์์ ๊ฒฝํํ๋ Java์ JPA์ ๋ง์ด ๋น์ทํ์ฌ CRUD๋ฅผ ๊ตฌํํ๋๋ฐ ์์ํ๋ค.

DateTime๊ณผ DateTime.utc๊ฐ ์ ํ ๋ค๋ฅด๋ค๋ ์ฌ์ค์ ์๊ฒ๋์ด ์ดํ์ ๊ธ๋ก๋ฒ ์ฑ์ ์ ์ํ  ๋ ๋์์ด ๋ง์ด ๋ ๋ฏํ๋ค.

GetIt์ผ๋ก SQLite์ ์ํ๊ฐ์ ๋ค๋ฃจ์ด ์์ ฏ๋ณ๋ก ์ธ์๋ฅผ ์ ๊ฒ ์ฃผ๊ณ ๋ฐ์์ ์ฝ๋์ง๋๊ฒ ์์ํ๋ค.

Key ๊ฐ์ฒด๋ฅผ ์ด์ฉํด์ delete ์ฟผ๋ฆฌ์ ํ์ํ ์ ๋ํฌ ํค๋ฅผ ์ ๊ณตํ์๋ค!

Intl ํจํค์ง๋ฅผ ์ด์ฉํด ์ฑ์ด ์ผ์ง๋ฉฐ ์ด๊ธฐํ๋  ๋ ํ๊ตญ ์ธ์ด๋ฅผ ์ฌ์ฉํ๋ค.
GetX์ Locale ๊ฐ์ฒด๋ ์์ง๋ง Intl์ด ๋ ๊ฐ๋ฒผ์ด ์ฅ์ ์ด ์์ด ์ฐจํ์ ๋ค๊ตญ์ด ๊ธฐ๋ฅ๋ง ๊ตฌํ์ด ํ์ํ ๊ฒฝ์ฐ
๋ ์จ์ผ๊ฒ ๋ค.
