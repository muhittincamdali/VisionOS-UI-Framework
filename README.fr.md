<!-- i18n-source: README.md@8ca5ed379fef47a6459bdec242c56b09ba6aff9b status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-fr-light.svg" alt="VisionOS UI Framework: Dispositions spatiales, carrousel, espaces immersifs et manipulation bornée pour les apps visionOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="État de la CI"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="Dernière version: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="Plateformes prises en charge: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="Version du langage: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="Licence: MIT"></picture></a>
</p>

<p align="center">
<a href="#démarrage-rapide"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-fr-light.svg" alt="Commencer"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-fr-light.svg" alt="Documentation"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-fr-light.svg" alt="Exemples"></picture></a>
</p>

> Ceci est une traduction du README anglais. En cas de différence, la version anglaise fait foi.

<!-- brand:end -->
Un package Swift pour les apps visionOS : il place des vues SwiftUI et des entités RealityKit en 3D avec cinq dispositions (arc, anneau, grille, sphère, hélice), transforme un anneau de vues en carrousel, ouvre et ferme les espaces immersifs sans les situations de concurrence d'un indicateur géré à la main, et permet aux utilisateurs de déplacer, redimensionner et faire tourner des objets dans les limites que vous fixez. Il s'adresse aux développeurs qui veulent ces briques spatiales sans écrire eux-mêmes la géométrie et la gestion d'état. Le même code fonctionne sur iOS et macOS, où les dispositions sont dessinées vues de face, et le package n'a aucune dépendance.

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="L'app d'exemple dans le simulateur Apple Vision Pro : cinq cartes en verre portant des noms de planètes sur un arc qui s'incurve vers l'observateur, les cartes extérieures étant plus proches et tournées vers le milieu"></p>

## Points forts

- **Cinq dispositions spatiales** — l'arc, l'anneau, la grille, la sphère et l'hélice renvoient pour chaque élément une position en mètres et une orientation, pour les vues SwiftUI avec `SpatialLayoutView` et pour les entités RealityKit avec `arrangeChildren(using:)`.
- **Des espaces immersifs sans situation de concurrence** — `ImmersiveSpaceCoordinator` refuse une deuxième demande pendant une transition, ferme un espace avant d'en ouvrir un autre et suit le système lorsque la personne ferme un espace avec la Digital Crown.
- **Une manipulation dans des limites** — `ManipulationState` garde un objet déplacé, pincé ou tourné à l'intérieur d'une boîte et d'une plage d'échelle, à la verticale si vous le souhaitez, avec aimantation (snapping), et ignore les valeurs de geste aberrantes.
- **Des composants à la taille de chaque plateforme** — `SpatialCard`, une barre d'outils qui devient un ornament sous visionOS, et des zones de toucher dimensionnées selon les recommandations d'Apple (60 pt sous visionOS, 44 sous iOS, 28 sous macOS).
- **Les entrées non fiables sont sans danger** — les quantités sont plafonnées à 4096 éléments, les longueurs à 10 km, et les arguments NaN ou infinis reviennent à des valeurs par défaut documentées, si bien qu'une valeur lue dans un fichier ne peut ni épuiser la mémoire ni produire une position infinie.
- **Testé sur trois plateformes** — 97 tests Swift Testing s'exécutent sur macOS et sur un simulateur d'iPhone ; 87 d'entre eux, tous sauf les tests de pixels, s'exécutent aussi sur un simulateur visionOS.

### Contenu

| Domaine           | API                                                                                                                              |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Dispositions      | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI           | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit        | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| Espaces immersifs | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| Manipulation      | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| Composants        | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## Démarrage rapide

**1. Ajouter le paquet**

Dans Xcode, choisissez **File › Add Package Dependencies…** et saisissez l’URL du dépôt :

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Collez-la dans le champ de recherche en haut à droite de la fenêtre. Laissez **Dependency Rule** sur **Up to Next Major Version** à partir de `2.0.0`, puis cliquez sur **Add Package**. Dans la fenêtre suivante, choisissez la cible de votre app à côté de **VisionUI** et cliquez de nouveau sur **Add Package**.

