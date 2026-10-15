<!-- i18n-source: README.md@adba62b2218f692b4b6f70e419f8698ca3ff00cd status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-ru-light.svg" alt="VisionOS UI Framework: Раскладки в 3D, карусель, иммерсивные пространства и ограниченные манипуляции для visionOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="Статус CI"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="Последняя версия: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="Поддерживаемые платформы: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="Версия языка: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="Лицензия: MIT"></picture></a>
</p>

<p align="center">
<a href="#быстрый-старт"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-ru-light.svg" alt="Начать"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-ru-light.svg" alt="Документация"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-ru-light.svg" alt="Примеры"></picture></a>
</p>

> Это перевод README на английском языке. Если они расходятся, актуальна английская версия.

<!-- brand:end -->
Пакет Swift для приложений visionOS: он размещает представления SwiftUI и сущности RealityKit в 3D с помощью пяти раскладок (дуга, кольцо, сетка, сфера, спираль), превращает кольцо из представлений в карусель, открывает и закрывает иммерсивные пространства без гонок, свойственных флагу, который ведётся вручную, и позволяет пользователям перемещать, масштабировать и поворачивать объекты в заданных вами пределах. Он рассчитан на разработчиков, которым нужны такие пространственные строительные блоки, но не хочется самим писать геометрию и управление состоянием. Тот же код работает на iOS и macOS, где раскладки рисуются в виде спереди, а у пакета нет зависимостей.

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="Пример приложения в симуляторе Apple Vision Pro: пять стеклянных карточек с названиями планет на дуге, изгибающейся к зрителю; крайние карточки ближе и повёрнуты к центру"></p>

## Основные возможности

- **Пять пространственных раскладок** — дуга, кольцо, сетка, сфера и спираль возвращают для каждого элемента позицию в метрах и ориентацию: для представлений SwiftUI через `SpatialLayoutView`, для сущностей RealityKit через `arrangeChildren(using:)`.
- **Иммерсивные пространства без гонок** — `ImmersiveSpaceCoordinator` отклоняет второй запрос во время перехода, закрывает одно пространство перед открытием другого и следует за системой, когда человек закрывает пространство с помощью Digital Crown.
- **Манипуляции в пределах ограничений** — `ManipulationState` удерживает перетаскиваемый, масштабируемый щипком или поворачиваемый объект внутри коробки и диапазона масштаба, при желании в вертикальном положении, с привязкой (snapping), и игнорирует ошибочные значения жестов.
- **Компоненты нужного размера для каждой платформы** — `SpatialCard`, панель инструментов, которая в visionOS становится ornament, и области нажатия с размерами по рекомендациям Apple (60 pt в visionOS, 44 в iOS, 28 в macOS).
- **Ненадёжный ввод безопасен** — количество ограничено 4096 элементами, длины — 10 км, а аргументы NaN или бесконечные возвращаются к задокументированным значениям по умолчанию, поэтому значение, прочитанное из файла, не может исчерпать память или дать бесконечную позицию.
- **Проверено на трёх платформах** — 93 теста Swift Testing запускаются на macOS и в симуляторе iPhone; 83 из них, все кроме пиксельных тестов, запускаются и в симуляторе visionOS.

### Что входит

| Область                  | API                                                                                                                              |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| Раскладки                | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI                  | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit               | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| Иммерсивные пространства | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| Манипуляции              | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| Компоненты               | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## Быстрый старт

**1. Добавьте пакет**

В Xcode выберите **File › Add Package Dependencies…** и введите адрес репозитория:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Вставьте его в поле поиска в правом верхнем углу окна. Оставьте для **Dependency Rule** значение **Up to Next Major Version** от `2.0.0` и нажмите **Add Package**. В следующем окне выберите цель вашего приложения рядом с **VisionUI** и ещё раз нажмите **Add Package**.

**2. Импортируйте модуль**

```swift
import VisionUI
```

Поместите эту строку в начало Swift-файла, где вы используете пакет, под `import SwiftUI`.

**3. Используйте**

В новом приложении visionOS (**File › New › Project… › visionOS › App**) замените всё содержимое `ContentView.swift` на следующее:

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

Выберите симулятор **Apple Vision Pro** и нажмите **Run** (⌘R). Пять карточек изгибаются в вашу сторону, как на картинке выше: средняя лежит в плоскости окна, крайние ближе и повёрнуты к центру дуги, а сама дуга находится в 0.6 м перед окном. Измените радиус на `0.3` и запустите снова, чтобы получить более крутой изгиб. Тот же код работает и на iPhone, и на Mac, где дуга рисуется в виде спереди.

## Установка

### Swift Package Manager

В Xcode выберите **File › Add Package Dependencies…** и введите адрес репозитория:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Или добавьте его в `dependencies` вашего `Package.swift`:

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

Версия 2.0.0 (октябрь 2026 года) — это новый пакет с новым API. Предыдущий выпуск, 1.0.0 (февраль 2026 года), объявлял несуществующую версию платформы (`.visionOS(.v1_0)`), поэтому Swift Package Manager не мог его разрешить, а исходный код вызывал API, которых нет в SDK visionOS. В июне 2026 года этот код заменили заглушками, а в октябре 2026 года пакет написали заново с нуля. В [CHANGELOG.md](CHANGELOG.md) перечислено, что изменилось.

## Использование

Примеры ниже скопированы из
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift).
Пример приложения и набор тестов компилируют этот файл.

### Вращение карусели

`SpatialCarousel` размещает представления на кольце. Перетаскивание вращает его, а когда жест заканчивается, карусель останавливается на ближайшем представлении и обновляет `selection`. Нажатие на представление или установка `selection` разворачивает это представление к фронту по кратчайшему пути.

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

