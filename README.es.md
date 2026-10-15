<!-- i18n-source: README.md@adba62b2218f692b4b6f70e419f8698ca3ff00cd status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-es-light.svg" alt="VisionOS UI Framework: Diseños espaciales, carrusel, espacios inmersivos y manipulación con límites para apps de visionOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="Estado de CI"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="Última versión: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="Plataformas compatibles: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="Versión del lenguaje: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="Licencia: MIT"></picture></a>
</p>

<p align="center">
<a href="#inicio-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-es-light.svg" alt="Empezar"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-es-light.svg" alt="Documentación"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-es-light.svg" alt="Ejemplos"></picture></a>
</p>

> Esta es una traducción del README en inglés. Si hay diferencias, la versión en inglés es la vigente.

<!-- brand:end -->
Un paquete de Swift para apps de visionOS: coloca vistas de SwiftUI y entidades de RealityKit en 3D con cinco diseños (arco, anillo, cuadrícula, esfera, hélice), convierte un anillo de vistas en un carrusel, abre y cierra espacios inmersivos sin las condiciones de carrera de un indicador gestionado a mano, y permite que las personas muevan, redimensionen y giren objetos dentro de los límites que tú definas. Está pensado para desarrolladores que quieren estos bloques espaciales sin escribir ellos mismos la geometría ni la gestión del estado. El mismo código funciona en iOS y macOS, donde los diseños se dibujan vistos de frente, y el paquete no tiene dependencias.

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="La app de ejemplo en el simulador del Apple Vision Pro: cinco tarjetas de cristal con nombres de planetas sobre un arco que se curva hacia quien mira, con las tarjetas exteriores más cerca y giradas hacia el centro"></p>

## Lo más destacado

- **Cinco diseños espaciales** — arco, anillo, cuadrícula, esfera y hélice devuelven una posición en metros y una orientación por elemento, para vistas de SwiftUI con `SpatialLayoutView` y para entidades de RealityKit con `arrangeChildren(using:)`.
- **Espacios inmersivos sin condiciones de carrera** — `ImmersiveSpaceCoordinator` rechaza una segunda solicitud durante una transición, cierra un espacio antes de abrir otro y sigue al sistema cuando la persona cierra un espacio con la Digital Crown.
- **Manipulación dentro de límites** — `ManipulationState` mantiene un objeto arrastrado, pellizcado o girado dentro de una caja y de un rango de escala, en posición vertical si lo quieres, con ajuste automático (snapping), e ignora los valores erróneos de los gestos.
- **Componentes con el tamaño adecuado para cada plataforma** — `SpatialCard`, una barra de herramientas que se convierte en ornament en visionOS y áreas de toque con el tamaño que indican las guías de Apple (60 pt en visionOS, 44 en iOS, 28 en macOS).
- **Las entradas no confiables son seguras** — las cantidades se limitan a 4096 elementos y las longitudes a 10 km, y los argumentos NaN o infinitos recuperan valores predeterminados documentados, de modo que un valor leído de un archivo no puede agotar la memoria ni producir una posición infinita.
- **Probado en tres plataformas** — 93 pruebas de Swift Testing se ejecutan en macOS y en un simulador de iPhone; 83 de ellas, todas menos las pruebas de píxeles, también se ejecutan en un simulador de visionOS.

### Qué incluye

| Área                | API                                                                                                                              |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Diseños             | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI             | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit          | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| Espacios inmersivos | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| Manipulación        | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| Componentes         | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## Inicio rápido

**1. Añade el paquete**

En Xcode, elige **File › Add Package Dependencies…** e introduce la URL del repositorio:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Pégala en el campo de búsqueda de la esquina superior derecha de la ventana. Deja **Dependency Rule** en **Up to Next Major Version** desde `2.0.0` y haz clic en **Add Package**. En la ventana siguiente, elige tu target de la app junto a **VisionUI** y haz clic de nuevo en **Add Package**.

**2. Importa el módulo**

