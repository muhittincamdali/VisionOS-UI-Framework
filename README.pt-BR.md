<!-- i18n-source: README.md@a607cdedad0ba713bf27fccccb58208ca691502a status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-pt-BR-light.svg" alt="VisionOS UI Framework: Layouts espaciais, carrossel, espaços imersivos e manipulação com limites para apps visionOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="Status da CI"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="Versão mais recente: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="Plataformas compatíveis: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="Versão da linguagem: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="Licença: MIT"></picture></a>
</p>

<p align="center">
<a href="#início-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-pt-BR-light.svg" alt="Começar"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-pt-BR-light.svg" alt="Documentação"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-pt-BR-light.svg" alt="Exemplos"></picture></a>
</p>

> Esta é uma tradução do README em inglês. Se houver diferença, vale a versão em inglês.

<!-- brand:end -->
Um pacote Swift para apps visionOS: ele posiciona views do SwiftUI e entidades do RealityKit em 3D com cinco layouts (arco, anel, grade, esfera, hélice), transforma um anel de views em um carrossel, abre e fecha espaços imersivos sem as condições de corrida de um flag mantido à mão e permite que as pessoas movam, redimensionem e girem objetos dentro dos limites que você definir. É para desenvolvedores que querem esses blocos espaciais sem escrever a geometria e o tratamento de estado por conta própria. O mesmo código roda no iOS e no macOS, onde os layouts são desenhados vistos de frente, e o pacote não tem dependências.

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="O app de exemplo no simulador do Apple Vision Pro: cinco cartões de vidro com nomes de planetas em um arco que se curva na direção de quem olha, com os cartões das pontas mais próximos e virados para o meio"></p>

## Destaques

- **Cinco layouts espaciais** — arco, anel, grade, esfera e hélice devolvem uma posição em metros e uma orientação para cada item, para views do SwiftUI com `SpatialLayoutView` e para entidades do RealityKit com `arrangeChildren(using:)`.
- **Espaços imersivos sem condições de corrida** — `ImmersiveSpaceCoordinator` recusa uma segunda solicitação durante uma transição, fecha um espaço antes de abrir outro e acompanha o sistema quando a pessoa fecha um espaço com a Digital Crown.
- **Manipulação dentro de limites** — `ManipulationState` mantém um objeto arrastado, pinçado ou girado dentro de uma caixa e de uma faixa de escala, na vertical se você quiser, com encaixe (snapping), e ignora valores de gesto com defeito.
- **Componentes no tamanho de cada plataforma** — `SpatialCard`, uma barra de ferramentas que vira ornament no visionOS e áreas de toque no tamanho indicado pelas diretrizes da Apple (60 pt no visionOS, 44 no iOS, 28 no macOS).
- **Entrada não confiável é segura** — as quantidades são limitadas a 4096 itens e os comprimentos a 10 km, e argumentos NaN ou infinitos voltam a valores padrão documentados, de modo que um valor lido de um arquivo não consegue esgotar a memória nem produzir uma posição infinita.
- **Testado em três plataformas** — 94 testes do Swift Testing rodam no macOS e em um simulador de iPhone; 84 deles, todos menos os testes de pixels, também rodam em um simulador de visionOS.

### O que está incluído

| Área              | API                                                                                                                              |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Layouts           | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI           | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit        | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| Espaços imersivos | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| Manipulação       | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| Componentes       | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## Início rápido

**1. Adicione o pacote**

No Xcode, escolha **File › Add Package Dependencies…** e informe a URL do repositório:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Cole-a no campo de busca no canto superior direito da janela. Deixe **Dependency Rule** em **Up to Next Major Version** a partir de `2.0.0` e clique em **Add Package**. Na janela seguinte, escolha o target do seu app ao lado de **VisionUI** e clique em **Add Package** de novo.

**2. Importe o módulo**

```swift
import VisionUI
```

Coloque esta linha no topo do arquivo Swift em que você usa o pacote, abaixo de `import SwiftUI`.

**3. Use**

Em um app visionOS novo (**File › New › Project… › visionOS › App**), substitua todo o conteúdo de `ContentView.swift` por:

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

Escolha o simulador do **Apple Vision Pro** e pressione **Run** (⌘R). Os cinco cartões se curvam na sua direção como na imagem acima: o do meio no plano da janela e os das pontas mais próximos e virados para o centro do arco, a 0.6 m à frente da janela. Mude o raio para `0.3` e rode de novo para uma curva mais fechada. O mesmo código também roda em um iPhone ou em um Mac, onde o arco é desenhado visto de frente.

## Instalação

### Swift Package Manager

No Xcode, escolha **File › Add Package Dependencies…** e informe a URL do repositório:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Ou adicione-o às `dependencies` do seu `Package.swift`:

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

A versão 2.0.0 (outubro de 2026) é um pacote novo com uma API nova. A versão anterior, 1.0.0 (fevereiro de 2026), declarava uma versão de plataforma que não existe (`.visionOS(.v1_0)`), então o Swift Package Manager não conseguia resolvê-la, e seu código-fonte chamava APIs que não estão no SDK do visionOS. Em junho de 2026 esse código foi trocado por marcadores provisórios e, em outubro de 2026, o pacote foi reescrito do zero. O [CHANGELOG.md](CHANGELOG.md) lista o que mudou.

## Uso

Os exemplos abaixo foram copiados de
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift).
O app de exemplo e a suíte de testes compilam esse arquivo.

### Girar um carrossel

`SpatialCarousel` coloca as views em um anel. Arrastar gira o anel e, quando o gesto termina, ele para na view mais próxima e atualiza `selection`. Tocar em uma view ou definir `selection` gira essa view para a frente pelo caminho mais curto.

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

