<!-- i18n-source: README.md@adba62b2218f692b4b6f70e419f8698ca3ff00cd status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ja-light.svg" alt="VisionOS UI Framework: visionOS アプリ向けの空間レイアウト、カルーセル、イマーシブスペース、制約付き操作。"></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="CI ステータス"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="最新バージョン: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="対応プラットフォーム: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="言語バージョン: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="ライセンス: MIT"></picture></a>
</p>

<p align="center">
<a href="#クイックスタート"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ja-light.svg" alt="はじめる"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ja-light.svg" alt="ドキュメント"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ja-light.svg" alt="サンプル"></picture></a>
</p>

> このドキュメントは英語版 README の翻訳です。内容が異なる場合は英語版が最新です。

<!-- brand:end -->
visionOS アプリ向けの Swift パッケージです。5 種類のレイアウト（アーク、リング、グリッド、球面、らせん）で SwiftUI のビューと RealityKit のエンティティを 3D 空間に配置し、ビューの輪をカルーセルに変え、手動で管理するフラグにつきものの競合状態を起こさずにイマーシブスペースを開閉し、設定した範囲内でオブジェクトを移動・拡大縮小・回転できるようにします。ジオメトリの計算や状態管理を自分で書かずに、これらの空間向けの部品を使いたい開発者のためのものです。同じコードは iOS と macOS でも動作し、そこではレイアウトが正面から見た形で描画されます。パッケージに依存関係はありません。

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="Apple Vision Pro シミュレータ上のサンプルアプリ。惑星の名前が付いた 5 枚のガラスのカードが、見る人に向かって湾曲するアーク上に並び、外側のカードほど手前にあって中央のほうを向いている"></p>

## 主な特長

- **5 種類の空間レイアウト** — アーク、リング、グリッド、球面、らせんは、項目ごとにメートル単位の位置と向きを返します。SwiftUI のビューには `SpatialLayoutView`、RealityKit のエンティティには `arrangeChildren(using:)` を使います。
- **競合のないイマーシブスペース** — `ImmersiveSpaceCoordinator` は、遷移中の 2 つ目のリクエストを拒否し、別のスペースを開く前に開いているスペースを閉じ、ユーザーが Digital Crown でスペースを閉じたときはシステムの状態に追従します。
- **範囲内での操作** — `ManipulationState` は、ドラッグ、ピンチ、回転されたオブジェクトをボックスとスケール範囲の内側に保ちます。必要に応じて直立の維持やスナップも行い、異常なジェスチャの値は無視します。
- **プラットフォームに合わせたサイズのコンポーネント** — `SpatialCard`、visionOS で ornament になるツールバー、Apple のガイドラインに沿ったヒットターゲット（visionOS は 60 pt、iOS は 44、macOS は 28）。
- **信頼できない入力でも安全** — 個数は 4096 項目、長さは 10 km で上限が設けられ、NaN や無限大の引数はドキュメントに記載された既定値に戻ります。そのため、ファイルから読み込んだ値でメモリを使い果たしたり、無限遠の位置が生じたりすることはありません。
- **3 つのプラットフォームでテスト済み** — 93 件の Swift Testing のテストが macOS と iPhone シミュレータで実行され、そのうちピクセルテストを除く 83 件は visionOS シミュレータでも実行されます。

### 含まれるもの

| 分野               | API                                                                                                                              |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| レイアウト         | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI            | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit         | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| イマーシブスペース | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| 操作               | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| コンポーネント     | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## クイックスタート

**1. パッケージを追加する**

Xcode で **File › Add Package Dependencies…** を選び、リポジトリの URL を入力します。

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

ウィンドウ右上の検索フィールドに貼り付けます。**Dependency Rule** は `2.0.0` からの **Up to Next Major Version** のままにして、**Add Package** をクリックします。次のウィンドウで、**VisionUI** の横にあるアプリのターゲットを選び、もう一度 **Add Package** をクリックします。

**2. モジュールをインポートする**