```swift
import VisionUI
```

Pon esta línea al principio del archivo Swift donde uses el paquete, debajo de `import SwiftUI`.

**3. Úsalo**

En una app nueva de visionOS (**File › New › Project… › visionOS › App**), sustituye todo el contenido de `ContentView.swift` por:

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

Elige el simulador de **Apple Vision Pro** y pulsa **Run** (⌘R). Las cinco tarjetas se curvan hacia ti como en la imagen de arriba: la del medio en el plano de la ventana y las exteriores más cerca y giradas hacia el centro del arco, a 0.6 m delante de la ventana. Cambia el radio a `0.3` y ejecuta de nuevo para obtener una curva más cerrada. El mismo código también funciona en un iPhone o en un Mac, donde el arco se dibuja visto de frente.

## Instalación

### Swift Package Manager

En Xcode, elige **File › Add Package Dependencies…** e introduce la URL del repositorio:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

O añádelo a las `dependencies` de tu `Package.swift`:

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

La versión 2.0.0 (octubre de 2026) es un paquete nuevo con una API nueva. La versión anterior, 1.0.0 (febrero de 2026), declaraba una versión de plataforma que no existe (`.visionOS(.v1_0)`), por lo que Swift Package Manager no podía resolverla, y su código llamaba a APIs que no están en el SDK de visionOS. En junio de 2026 ese código se sustituyó por marcadores de posición, y en octubre de 2026 el paquete se volvió a escribir desde cero. [CHANGELOG.md](CHANGELOG.md) enumera lo que cambió.

## Uso

Los ejemplos siguientes están copiados de
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift).
La app de ejemplo y el conjunto de pruebas compilan ese archivo.

### Girar un carrusel

`SpatialCarousel` coloca las vistas en un anillo. Al arrastrar, el anillo gira; al soltar, se detiene en la vista más cercana y actualiza `selection`. Al tocar una vista o asignar `selection`, esa vista gira hasta quedar al frente por el camino más corto.

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

### Dejar que las personas muevan un objeto dentro de límites

El globo se queda dentro de una caja de 40 × 30 × 20 cm, se escala entre la mitad y el doble de su tamaño, gira solo alrededor del eje vertical y se ajusta a 45° cuando termina un giro.

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

### Organizar entidades de RealityKit

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

Pasa `duration:` para animar las entidades hacia un nuevo diseño una vez que estén en una escena.

### Acoplar una barra de herramientas a la ventana

En visionOS la barra de herramientas es un ornament debajo de la ventana; en iOS y macOS se dibuja sobre la parte inferior del contenido.

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

### Abrir un espacio inmersivo

Crea un `ImmersiveSpaceCoordinator` en la app, ponlo en el entorno (environment) y llama a `spaceDidDisappear(_:)` desde el `onDisappear` del espacio, de modo que el botón también siga al sistema cuando este cierre el espacio:

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
muestra cómo configurar la escena y qué hace el coordinator en cada caso.

## Demo

La app de ejemplo en el simulador del Apple Vision Pro, capturada con
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh):

| Carrusel                                                                                                                                                                                     | Ornament de la barra de herramientas                                                                                                                                                                                                               |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![La página del carrusel: la tarjeta Mountains al frente, las tarjetas Arctic y City giradas hacia fuera a los lados y el texto Showing Mountains debajo](docs/images/visionos-carousel.png) | ![La página de componentes: dos tarjetas de cristal, una estrella pequeña con un área de toque más grande y una barra de herramientas con botones de retroceso, reproducción y avance acoplada bajo la ventana](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="El espacio inmersivo: esferas azules y turquesa repartidas por la habitación a distintas alturas, con la ventana de la galería mostrando un botón Hide Orbit"></p>

Los cinco diseños con 12 elementos cada uno, vistos desde arriba (con quien mira abajo) y de frente, con una flecha que indica hacia dónde mira cada elemento. Generado a partir de las posiciones de los propios diseños con
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh):

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="Diagramas de los diseños de arco, anillo, cuadrícula, esfera y hélice vistos desde arriba y de frente, con puntos para los elementos y flechas para la dirección hacia la que mira cada uno"></picture></p>

