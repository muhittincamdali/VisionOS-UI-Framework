<!-- i18n-source: README.md@8ca5ed379fef47a6459bdec242c56b09ba6aff9b status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ko-light.svg" alt="VisionOS UI Framework: visionOS 앱을 위한 공간 레이아웃, 캐러셀, 몰입형 공간, 제한된 조작."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="CI 상태"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="최신 버전: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="지원 플랫폼: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="언어 버전: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="라이선스: MIT"></picture></a>
</p>

<p align="center">
<a href="#빠른-시작"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ko-light.svg" alt="시작하기"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ko-light.svg" alt="문서"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ko-light.svg" alt="예제"></picture></a>
</p>

> 이 문서는 영어 README의 번역본입니다. 내용이 다를 경우 영어 버전이 최신입니다.

<!-- brand:end -->
visionOS 앱을 위한 Swift 패키지입니다. 다섯 가지 레이아웃(아크, 링, 그리드, 구, 나선)으로 SwiftUI 뷰와 RealityKit 엔티티를 3D 공간에 배치하고, 뷰의 고리를 캐러셀로 바꾸며, 직접 관리하는 플래그에서 생기는 경쟁 상태 없이 몰입형 공간을 열고 닫고, 사용자가 설정한 한도 안에서 객체를 옮기고 크기를 바꾸고 돌릴 수 있게 해 줍니다. 기하 계산과 상태 처리를 직접 작성하지 않고 이런 공간용 구성 요소를 쓰고 싶은 개발자를 위한 패키지입니다. 같은 코드가 iOS와 macOS에서도 동작하며, 그곳에서는 레이아웃이 정면에서 본 모습으로 그려집니다. 이 패키지에는 의존성이 없습니다.

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="Apple Vision Pro 시뮬레이터에서 실행한 예제 앱: 행성 이름이 붙은 유리 카드 다섯 장이 보는 사람 쪽으로 휘어진 아크 위에 놓여 있고, 바깥쪽 카드는 더 가깝고 가운데를 향해 돌아가 있음"></p>

## 주요 기능

- **다섯 가지 공간 레이아웃** — 아크, 링, 그리드, 구, 나선은 항목마다 미터 단위의 위치와 방향을 반환합니다. SwiftUI 뷰에는 `SpatialLayoutView`를, RealityKit 엔티티에는 `arrangeChildren(using:)`를 사용합니다.
- **경쟁 상태 없는 몰입형 공간** — `ImmersiveSpaceCoordinator`는 전환 중에 들어온 두 번째 요청을 거절하고, 다른 공간을 열기 전에 열려 있는 공간을 먼저 닫으며, 사용자가 Digital Crown으로 공간을 닫으면 시스템의 상태를 따릅니다.
- **한도 안에서의 조작** — `ManipulationState`는 드래그, 핀치, 회전한 객체를 상자와 배율 범위 안에 유지하고, 원하면 똑바로 선 상태를 지키며, 스냅을 적용하고, 오작동한 제스처 값은 무시합니다.
- **플랫폼에 맞는 크기의 구성 요소** — `SpatialCard`, visionOS에서 ornament가 되는 툴바, Apple 가이드라인에 맞춘 히트 타깃 크기(visionOS 60 pt, iOS 44, macOS 28)를 제공합니다.
- **신뢰할 수 없는 입력도 안전** — 개수는 4096개, 길이는 10 km로 제한되며, NaN이나 무한대 인자는 문서에 적힌 기본값으로 대체됩니다. 그래서 파일에서 읽은 값이 메모리를 소진시키거나 무한히 먼 위치를 만들 수 없습니다.
- **세 플랫폼에서 테스트** — Swift Testing 테스트 97개가 macOS와 iPhone 시뮬레이터에서 실행되고, 그중 픽셀 테스트를 제외한 87개는 visionOS 시뮬레이터에서도 실행됩니다.

### 포함된 내용

| 영역        | API                                                                                                                              |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 레이아웃    | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI     | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit  | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| 몰입형 공간 | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| 조작        | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| 구성 요소   | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## 빠른 시작

**1. 패키지 추가**

Xcode에서 **File › Add Package Dependencies…**를 선택하고 저장소 URL을 입력하세요.

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