**2. Importer le module**

```swift
import VisionUI
```

Placez cette ligne en haut du fichier Swift où vous utilisez le package, sous `import SwiftUI`.

**3. L’utiliser**

Dans une nouvelle app visionOS (**File › New › Project… › visionOS › App**), remplacez tout le contenu de `ContentView.swift` par :

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

Choisissez le simulateur **Apple Vision Pro** et appuyez sur **Run** (⌘R). Les cinq cartes s'incurvent vers vous comme sur l'image ci-dessus : celle du milieu dans le plan de la fenêtre, les cartes extérieures plus proches et tournées vers le centre de l'arc, à 0.6 m devant la fenêtre. Remplacez le rayon par `0.3` et relancez pour obtenir une courbe plus serrée. Le même code fonctionne aussi sur un iPhone ou un Mac, où l'arc est dessiné vu de face.

## Installation

### Swift Package Manager

Dans Xcode, choisissez **File › Add Package Dependencies…** et saisissez l’URL du dépôt :

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Ou ajoutez-le aux `dependencies` de votre `Package.swift` :

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

La version 2.0.0 (octobre 2026) est un nouveau package avec une nouvelle API. La version précédente, 1.0.0 (février 2026), déclarait une version de plateforme qui n'existe pas (`.visionOS(.v1_0)`) : Swift Package Manager ne pouvait donc pas la résoudre, et ses sources appelaient des API absentes du SDK visionOS. En juin 2026, ce code a été remplacé par des éléments provisoires, puis en octobre 2026 le package a été réécrit de zéro. [CHANGELOG.md](CHANGELOG.md) liste ce qui a changé.

## Utilisation

Les exemples ci-dessous sont copiés depuis
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift).
L'app d'exemple et la suite de tests compilent toutes deux ce fichier.

### Faire tourner un carrousel

`SpatialCarousel` place les vues sur un anneau. Un glissement le fait tourner ; quand le geste se termine, il se cale sur la vue la plus proche et met à jour `selection`. Toucher une vue ou définir `selection` fait venir cette vue à l'avant par le chemin le plus court.

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

### Laisser les utilisateurs déplacer un objet dans des limites

Le globe reste dans une boîte de 40 × 30 × 20 cm, change d'échelle entre la moitié et le double de sa taille, ne tourne qu'autour de l'axe vertical et s'aimante à 45° à la fin d'une rotation.

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

### Disposer des entités RealityKit

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

Passez `duration:` pour animer les entités vers une nouvelle disposition une fois qu'elles sont dans une scène.

### Fixer une barre d'outils à la fenêtre

Sous visionOS, la barre d'outils est un ornament sous la fenêtre ; sous iOS et macOS, elle est dessinée par-dessus le bas du contenu.

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

### Ouvrir un espace immersif

Créez un seul `ImmersiveSpaceCoordinator` dans l'app, placez-le dans l'environnement (environment) et appelez `spaceDidDisappear(_:)` depuis le `onDisappear` de l'espace, afin que le bouton suive aussi lorsque le système ferme l'espace :

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
montre la configuration de la scène et ce que fait le coordinator dans chaque cas.

## Démo

L'app d'exemple dans le simulateur Apple Vision Pro, capturée par
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh) :