```swift
import VisionUI
```

この行は、パッケージを使う Swift ファイルの先頭、`import SwiftUI` の下に置きます。

**3. 使ってみる**

新しい visionOS アプリ（**File › New › Project… › visionOS › App**）で、`ContentView.swift` の中身をすべて次のコードに置き換えます。

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

**Apple Vision Pro** シミュレータを選んで **Run**（⌘R）を押します。5 枚のカードが上の画像のように手前に湾曲して並びます。中央の 1 枚はウィンドウと同じ面にあり、外側のカードはより手前にあってアークの中心を向き、アークはウィンドウの 0.6 m 手前にあります。半径を `0.3` に変えてもう一度実行すると、カーブがきつくなります。同じコードは iPhone や Mac でも動作し、そこではアークが正面から見た形で描画されます。

## インストール

### Swift Package Manager

Xcode で **File › Add Package Dependencies…** を選び、リポジトリの URL を入力します。

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

または `Package.swift` の `dependencies` に追加します。

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

バージョン 2.0.0（2026 年 10 月）は、新しい API を持つ新しいパッケージです。それ以前のリリースである 1.0.0（2026 年 2 月）は、存在しないプラットフォームバージョン（`.visionOS(.v1_0)`）を宣言していたため Swift Package Manager が解決できず、ソースも visionOS SDK にない API を呼び出していました。2026 年 6 月にはそのコードがプレースホルダーに置き換えられ、2026 年 10 月にパッケージが一から書き直されました。変更点は [CHANGELOG.md](CHANGELOG.md) にまとめています。

## 使い方

以下のサンプルは
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift)
からコピーしたものです。サンプルアプリとテストスイートの両方がこのファイルをコンパイルします。

### カルーセルを回す

`SpatialCarousel` はビューをリング状に配置します。ドラッグすると回転し、ドラッグを終えると最も近いビューで止まって `selection` を更新します。ビューをタップするか `selection` を設定すると、そのビューが近いほうの回り方で正面に回ってきます。

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

### オブジェクトを範囲内で動かせるようにする

地球儀は 40 × 30 × 20 cm のボックスの内側にとどまり、半分から 2 倍までの大きさで拡大縮小し、垂直軸まわりにだけ回転し、回転を終えると 45° にスナップします。

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

### RealityKit のエンティティを並べる

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

シーンに追加されたあとのエンティティを新しいレイアウトへアニメーションさせるには、`duration:` を渡します。

### ウィンドウにツールバーを取り付ける

visionOS ではツールバーはウィンドウの下の ornament になり、iOS と macOS ではコンテンツの下部に重ねて描画されます。

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

### イマーシブスペースを開く

アプリ内に `ImmersiveSpaceCoordinator` を 1 つ作成して environment に置き、スペースの `onDisappear` から `spaceDidDisappear(_:)` を呼び出します。こうすると、システムがスペースを閉じたときもボタンの状態が追従します。

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
では、シーンの設定と、各ケースでの coordinator の動作を説明しています。

## デモ

Apple Vision Pro シミュレータ上のサンプルアプリです。
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh) で撮影しました。

| カルーセル                                                                                                                                                     | ツールバーの ornament                                                                                                                                                          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ![カルーセルのページ。手前に Mountains のカード、両脇に外側を向いた Arctic と City のカード、下に Showing Mountains の文字](docs/images/visionos-carousel.png) | ![コンポーネントのページ。2 枚のガラスのカード、タップ領域が広い小さな星、ウィンドウの下に取り付けられた戻る・再生・進むボタンのツールバー](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="イマーシブスペース。青とティールの球が部屋のまわりのさまざまな高さに広がり、ギャラリーのウィンドウには Hide Orbit ボタンが表示されている"></p>

12 個の項目を持つ 5 つのレイアウトを、上から（見る人は下側）と正面から見た図です。矢印は各項目が向いている方向を示します。各レイアウト自身が返す位置から
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh) で描画しました。

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="アーク、リング、グリッド、球面、らせんの各レイアウトを上と正面から見た図。点は項目、矢印は各項目が向く方向を表す"></picture></p>