### Позволить перемещать объект в пределах ограничений

Глобус остаётся внутри коробки 40 × 30 × 20 см, масштабируется от половины до двойного размера, поворачивается только вокруг вертикальной оси и привязывается к 45°, когда поворот заканчивается.

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

### Расстановка сущностей RealityKit

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

Передайте `duration:`, чтобы анимировать переход сущностей к новой раскладке после того, как они окажутся в сцене.

### Прикрепление панели инструментов к окну

В visionOS панель инструментов — это ornament под окном; в iOS и macOS она рисуется поверх нижней части содержимого.

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

### Открытие иммерсивного пространства

Создайте в приложении один `ImmersiveSpaceCoordinator`, поместите его в окружение (environment) и вызывайте `spaceDidDisappear(_:)` из `onDisappear` пространства, чтобы кнопка тоже следовала за состоянием, когда система закрывает пространство:

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

В [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
показано, как настроить сцену и что делает coordinator в каждом случае.

## Демо

Пример приложения в симуляторе Apple Vision Pro, снятый с помощью
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh):

| Карусель                                                                                                                                                             | Ornament панели инструментов                                                                                                                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![Страница карусели: карточка Mountains спереди, карточки Arctic и City по бокам повёрнуты наружу, внизу текст Showing Mountains](docs/images/visionos-carousel.png) | ![Страница компонентов: две стеклянные карточки, маленькая звезда с увеличенной областью нажатия и панель инструментов с кнопками «назад», «воспроизвести» и «вперёд», прикреплённая под окном](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="Иммерсивное пространство: синие и бирюзовые сферы разбросаны по комнате на разной высоте, в окне галереи видна кнопка Hide Orbit"></p>

Пять раскладок по 12 элементов, вид сверху (зритель внизу) и спереди; стрелка показывает, куда повёрнут каждый элемент. Изображения построены по позициям, которые возвращают сами раскладки, скриптом
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh):

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="Схемы раскладок «дуга», «кольцо», «сетка», «сфера» и «спираль» сверху и спереди: точки обозначают элементы, стрелки — направление, в котором повёрнут каждый из них"></picture></p>

Чтобы попробовать всё самостоятельно, откройте в Xcode файл `SpatialGallery.xcodeproj` в папке
[`Examples/SpatialGallery`](Examples/SpatialGallery), выберите симулятор **Apple Vision Pro**, симулятор iPhone или **My Mac** и нажмите **Run**.
Каждая страница описана в [Examples/README.md](Examples/README.md).

## Документация

Справочник API и статьи:

- [Справочник API](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  (DocC, публикуется на GitHub Pages из ветки `main`)
- Соберите его локально в Xcode через **Product › Build Documentation** или из командной строки:

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## Руководства

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — добавление пакета, размещение представлений на дуге и соглашения о координатах
  ([исходник](Sources/VisionUI/VisionUI.docc/GettingStarted.md)).
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — пять раскладок, представления SwiftUI, сущности RealityKit, карусель и плоская проекция
  ([исходник](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)).
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — один coordinator на приложение, переключатель и все случаи, которые он обрабатывает
  ([исходник](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)).
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — границы, диапазоны масштаба, поворот с сохранением вертикали и привязка, со своими жестами или с помощью modifier
  ([исходник](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)).

## Требования

| Платформа  | Минимальная версия         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| Инструменты | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` и инициализатор `ImmersiveSpaceActions`, принимающий действия окружения, требуют visionOS или macOS 26, где в SwiftUI есть иммерсивные пространства. CI собирает проект с Xcode по умолчанию из образа раннера `macos-26` на GitHub. Пакет разрабатывается в Xcode 27.

## Архитектура

- `Sources/VisionUI/Geometry/` содержит `SpatialPlacement`, общую математику (поворот «смотреть на точку», yaw, приведение углов в диапазон и привязка) и преобразование между метрами пакета с осью `+y` вверх и точками SwiftUI с осью `+y` вниз.
- `Layouts/` содержит протокол `SpatialLayout`, пять раскладок и `offset(_:)`. Раскладка — это значение, которое превращает количество в позиции; она ничего не знает о представлениях и сущностях.
- `Views/` размещает представления SwiftUI: в visionOS через `offset(z:)` и `rotation3DEffect` с учётом `physicalMetrics` окружения, в iOS и macOS через `FlatProjection`.
- `RealityKit/` применяет позиции к сущностям. `Spaces/` содержит coordinator иммерсивных пространств, который обращается к системе только через `ImmersiveSpaceActions`, поэтому тесты управляют им с помощью замыканий.
- `Manipulation/` содержит ограниченное состояние с одним начальным значением на каждый жест и modifier, который передаёт ему данные от жестов. `Components/` содержит modifier'ы карточки, панели инструментов, ornament, области нажатия и глубины.
- Каждый публичный ввод проверяется там, где он входит: количество — по `SpatialLayoutLimits`, длины и углы — на NaN, бесконечность и переполнение. Тесты передают такие значения каждой раскладке, проекции, состоянию манипуляции и карусели.

Запустите тесты локально:

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## План развития

- Добавить пакет в Swift Package Index; `.spi.yml` уже есть в репозитории.
- Раскладки, которые следуют за поверхностью, найденной ARKit, например стеной или столом, в иммерсивном пространстве.
- Вариант карусели, которая прокручивается вдоль дуги, для длинных списков.

## Участие в разработке

Мы рады вашему участию. Перед открытием pull request прочитайте [руководство для участников](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md) и [кодекс поведения](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md). О проблемах безопасности сообщайте конфиденциально, как описано в [политике безопасности](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Лицензия

Распространяется по лицензии MIT. Подробнее — в файле [LICENSE](LICENSE).