창 오른쪽 위의 검색 필드에 붙여 넣으세요. **Dependency Rule**은 `2.0.0`부터 **Up to Next Major Version**으로 그대로 두고 **Add Package**를 클릭합니다. 다음 창에서 **VisionUI** 옆에 앱 타깃을 선택한 뒤 **Add Package**를 다시 클릭하세요.

**2. 모듈 가져오기**

```swift
import VisionUI
```

이 줄은 패키지를 사용하는 Swift 파일의 맨 위, `import SwiftUI` 아래에 넣으세요.

**3. 사용하기**

새 visionOS 앱(**File › New › Project… › visionOS › App**)에서 `ContentView.swift`의 내용을 모두 다음 코드로 바꾸세요.

```swift
import SwiftUI
import VisionUI

struct ContentView: View {
    let planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter"]

    var body: some View {
        SpatialLayoutView(.arc(radius: 0.6, spacing: 0.17), planets, id: \.self) { planet in
            SpatialCard {
                Text(planet)
                    .font(.title)
            }
        }
    }
}
```

**Apple Vision Pro** 시뮬레이터를 선택하고 **Run**(⌘R)을 누르세요. 다섯 장의 카드가 위 그림처럼 여러분 쪽으로 휘어집니다. 가운데 카드는 창과 같은 평면에 있고, 바깥쪽 카드는 더 가까이에서 아크의 중심을 향해 돌아가 있으며, 아크는 창에서 0.6 m 앞에 있습니다. 반지름을 `0.3`으로 바꿔 다시 실행하면 곡선이 더 조밀해집니다. 같은 코드가 iPhone이나 Mac에서도 실행되며, 그곳에서는 아크가 정면에서 본 모습으로 그려집니다.

## 설치

### Swift Package Manager

Xcode에서 **File › Add Package Dependencies…**를 선택하고 저장소 URL을 입력하세요.

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

또는 `Package.swift`의 `dependencies`에 추가하세요.

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "2.0.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "VisionUI", package: "VisionOS-UI-Framework")
    ])
]
```

2.0.0 버전(2026년 10월)은 새로운 API를 갖춘 새 패키지입니다. 이전 릴리스인 1.0.0(2026년 2월)은 존재하지 않는 플랫폼 버전(`.visionOS(.v1_0)`)을 선언해서 Swift Package Manager가 해석할 수 없었고, 소스도 visionOS SDK에 없는 API를 호출했습니다. 2026년 6월에 그 코드는 자리 표시용 내용으로 교체되었고, 2026년 10월에 패키지를 처음부터 다시 작성했습니다. 바뀐 내용은 [CHANGELOG.md](CHANGELOG.md)에 정리되어 있습니다.

## 사용법

아래 예제는
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift)
에서 복사한 것입니다. 예제 앱과 테스트 스위트가 모두 이 파일을 컴파일합니다.

### 캐러셀 돌리기

`SpatialCarousel`은 뷰를 고리 위에 놓습니다. 드래그하면 고리가 돌아가고, 드래그가 끝나면 가장 가까운 뷰에서 멈춰 `selection`을 업데이트합니다. 뷰를 탭하거나 `selection`을 설정하면 그 뷰가 더 짧은 쪽으로 돌아 정면에 옵니다.

```swift
struct CarouselSample: View {
    @State private var selection = 0
    let destinations = [
        Destination(name: "Mountains", symbol: "mountain.2.fill"),
        Destination(name: "Ocean", symbol: "water.waves"),
        Destination(name: "Forest", symbol: "tree.fill"),
        Destination(name: "Desert", symbol: "sun.max.fill"),
        Destination(name: "City", symbol: "building.2.fill"),
        Destination(name: "Arctic", symbol: "snowflake"),
    ]

    var body: some View {
        VStack(spacing: 48) {
            SpatialCarousel(destinations, selection: $selection, radius: 0.25) { destination in
                SpatialCard {
                    Label(destination.name, systemImage: destination.symbol)
                        .font(.title2)
                        .frame(width: 180, height: 120)
                }
            }
            Text("Showing \(destinations[selection].name)")
        }
    }
}
```

### 사용자가 한도 안에서 객체를 옮기게 하기

지구본은 40 × 30 × 20 cm 상자 안에 머물고, 절반에서 두 배 사이로 크기가 바뀌며, 수직축을 기준으로만 돌아가고, 회전이 끝나면 45°로 스냅됩니다.

```swift
struct ManipulationSample: View {
    @State private var globe = ManipulationState(constraints: ManipulationConstraints(
        bounds: SpatialBounds(center: .zero, size: [0.4, 0.3, 0.2]),
        scaleRange: 0.5...2,
        rotation: .yaw,
        yawSnapAngle: .pi / 4
    ))