### Deixar as pessoas moverem um objeto dentro de limites

O globo fica dentro de uma caixa de 40 × 30 × 20 cm, muda de escala entre metade do tamanho e o dobro dele, gira apenas em torno do eixo vertical e se encaixa em 45° quando uma rotação termina.

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

### Organizar entidades do RealityKit

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

Passe `duration:` para animar as entidades até um novo layout depois que elas estiverem em uma cena.

### Prender uma barra de ferramentas à janela

No visionOS, a barra de ferramentas é um ornament abaixo da janela; no iOS e no macOS, ela é desenhada sobre a parte de baixo do conteúdo.

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

### Abrir um espaço imersivo

Crie um único `ImmersiveSpaceCoordinator` no app, coloque-o no ambiente (environment) e chame `spaceDidDisappear(_:)` a partir do `onDisappear` do espaço, para que o botão também acompanhe quando o sistema fechar o espaço:

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
mostra a configuração da cena e o que o coordinator faz em cada caso.

## Demonstração

O app de exemplo no simulador do Apple Vision Pro, capturado por
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh):

| Carrossel                                                                                                                                                                             | Ornament da barra de ferramentas                                                                                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ![A página do carrossel: o cartão Mountains na frente, os cartões Arctic e City virados para fora nas laterais e o texto Showing Mountains abaixo](docs/images/visionos-carousel.png) | ![A página de componentes: dois cartões de vidro, uma estrela pequena com área de toque maior e uma barra de ferramentas com os botões voltar, reproduzir e avançar presa abaixo da janela](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="O espaço imersivo: esferas azuis e verde-azuladas espalhadas pela sala em alturas diferentes, com a janela da galeria mostrando um botão Hide Orbit"></p>

Os cinco layouts com 12 itens cada, vistos de cima (quem olha fica embaixo) e de frente, com uma seta para a direção em que cada item está virado. Renderizado a partir das próprias posições dos layouts por
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh):

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="Diagramas dos layouts de arco, anel, grade, esfera e hélice vistos de cima e de frente, com pontos para os itens e setas para a direção em que cada um está virado"></picture></p>

Para experimentar tudo por conta própria, abra o `SpatialGallery.xcodeproj` em
[`Examples/SpatialGallery`](Examples/SpatialGallery) com o Xcode, escolha o simulador do **Apple Vision Pro**, um simulador de iPhone ou **My Mac** e pressione **Run**.
O [Examples/README.md](Examples/README.md) descreve cada página.

## Documentação

Referência da API e artigos:

- [Referência da API](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  (DocC, publicada no GitHub Pages a partir de `main`)
- Compile-a localmente no Xcode com **Product › Build Documentation** ou pela linha de comando:

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## Guias

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — adicionar o pacote, posicionar views em um arco e as convenções de coordenadas
  ([código-fonte](Sources/VisionUI/VisionUI.docc/GettingStarted.md)).
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — os cinco layouts, views do SwiftUI, entidades do RealityKit, o carrossel e a projeção plana
  ([código-fonte](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)).
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — um coordinator por app, o toggle e todos os casos que ele trata
  ([código-fonte](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)).
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — limites, faixas de escala, rotação na vertical e encaixe, com seus próprios gestos ou com o modifier
  ([código-fonte](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)).

## Requisitos

| Plataforma  | Versão mínima         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| Ferramentas | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` e o inicializador de `ImmersiveSpaceActions` que recebe as ações do ambiente exigem visionOS, ou macOS 26, em que o SwiftUI tem espaços imersivos. O CI compila com o Xcode padrão da imagem de runner `macos-26` do GitHub. O pacote é desenvolvido com o Xcode 27.

## Arquitetura

- `Sources/VisionUI/Geometry/` contém `SpatialPlacement`, a matemática compartilhada (rotação para olhar um ponto, yaw, normalização e encaixe de ângulos) e a conversão entre os metros do pacote, com `+y` para cima, e os pontos do SwiftUI, com `+y` para baixo.
- `Layouts/` contém o protocolo `SpatialLayout`, os cinco layouts e `offset(_:)`. Um layout é um valor que transforma uma quantidade em posições; ele não sabe nada sobre views nem entidades.
- `Views/` posiciona views do SwiftUI: no visionOS com `offset(z:)` e `rotation3DEffect`, usando as `physicalMetrics` do ambiente; no iOS e no macOS por meio de `FlatProjection`.
- `RealityKit/` aplica as posições às entidades. `Spaces/` contém o coordinator de espaços imersivos, que só chama o sistema por meio de `ImmersiveSpaceActions`, então os testes o controlam com closures.
- `Manipulation/` contém o estado com restrições, com um valor inicial por gesto, e o modifier que o alimenta a partir dos gestos. `Components/` contém os modifiers de cartão, barra de ferramentas, ornament, área de toque e profundidade.
- Toda entrada pública é verificada onde entra: as quantidades contra `SpatialLayoutLimits`, os comprimentos e os ângulos quanto a NaN, infinito e estouro. Os testes passam esses valores para cada layout, para a projeção, para o estado de manipulação e para o carrossel.

Rode os testes localmente:

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Roteiro

- Adicionar o pacote ao Swift Package Index; o `.spi.yml` já está no repositório.
- Layouts que seguem uma superfície encontrada pelo ARKit, como uma parede ou uma mesa, em um espaço imersivo.
- Uma variante do carrossel que rola ao longo de um arco, para listas longas.

## Como contribuir

Contribuições são bem-vindas. Leia o [guia de contribuição](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md) e o [código de conduta](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) antes de abrir um pull request. Relate problemas de segurança de forma privada, como descrito na [política de segurança](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licença

Publicado sob a licença MIT. Veja [LICENSE](LICENSE).
