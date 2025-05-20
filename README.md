# <img src="https://github.com/user-attachments/assets/9e796c0c-c817-4200-9bec-6c7421e71124" alt="diary_scroll" width="25"> 세담
> 프로젝트 기간: 25.05.01 - 25.05.20

## 📖 목차
1. [🍀 소개](#소개)
2. [🛠️ 기술 스택](#기술-스택)
3. [💻 실행 화면](#실행-화면)
4. [🧨 트러블 슈팅](#트러블-슈팅)
5. [📚 참고 링크](#참고-링크)
6. [📕 회고](#회고)

</br>

<a id="소개"></a>

## 🍀 소개
### 세담: 매일 적는 3단어 담화 글쓰기 서비스
세담은 일본 전통의 ‘三題噺(산다이바나시)’에서 영감을 받아 탄생했습니다. 매일 아침, 전혀 어울릴 것 같지 않은 세 가지 키워드를 제시하여 당신의 상상력과 표현력을 깨워줍니다. 짧은 단어들이 엮어 내는 새로운 연결고리를 따라가며, 일상의 소소한 순간부터 깊은 내면의 이야기까지 자유롭게 펼쳐 보세요.

</br>
<a id="기술-스택"></a>

## 🛠️ 기술 스택
`SwiftUI`, `MVVM`, `Combine`, `Swift Concurrency`

</br>

<a id="실행-화면"></a>

## 💻 실행 화면

| 메인 페이지 | 글 작성 | 내 글 목록 | 글 읽기 & 추천 |
|:--------:|:--------:|:--------:|:--------:|
|<img src="https://github.com/user-attachments/assets/31f96956-7c65-41de-ad4d-6319f2873f60" alt="diary_scroll" width="200">|<img src="https://github.com/user-attachments/assets/be355ae4-08b8-4c34-880c-25470a64fa7a" alt="diary_scroll" width="200">|<img src="https://github.com/user-attachments/assets/43530df4-389d-4610-b53b-c062e9aba0b6" alt="diary_scroll" width="200">|<img src="https://github.com/user-attachments/assets/c8c2ca06-5db4-4bd4-b4de-56a70c5807d3" alt="diary_scroll" width="200">|

</br>

<a id="트러블-슈팅"></a>

## 🧨 트러블 슈팅
###### 핵심 위주로 작성됨.
1️⃣ **Build Errors** <br>
-
🔒 **문제점** <br>
 `Undefined symbol: Testing.__Expression.__fromNegation(...)?`
테스트 타겟(Test target)과 메인 타겟 사이에 프레임워크 참조가 꼬여서 문제가 생겼다. 테스트용 프레임워크를 메인 앱 또는 테스트 타겟에 잘못 링크했거나, 빌드 설정에서 해당 모듈이 누락된 경우 혹은 타겟 간에 동일한 모듈 이름이 중복되어, 링커가 어떤 모듈을 참조해야 할지 혼동될 때 발생하는데 후자의 문제였다.


🔑 **해결방법** <br>
Xcode의 Build Phases > Link Binary With Libraries 에서 Testing.framework가 올바른 타겟에 추가되어 있는지 확인 후, Finder에서 불필요한 .testplan 파일(예: sedamTests.testplan)을 삭제하고, Xcode Scheme에서 다시 테스트 타겟을 설정하여 해결하였다.

<br>

2️⃣ **Auth 구조** <br>
-
🔒 **문제점** <br>
로그인 화면을 띄우는 방법에 대한 고민이 있었다. 초반에는 단순히 AuthenticationState에 따라 서로 다른 뷰를 그려서 넘겨주었는데, 이후 자동 로그인에 실패했다면, 로그인을 띄운 다음 AuthenticationState에 따라 서로 다른 화면을 보여줘야 하는 것과 비로그인 회원이 로그인을 앱 사용 중간에 하게 되는 경우 기존에 사용하고 있던 페이지로 되돌아가기 위해서는 다른 방법이 필요했다.


🔑 **해결방법** <br>
때문에 isLogInPresented가 true일 때 로그인 화면을 fullScreenCover로 덮는 방식을 선택하였다. 중간에 비로그인 회원이 로그인을 하게 되는 경우도 기존 화면 위에 fullScreen으로 덮었다가 돌아가는 것이기에 해당 내용을 유지하고 이어갈 수 있다. 

```swift
RouterView {
            TabContainerView()
                .fullScreenCover(
                    isPresented: $authViewModel.isLogInPresented,
                    onDismiss: {}
                ) {
                    LoginView()
                }
                .fullScreenCover(
                    isPresented: $authViewModel.isTermPresented,
                    onDismiss: {}
                ) {
                    TermView(isButtonEnabled: true)
                }
        }
```

<br>

3️⃣ **Custom Gesture is not working** <br>
-
🔒 **문제점** <br>
여러 제스처(.gesture, .highPriorityGesture, .simultaneousGesture)를 동일 뷰에 중복 적용하며 우선순위에 충돌이 일어나 Custom Gesture가 동작하지 않았다. 이에 PostCreateView에서 주변 화면을 눌러도 키보드가 내려가지 않았다. 뷰 계층 상 자식 뷰가 부모 뷰의 제스처를 가로채는 문제였다.


🔑 **해결방법** <br>
이에 먼저 제스쳐 우선 순위를 정리해주었다. 기본 .gesture → 필요 시 .highPriorityGesture 또는 .simultaneousGesture 순으로 적용했다. 또한 적용 위치를 제스쳐가 적용되어야 할 최상위 뷰에만 한 번 적용하여 중복을 제거했다. 



<a id="참고-링크"></a>

## 📚 참고 링크
- [🍎Apple Docs: SwiftUI](https://developer.apple.com/documentation/swiftui/)



</br>

<a id="회고"></a>

## 📕 회고
- 가벼운 MVP를 완료했다. 이제 수익 모델이 들어간 다음 스텝으로!
- ViewModel이 서로 다른 계층 들에서도 알 수 있게 되어 있기에 해당 부분의 리펙토링이 필요하다.
- 초반에 제대로 된 디자인 시스템을 잡아두지 않았더니 추후 폰트 변경 때 고생했다.