    var body: some View {
        Image(systemName: "globe.americas.fill")
            .font(.system(size: 120))
            .foregroundStyle(.blue)
            .spatialManipulation($globe)
    }
}
```

### RealityKit 엔티티 배치하기

```swift
struct ShelfSample: View {
    var body: some View {
        RealityView { content in
            let shelf = Entity()
            for _ in 0..<7 {
                let sphere = ModelEntity(
                    mesh: .generateSphere(radius: 0.04),
                    materials: [SimpleMaterial(color: .systemBlue, isMetallic: false)]
                )
                shelf.addChild(sphere)
            }
            shelf.arrangeChildren(using: .arc(radius: 0.5, spacing: 0.12))
            content.add(shelf)
        }
    }
}
```

엔티티가 씬에 들어간 뒤 새 레이아웃으로 애니메이션하려면 `duration:`을 전달하세요.

### 창에 툴바 붙이기

visionOS에서는 툴바가 창 아래의 ornament가 되고, iOS와 macOS에서는 콘텐츠 하단 위에 그려집니다.

```swift
struct PlayerSample: View {
    @State private var isPlaying = false

    var body: some View {
        Text(isPlaying ? "Playing" : "Paused")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbarOrnament(edge: .bottom) {
                Button("Back", systemImage: "backward.fill") {}
                Button(isPlaying ? "Pause" : "Play", systemImage: isPlaying ? "pause.fill" : "play.fill") {
                    isPlaying.toggle()
                }
                Button("Forward", systemImage: "forward.fill") {}
            }
    }
}
```

### 몰입형 공간 열기

앱에서 `ImmersiveSpaceCoordinator`를 하나 만들어 environment에 넣고, 공간의 `onDisappear`에서 `spaceDidDisappear(_:)`를 호출하세요. 그러면 시스템이 공간을 닫을 때 버튼도 그에 맞게 바뀝니다.

```swift
struct ImmersiveSample: View {
    @Environment(ImmersiveSpaceCoordinator.self) private var spaces

    var body: some View {
        VStack(spacing: 24) {
            ImmersiveSpaceToggle("Orbit", spaceID: "orbit", coordinator: spaces)
            if spaces.isBusy {
                ProgressView()
            }
        }
    }
}
```

[Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
에서 씬 설정 방법과 각 경우에 coordinator가 하는 일을 볼 수 있습니다.

## 데모

Apple Vision Pro 시뮬레이터에서 실행한 예제 앱이며,
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh)로 캡처했습니다.

| 캐러셀                                                                                                                                                    | 툴바 ornament                                                                                                                                      |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![캐러셀 페이지: 맨 앞에 Mountains 카드, 양옆에 바깥쪽으로 돌아간 Arctic과 City 카드, 아래에 Showing Mountains 텍스트](docs/images/visionos-carousel.png) | ![구성 요소 페이지: 유리 카드 두 장, 탭 영역이 더 큰 작은 별, 창 아래에 붙은 뒤로·재생·앞으로 버튼이 있는 툴바](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="몰입형 공간: 파란색과 청록색 구체가 방 주위의 다양한 높이에 흩어져 있고, 갤러리 창에는 Hide Orbit 버튼이 표시됨"></p>

항목 12개로 구성한 다섯 가지 레이아웃을 위에서(보는 사람은 아래쪽) 그리고 정면에서 본 모습이며, 화살표는 각 항목이 향하는 방향을 나타냅니다. 각 레이아웃이 계산한 위치로
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh)가 렌더링했습니다.

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="아크, 링, 그리드, 구, 나선 레이아웃을 위에서와 정면에서 본 다이어그램으로, 점은 항목, 화살표는 각 항목이 향하는 방향을 나타냄"></picture></p>

모든 기능을 직접 해 보려면 Xcode로
[`Examples/SpatialGallery`](Examples/SpatialGallery)의 `SpatialGallery.xcodeproj`를 열고, **Apple Vision Pro** 시뮬레이터, iPhone 시뮬레이터 또는 **My Mac**을 선택한 뒤 **Run**을 누르세요.
각 페이지는 [Examples/README.md](Examples/README.md)에서 설명합니다.

## 문서

API 레퍼런스와 문서:

- [API 레퍼런스](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  (DocC이며 `main`에서 GitHub Pages로 게시됩니다)
- Xcode에서 **Product › Build Documentation**으로 로컬에서 빌드하거나, 명령줄에서 다음을 실행하세요.

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## 가이드

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — 패키지 추가, 뷰를 아크 위에 배치하는 방법, 좌표 규칙
  ([소스](Sources/VisionUI/VisionUI.docc/GettingStarted.md)).
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — 다섯 가지 레이아웃, SwiftUI 뷰, RealityKit 엔티티, 캐러셀, 평면 투영
  ([소스](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)).
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — 앱당 하나의 coordinator, 토글, 그리고 처리하는 모든 경우
  ([소스](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)).
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — 범위, 배율 범위, 똑바로 선 상태를 지키는 회전과 스냅을 직접 만든 제스처나 modifier로 적용하는 방법
  ([소스](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)).

## 요구 사항

| 플랫폼  | 최소 버전         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| 툴체인 | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle`과, 환경의 actions를 받는 `ImmersiveSpaceActions` 이니셜라이저에는 visionOS 또는 SwiftUI에 몰입형 공간이 있는 macOS 26이 필요합니다. CI는 GitHub `macos-26` 러너 이미지의 기본 Xcode로 빌드합니다. 이 패키지는 Xcode 27로 개발합니다.