Para probarlo todo tú mismo, abre `SpatialGallery.xcodeproj` en
[`Examples/SpatialGallery`](Examples/SpatialGallery) con Xcode, elige el simulador de **Apple Vision Pro**, un simulador de iPhone o **My Mac**, y pulsa **Run**.
[Examples/README.md](Examples/README.md) describe cada página.

## Documentación

Referencia de la API y artículos:

- [Referencia de la API](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  (DocC, publicada en GitHub Pages desde `main`)
- Compílala en local en Xcode con **Product › Build Documentation**, o desde la línea de comandos:

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## Guías

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — añadir el paquete, colocar vistas en un arco y las convenciones de coordenadas
  ([código fuente](Sources/VisionUI/VisionUI.docc/GettingStarted.md)).
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — los cinco diseños, vistas de SwiftUI, entidades de RealityKit, el carrusel y la proyección plana
  ([código fuente](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)).
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — un coordinator por app, el interruptor y todos los casos que gestiona
  ([código fuente](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)).
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — límites, rangos de escala, giro que mantiene el objeto en vertical y ajuste automático, con tus propios gestos o con el modifier
  ([código fuente](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)).

## Requisitos

| Plataforma  | Versión mínima         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| Herramientas | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` y el inicializador de `ImmersiveSpaceActions` que recibe las acciones del entorno necesitan visionOS, o macOS 26, donde SwiftUI tiene espacios inmersivos. La CI compila con el Xcode predeterminado de la imagen de runner `macos-26` de GitHub. El paquete se desarrolla con Xcode 27.

## Arquitectura

- `Sources/VisionUI/Geometry/` contiene `SpatialPlacement`, las matemáticas compartidas (rotación para mirar a un punto, yaw, normalización de ángulos y ajuste automático) y la conversión entre los metros del paquete, con `+y` hacia arriba, y los puntos de SwiftUI, con `+y` hacia abajo.
- `Layouts/` contiene el protocolo `SpatialLayout`, los cinco diseños y `offset(_:)`. Un diseño es un valor que convierte una cantidad en posiciones; no sabe nada de vistas ni de entidades.
- `Views/` coloca las vistas de SwiftUI: en visionOS con `offset(z:)` y `rotation3DEffect`, usando las `physicalMetrics` del entorno; en iOS y macOS mediante `FlatProjection`.
- `RealityKit/` aplica las posiciones a las entidades. `Spaces/` contiene el coordinator de espacios inmersivos, que solo llama al sistema a través de `ImmersiveSpaceActions`, de modo que las pruebas lo manejan con closures.
- `Manipulation/` contiene el estado con restricciones, con un valor inicial por gesto, y el modifier que lo alimenta desde los gestos. `Components/` contiene los modifiers de tarjeta, barra de herramientas, ornament, área de toque y profundidad.
- Cada entrada pública se comprueba donde entra: las cantidades frente a `SpatialLayoutLimits`, y las longitudes y los ángulos frente a NaN, infinito y desbordamiento. Las pruebas pasan esos valores a cada diseño, a la proyección, al estado de manipulación y al carrusel.

Ejecuta las pruebas en local:

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Hoja de ruta

- Añadir el paquete al Swift Package Index; `.spi.yml` ya está en el repositorio.
- Diseños que sigan una superficie detectada por ARKit, como una pared o una mesa, en un espacio inmersivo.
- Una variante del carrusel que se desplace a lo largo de un arco, para listas largas.

## Contribuir

Las contribuciones son bienvenidas. Lee la [guía de contribución](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md) y el [código de conducta](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) antes de abrir una pull request. Informa de los problemas de seguridad de forma privada, como se describe en la [política de seguridad](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licencia

Publicado bajo la licencia MIT. Consulta [LICENSE](LICENSE).