すべてを自分で試すには、Xcode で
[`Examples/SpatialGallery`](Examples/SpatialGallery) の `SpatialGallery.xcodeproj` を開き、**Apple Vision Pro** シミュレータ、iPhone シミュレータ、または **My Mac** を選んで **Run** を押します。
各ページの説明は [Examples/README.md](Examples/README.md) にあります。

## ドキュメント

API リファレンスと解説記事：

- [API リファレンス](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  （DocC。`main` から GitHub Pages に公開されます）
- ローカルでビルドするには、Xcode で **Product › Build Documentation** を選ぶか、コマンドラインで次を実行します。

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## ガイド

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — パッケージの追加、ビューをアーク上に配置する方法、座標の規約
  （[ソース](Sources/VisionUI/VisionUI.docc/GettingStarted.md)）。
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — 5 つのレイアウト、SwiftUI のビュー、RealityKit のエンティティ、カルーセル、フラットな投影
  （[ソース](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)）。
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — アプリごとに 1 つの coordinator、トグル、対応しているすべてのケース
  （[ソース](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)）。
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — 範囲、スケール範囲、直立を保つ回転とスナップを、独自のジェスチャまたは modifier で使う方法
  （[ソース](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)）。

## 動作要件

| プラットフォーム  | 最小バージョン         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| ツールチェーン | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` と、環境の actions を受け取る `ImmersiveSpaceActions` のイニシャライザには、visionOS、または SwiftUI にイマーシブスペースがある macOS 26 が必要です。CI は GitHub の `macos-26` ランナーイメージに入っている既定の Xcode でビルドします。パッケージは Xcode 27 で開発しています。

## アーキテクチャ

- `Sources/VisionUI/Geometry/` には、`SpatialPlacement`、共通の計算（注視方向への回転、yaw、角度の折り返しとスナップ）、そして `+y` が上のパッケージのメートルと `+y` が下の SwiftUI のポイントとの変換があります。
- `Layouts/` には、`SpatialLayout` プロトコル、5 つのレイアウト、`offset(_:)` があります。レイアウトは個数を位置に変換する値であり、ビューやエンティティのことは何も知りません。
- `Views/` は SwiftUI のビューを配置します。visionOS では `offset(z:)` と `rotation3DEffect` を使い、環境の `physicalMetrics` を参照します。iOS と macOS では `FlatProjection` を通します。
- `RealityKit/` は位置をエンティティに適用します。`Spaces/` にはイマーシブスペースの coordinator があり、システムは `ImmersiveSpaceActions` 経由でしか呼び出さないため、テストではクロージャで動かせます。
- `Manipulation/` には、ジェスチャごとに 1 つの開始値を持つ制約付きの状態と、ジェスチャからそれに値を渡す modifier があります。`Components/` には、カード、ツールバー、ornament、ヒットターゲット、深度の modifier があります。
- すべての公開入力は、入ってくる場所で検証されます。個数は `SpatialLayoutLimits` に対して、長さと角度は NaN、無限大、オーバーフローについてチェックされます。テストでは、そのような値をすべてのレイアウト、投影、操作の状態、カルーセルに渡しています。

テストをローカルで実行します。

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## ロードマップ

- パッケージを Swift Package Index に追加する。`.spi.yml` はすでにリポジトリにあります。
- イマーシブスペースで、壁やテーブルなど ARKit が検出した面に沿うレイアウト。
- 長いリスト向けに、アークに沿ってスクロールするカルーセルのバリエーション。

## コントリビューション

コントリビューションを歓迎します。pull request を作成する前に[コントリビューションガイド](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md)と[行動規範](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)をお読みください。セキュリティ上の問題は[セキュリティポリシー](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)に従って非公開で報告してください。

## ライセンス

MIT ライセンスで公開しています。詳細は [LICENSE](LICENSE) を参照してください。