## 아키텍처

- `Sources/VisionUI/Geometry/`에는 `SpatialPlacement`, 공용 수학 연산(바라보는 방향 회전, yaw, 각도 감기와 스냅), 그리고 `+y`가 위인 패키지의 미터와 `+y`가 아래인 SwiftUI의 포인트 사이의 변환이 있습니다.
- `Layouts/`에는 `SpatialLayout` 프로토콜, 다섯 가지 레이아웃, `offset(_:)`이 있습니다. 레이아웃은 개수를 배치 값으로 바꾸는 값이며 뷰나 엔티티에 대해서는 아무것도 모릅니다.
- `Views/`는 SwiftUI 뷰를 배치합니다. visionOS에서는 환경의 `physicalMetrics`를 사용해 `offset(z:)`와 `rotation3DEffect`로, iOS와 macOS에서는 `FlatProjection`을 통해 배치합니다.
- `RealityKit/`은 배치 값을 엔티티에 적용합니다. `Spaces/`에는 몰입형 공간 coordinator가 있으며, 시스템은 `ImmersiveSpaceActions`를 통해서만 호출하므로 테스트에서는 클로저로 구동합니다.
- `Manipulation/`에는 제스처마다 시작 값 하나를 가진 제약 상태와, 제스처로 그 상태에 값을 공급하는 modifier가 있습니다. `Components/`에는 카드, 툴바, ornament, 히트 타깃, 깊이 modifier가 있습니다.
- 모든 공개 입력은 들어오는 지점에서 검사합니다. 개수는 `SpatialLayoutLimits`와, 길이와 각도는 NaN, 무한대, 오버플로 여부를 확인합니다. 테스트는 이런 값을 모든 레이아웃, 투영, 조작 상태, 캐러셀에 전달합니다.

로컬에서 테스트를 실행하세요.

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## 로드맵

- 패키지를 Swift Package Index에 추가합니다. `.spi.yml`은 이미 저장소에 있습니다.
- 몰입형 공간에서 벽이나 탁자처럼 ARKit이 찾은 표면을 따라가는 레이아웃.
- 긴 목록을 위한, 아크를 따라 스크롤되는 캐러셀 변형.

## 기여하기

기여를 환영합니다. pull request를 열기 전에 [기여 가이드](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md)와 [행동 강령](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)을 읽어 주세요. 보안 문제는 [보안 정책](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)에 따라 비공개로 제보해 주세요.

## 라이선스

MIT 라이선스로 배포됩니다. 자세한 내용은 [LICENSE](LICENSE)를 참고하세요.
