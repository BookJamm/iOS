<div align="center">
  
  ![header](https://capsule-render.vercel.app/api?type=wave&color=auto&height=280&section=header&text=Bookjamm-iOS&fontSize=90)
  <br><br>
  <img src="https://img.shields.io/badge/Xcode-14.3.1-blue?logo=Xcode"/>
  <img src="https://img.shields.io/badge/Swift-5.0-red?logo=swift"/>
  <img src="https://img.shields.io/badge/iOS-15.0+-black?logo=apple"/>  
  [![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FBookJamm%2FFE&count_bg=%23FF4343&title_bg=%23FFC8C8&icon=swift.svg&icon_color=%23FF4F4F&title=total+hits&edge_flat=false)](https://hits.seeyoufarm.com)
</div>

<div align=center>

# 🍎 Team iOS Members 🍎
  
<img width="200px" src="https://avatars.githubusercontent.com/u/80394340?v=4"/> | <img width="200px" src="https://avatars.githubusercontent.com/u/99167099?v=4"/> | <img width="200px" src="https://avatars.githubusercontent.com/u/125115284?v=4"/> |
|:-----:|:-----:|:-----:|
|[이유진 (Zimging)](https://github.com/youz2me)|[장준모 (Jangmo)](https://github.com/Jangjoonmo)|[박민서 (Lamp)](https://github.com/FpRaArNkK)|
|팀원 👩‍💻|팀원 🧑‍💻|팀원 🧑‍💻|

<br>

# 📄 Rules 📄

</div>

## Navigation
1. [Branch Rules](#branch-rules)
2. [Commit Rules](#commit-rules)
3. [Pull Request Rules](#pull-request-rules)
4. [Issue Rules](#issue-rules)

## Branch Rules
[참고자료](https://www.inbogi.com/bok/2020/04/1/) <br><br>
효율적인 버전관리와 충돌을 방지하기 위해 팀원은 목적에 따른 브랜치를 분기해 그 안에서만 작업해야 합니다.

### Main Branch
#### 브랜치 이름 : `Main` <br>
최종 배포가 가능한 상태만을 관리하는 브랜치입니다. <br>
배포 이력을 관리하기 위한 브랜치이므로 배포 이전까지는 병합하지 않을 예정입니다.

### Develop Branch
#### 브랜치 이름 : `Develop` <br>
배포 버전을 개발하는 브랜치입니다. <br>
이 브랜치를 기반으로 기능을 추가하고 버그 없이 안정적으로 배포가 가능한 상태인 경우만 `Main branch`에 병합합니다.

### ⭐️ Feature Branch
#### 브랜치 이름 : `Feature/<이슈번호>-<기능명>` <br> 브랜치 이름 예시 : `Feature/1-login`, `Feature/2-main-library-list` <br>
개발 시 가장 많이 사용하게 될 브랜치입니다. 기능을 개발하는 브랜치로, `Develop Branch`에서 분기합니다. <br>
개발이 완료되면 `Develop Branch`로 병합해 다른 사람과 공유하고, 개발이 완료되어 더이상 필요하지 않은 `Feature Branch`는 삭제합니다.

### Release Branch
#### 브랜치 이름 : `Release/<버전명>` <br>
버전 출시 직전 이용하게 될 브랜치입니다. <br>
기능 수정 없이 테스트를 통한 최종적인 버그 수정이나 문서 추가 등의 단계를 수행할 때 사용합니다.

## Commit Rules
[참고자료](https://beomseok95.tistory.com/328) <br><br>
일관성 없는 커밋 메시지는 어떤 작업을 했는지 명확하게 알아볼 수 없거나 추후 커밋 히스토리를 파악하는 데 어려움을 줄 수 있습니다. <br>
반대로 네이밍(naming)을 명시적이고 규칙적으로 작성하고 해당 커밋에 대한 내용을 잘 작성한다면 코드를 일일히 분석하지 않아도 해당 커밋의 내용을 알아볼 수 있어요! 👀

1. 제목과 본문을 `빈 행으로 구분` 합니다.
2. 제목을 `50글자 이내` 로 제한합니다.
3. 제목의 첫 글자는 `대문자` 로 작성합니다.
4. 제목의 끝에는 `마침표를 넣지 않습니다`.
5. 제목은 `명령문` 으로 작성하고 `과거형을 사용하지 않습니다`.
6. 본문의 `각 행은 72글자 내로 제한`합니다.
7. 어떻게 보다는 `무엇` 과 `왜` 를 설명합니다.

### Commit Message 구조
헤더는 필수이며, 범위(scope), 본문(body), 바닥글(footer)은 선택사항입니다.
```
<type>(<scope>): <subject>          -- 헤더
<BLANK LINE>
<body>                              -- 본문
<BLANK LINE>
<footer>                            -- 바닥글
```

`type`은 해당 커밋의 성격을 나타내며 아래 중 하나여야 합니다.
```
Feat : 새로운 기능에 대한 커밋
Fix : 버그 수정에 대한 커밋
Build : 빌드 관련 파일 수정에 대한 커밋
Chore : 그 외 자잘한 수정에 대한 커밋
Ci : CI관련 설정 수정에 대한 커밋
Docs : 문서 수정에 대한 커밋
Style : 코드 스타일 혹은 포맷 등에 관한 커밋
Refactor :  코드 리팩토링에 대한 커밋
Test : 테스트 코드 수정에 대한 커밋
```

`body`는 본문으로 헤더로 표현할 수 없는 상세한 내용을 적습니다.
헤더로 표현이 가능하다면 생략 가능합니다.

`footer`는 바닥글로 어떤 이슈에서 왔는지 같은 참조 정보들을 추가하는 용도로 사용합니다.
예를 들어 특정 이슈를 참조하려면 close #1 과 같이 추가하면 됩니다.
close는 이슈를 참조하면서 main 브랜치로 푸시될 때 이슈를 닫게 됩니다.

### Commit message 예시
```
Feat: 애플 로그인 기능 추가(#1)

간편 로그인 기능 추가를 위해 애플 로그인 기능을 추가함

해결: close #1
```

## Pull Request Rules
[참고자료](https://velog.io/@pppp0722/커밋-메시지-PR-규칙) <br><br>
PR은 분기한 브랜치(`Feature Branch`)에서 기능 개발이 끝난 경우 `Develop Branch`로 병합하기 위해 사용합니다. <br><br>
<img width="1051" src="https://github.com/BookJamm/FE/assets/80394340/1c53a33c-2432-4b37-a1b9-6c861c4add44"> <br><br>
준비된 PR 템플릿에 맞게 내용을 작성하고, 반드시 타 팀원의 `review`가 완료된 후 `Develop Branch`로 병합되어야 합니다. PR이 올라오면 `review` 를 꼭 작성해주세요.

## Issue Rules
[참고자료](https://didu-story.tistory.com/278) <br><br>
Issue는 `기능을 구현`하거나, `버그가 발생해 해결`할 때 함께 작성합니다. <br><br>
<img width="1428" src="https://github.com/BookJamm/FE/assets/80394340/d99b3d51-e060-4083-b2ee-636c8c004d5c"> <br><br>
Issue 탭에서 주제에 맞게 `Feature Template` 또는 `Bug Template`를 선택하고, 이미 짜여진 양식에 맞게 Issue를 작성합니다. <br>
Issue에 맞는 라벨도 다음과 같이 할당한 뒤 Issue를 생성합니다. <br>
```
1. 어떤 이슈인지 (Bug / Chore / Docs / Feat / UI / Refactor / Test / Question)
2. 누가 담당하고 있는지 (Zimging / Jangmo)
3. 어떤 View에서 이루어지고 있는지 (View 이름을 label에 추가, 없으면 새로 만들기)
```
이후 Issue와 관련한 Commit에는 Issue 번호를 `footer`에 붙여 Issue를 참조할 수 있도록 합니다. <br>

</div>