| Carrousel                                                                                                                                                                                              | Ornament de la barre d'outils                                                                                                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![La page du carrousel : la carte Mountains à l'avant, les cartes Arctic et City tournées vers l'extérieur sur les côtés, et le texte Showing Mountains en dessous](docs/images/visionos-carousel.png) | ![La page des composants : deux cartes en verre, une petite étoile avec une zone de toucher plus grande, et une barre d'outils avec les boutons précédent, lecture et suivant fixée sous la fenêtre](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="L'espace immersif : des sphères bleues et turquoise réparties dans la pièce à différentes hauteurs, avec la fenêtre de la galerie affichant un bouton Hide Orbit"></p>

Les cinq dispositions avec 12 éléments chacune, vues de dessus (l'observateur en bas) et de face, avec une flèche pour la direction vers laquelle chaque élément est tourné. Rendu à partir des positions calculées par les dispositions elles-mêmes, par
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh) :

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="Schémas des dispositions arc, anneau, grille, sphère et hélice vues de dessus et de face, avec des points pour les éléments et des flèches pour la direction vers laquelle chacun est tourné"></picture></p>

Pour tout essayer vous-même, ouvrez `SpatialGallery.xcodeproj` dans
[`Examples/SpatialGallery`](Examples/SpatialGallery) avec Xcode, choisissez le simulateur **Apple Vision Pro**, un simulateur d'iPhone ou **My Mac**, puis appuyez sur **Run**.
[Examples/README.md](Examples/README.md) décrit chaque page.

## Documentation

Référence de l’API et articles :

- [Référence de l'API](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  (DocC, publiée sur GitHub Pages depuis `main`)
- Compilez-la en local dans Xcode avec **Product › Build Documentation**, ou en ligne de commande :

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## Guides

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — ajouter le package, placer des vues sur un arc, et les conventions de coordonnées
  ([source](Sources/VisionUI/VisionUI.docc/GettingStarted.md)).
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — les cinq dispositions, les vues SwiftUI, les entités RealityKit, le carrousel et la projection à plat
  ([source](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)).
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — un coordinator par app, le bouton à bascule et chaque cas qu'il gère
  ([source](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)).
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — limites, plages d'échelle, rotation à la verticale et aimantation, avec vos propres gestes ou avec le modifier
  ([source](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)).

## Prérequis

| Plateforme  | Version minimale         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| Chaîne d’outils | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` et l'initialiseur d'`ImmersiveSpaceActions` qui prend les actions de l'environnement nécessitent visionOS, ou macOS 26, où SwiftUI propose des espaces immersifs. La CI compile avec le Xcode par défaut de l'image de runner `macos-26` de GitHub. Le package est développé avec Xcode 27.

## Architecture

- `Sources/VisionUI/Geometry/` contient `SpatialPlacement`, les mathématiques communes (rotation pour regarder un point, yaw, bouclage et aimantation des angles) et la conversion entre les mètres du package, avec `+y` vers le haut, et les points de SwiftUI, avec `+y` vers le bas.
- `Layouts/` contient le protocole `SpatialLayout`, les cinq dispositions et `offset(_:)`. Une disposition est une valeur qui transforme un nombre en positions ; elle ne sait rien des vues ni des entités.
- `Views/` place les vues SwiftUI : sous visionOS avec `offset(z:)` et `rotation3DEffect`, à partir des `physicalMetrics` de l'environnement ; sous iOS et macOS par `FlatProjection`.
- `RealityKit/` applique les positions aux entités. `Spaces/` contient le coordinator des espaces immersifs, qui n'appelle le système que par `ImmersiveSpaceActions`, de sorte que les tests le pilotent avec des closures.
- `Manipulation/` contient l'état contraint, avec une valeur de départ par geste, et le modifier qui l'alimente à partir des gestes. `Components/` contient les modifiers de carte, de barre d'outils, d'ornament, de zone de toucher et de profondeur.
- Chaque entrée publique est vérifiée là où elle arrive : les quantités par rapport à `SpatialLayoutLimits`, les longueurs et les angles pour NaN, l'infini et le dépassement. Les tests passent de telles valeurs à chaque disposition, à la projection, à l'état de manipulation et au carrousel.

Lancez les tests en local :

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Feuille de route

- Ajouter le package au Swift Package Index ; `.spi.yml` est déjà dans le dépôt.
- Des dispositions qui suivent une surface détectée par ARKit, comme un mur ou une table, dans un espace immersif.
- Une variante du carrousel qui défile le long d'un arc, pour les longues listes.

## Contribuer

Les contributions sont les bienvenues. Lisez le [guide de contribution](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md) et le [code de conduite](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) avant d’ouvrir une pull request. Signalez les problèmes de sécurité en privé, comme indiqué dans la [politique de sécurité](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licence

Publié sous licence MIT. Voir [LICENSE](LICENSE).
