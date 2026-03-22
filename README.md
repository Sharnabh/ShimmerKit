# ShimmerKit

A **layout-aware, auto-generating skeleton loader** for SwiftUI.

## Requirements

- iOS 16+
- Swift 5.9+
- SwiftUI

## Installation

Add with Swift Package Manager:

```text
https://github.com/Sharnabh/ShimmerKit
```

In Xcode:

1. File → Add Packages
2. Paste the URL
3. Add `ShimmerKit`

## Quick Start

```swift
import SwiftUI
import ShimmerKit

struct ProductView: View {
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Product title")
                .skeletonNode(kind: .text(lineHeight: 18))

            Text("Product subtitle")
                .skeletonNode(kind: .text(lineHeight: 14))

            RoundedRectangle(cornerRadius: 12)
                .frame(height: 120)
                .skeletonNode(kind: .image)
        }
        .smartSkeleton(isLoading)
    }
}
```

## Full Demo App

For a single app that demonstrates every public API and feature toggle, see:

- `Examples/ShimmerKitShowcaseApp/`

---

## Public API Reference

### `View` extension APIs

#### `smartSkeleton(_:config:includeScopes:)`

```swift
func smartSkeleton(
    _ isLoading: Bool,
    config: ShimmerConfig = ShimmerConfig(),
    includeScopes: [String]? = nil
) -> some View
```

- `isLoading`: when `true`, skeletons render.
- `config`: shimmer behavior and style.
- `includeScopes`: optional partial rendering filter.

Examples:

```swift
content.smartSkeleton(isLoading)

content.smartSkeleton(
    isLoading,
    config: ShimmerKit.config(.feedLoading),
    includeScopes: ["header", "body"]
)
```

#### `skeletonNode(cornerRadius:kind:shape:scope:)`

```swift
func skeletonNode(
    cornerRadius: CGFloat? = nil,
    kind: SkeletonKind? = nil,
    shape: SkeletonShapeStyle = .automatic,
    scope: String? = nil
) -> some View
```

- Marks a view as a skeleton target.
- `scope` works with `includeScopes` in `smartSkeleton`.

Examples:

```swift
Text("Title")
    .skeletonNode(kind: .text(lineHeight: 18), shape: .capsule, scope: "header")

Circle()
    .frame(width: 44, height: 44)
    .skeletonNode(kind: .image, shape: .circle, scope: "avatar")
```

#### `skeletonID(_:)`

```swift
func skeletonID(_ id: AnyHashable) -> some View
```

- Provides stable identity for lazy containers/lists.

Example:

```swift
ForEach(items, id: \.id) { item in
    Row(item: item)
        .skeletonID(item.id)
}
```

---

### `ShimmerKit` APIs

#### `ShimmerKit.defaultConfig`

```swift
public static let defaultConfig: ShimmerConfig
```

Example:

```swift
content.smartSkeleton(isLoading, config: ShimmerKit.defaultConfig)
```

#### `ShimmerKit.config(_ profile: ShimmerProfile)`

```swift
public static func config(_ profile: ShimmerProfile) -> ShimmerConfig
```

Available profiles:

- `.default`
- `.subtle`
- `.feedLoading`
- `.detailPage`

Example:

```swift
content.smartSkeleton(isLoading, config: ShimmerKit.config(.subtle))
```

#### `ShimmerKit.config(gradient:...)`

```swift
public static func config(
    gradient: Gradient = Gradient(colors: [.clear, Color.white.opacity(0.35), .clear]),
    skeletonColor: Color = Color.gray.opacity(0.25),
    speed: Double = 1.2,
    angle: Angle = .degrees(20),
    splitMultilineText: Bool = false,
    enableSemanticGrouping: Bool = false,
    useLayoutProtocolIntegration: Bool = false
) -> ShimmerConfig
```

Example:

```swift
let config = ShimmerKit.config(
    gradient: Gradient(colors: [.clear, .purple.opacity(0.4), .clear]),
    skeletonColor: .purple.opacity(0.15),
    speed: 1.0,
    angle: .degrees(35),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: false
)
```

#### `ShimmerKit.config(shimmerColor:...)`

```swift
public static func config(
    shimmerColor: Color,
    skeletonColor: Color = Color.gray.opacity(0.25),
    shimmerOpacity: Double = 0.35,
    speed: Double = 1.2,
    angle: Angle = .degrees(20),
    splitMultilineText: Bool = false,
    enableSemanticGrouping: Bool = false,
    useLayoutProtocolIntegration: Bool = false
) -> ShimmerConfig
```

Example:

```swift
let config = ShimmerKit.config(
    shimmerColor: .mint,
    skeletonColor: .mint.opacity(0.18),
    shimmerOpacity: 0.45,
    speed: 1.0,
    angle: .degrees(30),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)
```

---

### `ShimmerConfig`

`ShimmerConfig` is the central style/behavior object.

#### Stored properties

- `gradient: Gradient`
- `skeletonColor: Color`
- `speed: Double`
- `angle: Angle`
- `splitMultilineText: Bool`
- `enableSemanticGrouping: Bool`
- `useLayoutProtocolIntegration: Bool`

#### Initializer: `gradient` based

```swift
public init(
    gradient: Gradient = Gradient(colors: [.clear, Color.white.opacity(0.35), .clear]),
    skeletonColor: Color = Color.gray.opacity(0.25),
    speed: Double = 1.2,
    angle: Angle = .degrees(20),
    splitMultilineText: Bool = false,
    enableSemanticGrouping: Bool = false,
    useLayoutProtocolIntegration: Bool = false
)
```

#### Initializer: `shimmerColor` based

```swift
public init(
    shimmerColor: Color,
    skeletonColor: Color = Color.gray.opacity(0.25),
    shimmerOpacity: Double = 0.35,
    speed: Double = 1.2,
    angle: Angle = .degrees(20),
    splitMultilineText: Bool = false,
    enableSemanticGrouping: Bool = false,
    useLayoutProtocolIntegration: Bool = false
)
```

---

### Enums

#### `ShimmerProfile`

```swift
public enum ShimmerProfile: Hashable, Sendable {
    case `default`
    case subtle
    case feedLoading
    case detailPage
}
```

#### `SkeletonKind`

```swift
public enum SkeletonKind: Hashable, Sendable {
    case text(lineHeight: CGFloat)
    case image
    case generic
}
```

#### `SkeletonShapeStyle`

```swift
public enum SkeletonShapeStyle: Hashable, Sendable {
    case automatic
    case roundedRectangle(cornerRadius: CGFloat)
    case capsule
    case circle
}
```

---

### `SkeletonNode` (advanced)

`SkeletonNode` is the captured/rendered node model used internally and exposed publicly.

```swift
public struct SkeletonNode: Identifiable, Hashable, Sendable {
    public let id: UUID
    public var frame: CGRect
    public var cornerRadius: CGFloat
    public var kind: SkeletonKind
    public var shapeStyle: SkeletonShapeStyle
    public var scope: String?
}
```

---

## Feature Toggles (Optional)

All advanced behavior is opt-in and defaults to off:

- `splitMultilineText`
- `enableSemanticGrouping`
- `useLayoutProtocolIntegration`

Example:

```swift
let config = ShimmerConfig(
    shimmerColor: .cyan,
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)

content.smartSkeleton(isLoading, config: config)
```

## Partial Rendering with Scopes

```swift
VStack {
    Text("Header").skeletonNode(scope: "header")
    Text("Body").skeletonNode(scope: "body")
    Button("Retry") {}.skeletonNode(scope: "actions")
}
.smartSkeleton(
    true,
    includeScopes: ["header", "body"]
)
```

## License

MIT

## Maintenance

- Release process: `RELEASE_CHECKLIST.md`

# ✨ ShimmerKit

A **layout-aware, auto-generating skeleton loader** for SwiftUI.

Not another shimmer modifier.
This is a **rendering system** that mirrors your actual UI layout and builds skeletons automatically.

---

## 🚀 Features

* ⚡ **Auto Layout Skeletons**
  No manual placeholder views. It reads your real UI and generates skeletons.

* 🧠 **Heuristic-Based Rendering**
  Detects:

  * Text → pill-shaped lines
  * Images → rounded blocks
  * Generic views → adaptive shapes

* 🎯 **Zero Layout Duplication**
  Your skeleton always matches your UI. No maintenance hell.

* 🔄 **Timeline-based Animation**
  Uses `TimelineView` for smooth, frame-synced shimmer.

* 📦 **Swift Package Manager Ready**

* 🧵 **Swift 6 Concurrency Safe**

* 📱 **iOS 16+ Only (by design)**

---

## 📦 Installation

### Swift Package Manager

Add this to your project:

```
https://github.com/Sharnabh/ShimmerKit
```

Or in Xcode:

1. File → Add Packages
2. Paste the repo URL
3. Select **ShimmerKit**

---

## 🧱 Basic Usage

### 1. Apply skeleton to any view

```swift
ProductCards(...)
    .smartSkeleton(true)
```

That’s it.

No duplicate UI. No placeholder views.

---

## 🔄 Toggle Loading State

```swift
.smartSkeleton(isLoading)
```

* `true` → skeleton shown
* `false` → real UI shown

---

## 🧠 How It Works

1. Your views are rendered normally (but hidden)
2. Layout frames are captured using `GeometryReader`
3. Frames are processed:

   * filtered
   * merged
   * grouped
4. Skeleton shapes are drawn on top
5. Shimmer animation is applied via `TimelineView`

---

## 🎯 Advanced Usage

### ✏️ Manually define skeleton behavior

Override automatic detection when needed:

```swift
Text("Title")
    .skeletonNode(kind: .text(lineHeight: 12))

AsyncImage(...)
    .skeletonNode(kind: .image, cornerRadius: 12)
```

---

### 🆔 Fix LazyVStack / Scroll issues

```swift
ForEach(items, id: \.id) { item in
    ProductCards(...)
        .skeletonID(item.id)
}
```

Prevents flickering and incorrect frame reuse.

---

### ⚙️ Customize shimmer

```swift
.smartSkeleton(
    true,
    config: ShimmerConfig(
        gradient: Gradient(colors: [
            .clear,
            .white.opacity(0.4),
            .clear
        ]),
        skeletonColor: Color.gray.opacity(0.2),
        speed: 0.8,
        angle: .degrees(45)
    )
)
```

### 🌈 Change shimmer and skeleton colors

Use a single shimmer tint color and custom base skeleton color:

```swift
.smartSkeleton(
    true,
    config: ShimmerKit.config(
        shimmerColor: .mint,
        skeletonColor: .mint.opacity(0.18),
        shimmerOpacity: 0.45,
        speed: 1.0,
        angle: .degrees(30)
    )
)
```

---

## 📚 Complete Usage Snippets (All Public APIs)

### 1) `smartSkeleton(_:config:)` with defaults

```swift
struct ProductView: View {
    @State private var isLoading = true

    var body: some View {
        VStack {
            Text("Product Title").skeletonNode()
            Text("₹99").skeletonNode()
        }
        .smartSkeleton(isLoading)
    }
}
```

### 2) `smartSkeleton(_:config:)` with custom config

```swift
VStack(alignment: .leading, spacing: 8) {
    Text("Headline").skeletonNode(kind: .text(lineHeight: 20))
    Text("Subtitle").skeletonNode(kind: .text(lineHeight: 14))
}
.smartSkeleton(
    true,
    config: ShimmerConfig(
        gradient: Gradient(colors: [.clear, .blue.opacity(0.4), .clear]),
        skeletonColor: .blue.opacity(0.15),
        speed: 0.9,
        angle: .degrees(35)
    )
)
```

### 3) `skeletonNode()` (auto-detect kind + corner radius)

```swift
Text("Auto detected skeleton")
    .font(.body)
    .skeletonNode()
```

### 4) `skeletonNode(cornerRadius:)`

```swift
RoundedRectangle(cornerRadius: 16)
    .frame(height: 60)
    .skeletonNode(cornerRadius: 20)
```

### 5) `skeletonNode(kind:)`

```swift
Text("Name")
    .skeletonNode(kind: .text(lineHeight: 18))

Image(systemName: "person.crop.circle.fill")
    .resizable()
    .frame(width: 40, height: 40)
    .skeletonNode(kind: .image)

Rectangle()
    .frame(height: 80)
    .skeletonNode(kind: .generic)
```

### 6) `skeletonNode(cornerRadius:kind:)`

```swift
AsyncImage(url: URL(string: "https://example.com/cover.jpg")) { image in
    image.resizable().scaledToFill()
} placeholder: {
    Color.gray
}
.frame(width: 120, height: 120)
.clipShape(RoundedRectangle(cornerRadius: 18))
.skeletonNode(cornerRadius: 18, kind: .image)
```

### 7) `skeletonID(_:)` for stable identity in lists/lazy stacks

```swift
ForEach(items, id: \.id) { item in
    HStack {
        Circle().frame(width: 44, height: 44).skeletonNode(kind: .image)
        Text(item.title).skeletonNode(kind: .text(lineHeight: 16))
    }
    .skeletonID(item.id)
}
```

### 8) Multiple shape support (`shape:`)

```swift
VStack(spacing: 12) {
    Circle()
        .frame(width: 48, height: 48)
        .skeletonNode(shape: .circle)

    Text("Name")
        .skeletonNode(kind: .text(lineHeight: 16), shape: .capsule)

    Rectangle()
        .frame(height: 56)
        .skeletonNode(shape: .roundedRectangle(cornerRadius: 14))
}
.smartSkeleton(true)
```

### 9) Partial skeleton rendering (`includeScopes:`)

Render shimmer only on specific skeleton scopes.

```swift
VStack(alignment: .leading, spacing: 10) {
    Text("Header")
        .skeletonNode(scope: "header")

    Text("Body line 1")
        .skeletonNode(scope: "body")

    Text("Body line 2")
        .skeletonNode(scope: "body")

    Button("Retry") {}
        .skeletonNode(scope: "actions")
}
.smartSkeleton(
    true,
    includeScopes: ["header", "body"]
)
```

### 10) Turn partial rendering OFF (default)

```swift
content.smartSkeleton(isLoading)
```

or

```swift
content.smartSkeleton(isLoading, includeScopes: nil)
```

### 11) Multi-line text splitting (optional)

When enabled, text skeleton blocks can be split into multiple pill lines.

```swift
let config = ShimmerKit.config(
    shimmerColor: .mint,
    skeletonColor: .mint.opacity(0.2),
    angle: .degrees(30),
    splitMultilineText: true
)

content.smartSkeleton(isLoading, config: config)
```

### 12) Keep multi-line text splitting OFF (default)

```swift
let config = ShimmerConfig(
    gradient: Gradient(colors: [.clear, .white.opacity(0.4), .clear]),
    skeletonColor: .gray.opacity(0.2),
    speed: 1.0,
    angle: .degrees(20)
)

content.smartSkeleton(isLoading, config: config)
```

### 13) Semantic grouping (title vs subtitle) (optional)

When enabled, text skeletons are heuristically grouped into title/subtitle styles (subtitle lines become slightly shorter).

```swift
let config = ShimmerKit.config(
    shimmerColor: .indigo,
    skeletonColor: .indigo.opacity(0.18),
    splitMultilineText: true,
    enableSemanticGrouping: true
)

content.smartSkeleton(isLoading, config: config)
```

### 14) Keep semantic grouping OFF (default)

```swift
let config = ShimmerConfig(
    gradient: Gradient(colors: [.clear, .white.opacity(0.35), .clear]),
    skeletonColor: .gray.opacity(0.2),
    speed: 1.0,
    angle: .degrees(20),
    splitMultilineText: true,
    enableSemanticGrouping: false
)

content.smartSkeleton(isLoading, config: config)
```

### 15) SwiftUI Layout protocol integration (optional)

Enable this to route hidden content through a `Layout`-based placement path.

```swift
let config = ShimmerKit.config(
    shimmerColor: .blue,
    skeletonColor: .blue.opacity(0.18),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)

content.smartSkeleton(isLoading, config: config)
```

### 16) Keep Layout integration OFF (default)

```swift
let config = ShimmerConfig(
    gradient: Gradient(colors: [.clear, .white.opacity(0.35), .clear]),
    skeletonColor: .gray.opacity(0.2),
    speed: 1.0,
    angle: .degrees(20),
    splitMultilineText: false,
    enableSemanticGrouping: false,
    useLayoutProtocolIntegration: false
)

content.smartSkeleton(isLoading, config: config)
```

### 17) `ShimmerKit.defaultConfig`

```swift
VStack {
    Text("Default config")
        .skeletonNode()
}
.smartSkeleton(true, config: ShimmerKit.defaultConfig)
```

### 18) `ShimmerKit.config(gradient:skeletonColor:speed:angle:splitMultilineText:enableSemanticGrouping:useLayoutProtocolIntegration:)`

```swift
let config = ShimmerKit.config(
    gradient: Gradient(colors: [.clear, .purple.opacity(0.45), .clear]),
    skeletonColor: .purple.opacity(0.18),
    speed: 1.1,
    angle: .degrees(60),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)

content.smartSkeleton(isLoading, config: config)
```

### 19) `ShimmerKit.config(shimmerColor:skeletonColor:shimmerOpacity:speed:angle:splitMultilineText:enableSemanticGrouping:useLayoutProtocolIntegration:)`

```swift
let config = ShimmerKit.config(
    shimmerColor: .mint,
    skeletonColor: .mint.opacity(0.2),
    shimmerOpacity: 0.5,
    speed: 1.0,
    angle: .degrees(25),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)

content.smartSkeleton(isLoading, config: config)
```

### 20) `ShimmerConfig(...)` full initializer

```swift
let custom = ShimmerConfig(
    gradient: Gradient(colors: [.clear, .orange.opacity(0.4), .clear]),
    skeletonColor: .orange.opacity(0.16),
    speed: 0.85,
    angle: .degrees(45),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)
```

### 21) `ShimmerConfig(shimmerColor:skeletonColor:shimmerOpacity:speed:angle:splitMultilineText:enableSemanticGrouping:useLayoutProtocolIntegration:)`

```swift
let quick = ShimmerConfig(
    shimmerColor: .teal,
    skeletonColor: .teal.opacity(0.15),
    shimmerOpacity: 0.4,
    speed: 1.25,
    angle: .degrees(30),
    splitMultilineText: true,
    enableSemanticGrouping: true,
    useLayoutProtocolIntegration: true
)
```

### 22) End-to-end screen example

```swift
import SwiftUI
import ShimmerKit

struct UserRow: View {
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 44, height: 44)
                .skeletonNode(kind: .image)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .skeletonNode(kind: .text(lineHeight: 18))

                Text("Subtitle")
                    .font(.subheadline)
                    .skeletonNode(kind: .text(lineHeight: 14))
            }
        }
        .padding(.vertical, 6)
    }
}

struct UsersScreen: View {
    @State private var isLoading = true
    private let placeholders = Array(0..<6)
    private let users = ["Jane", "Alex", "Mia"]

    var body: some View {
        List {
            ForEach(isLoading ? placeholders.map(String.init) : users, id: \.self) { value in
                UserRow(title: value)
                    .skeletonID(value)
            }
        }
        .smartSkeleton(
            isLoading,
            config: ShimmerKit.config(
                shimmerColor: .cyan,
                skeletonColor: .cyan.opacity(0.15),
                shimmerOpacity: 0.45,
                speed: 1.0,
                angle: .degrees(40),
                splitMultilineText: true,
                enableSemanticGrouping: true,
                useLayoutProtocolIntegration: true
            )
        )
        .task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            isLoading = false
        }
    }
}
```

### 23) Preset profiles (`ShimmerProfile`)

Use ready-made configs for common loading styles:

```swift
content.smartSkeleton(isLoading, config: ShimmerKit.config(.default))
content.smartSkeleton(isLoading, config: ShimmerKit.config(.subtle))
content.smartSkeleton(isLoading, config: ShimmerKit.config(.feedLoading))
content.smartSkeleton(isLoading, config: ShimmerKit.config(.detailPage))
```

Profile intent:

* `.default` → balanced baseline config
* `.subtle` → softer highlight + slower animation
* `.feedLoading` → stronger shimmer for list/feed placeholders
* `.detailPage` → richer shimmer with advanced toggles enabled

---

## 🎨 Skeleton Types

| Type       | Behavior                              |
| ---------- | ------------------------------------- |
| `.text`    | Rounded pill (auto line height)       |
| `.image`   | Rounded rectangle (12 default radius) |
| `.generic` | Default rounded rectangle             |

---

## 🧠 Heuristics (Auto Detection)

ShimmerKit automatically infers:

* **Text** → height < 20
* **Image** → width ≈ height
* **Generic** → everything else

You can override anytime.

---

## ⚠️ Requirements

* iOS 16+
* Swift 5.9+
* SwiftUI

---

## 🧵 Concurrency

Fully compatible with **Swift 6 strict concurrency**:

* `Sendable` models
* Safe `PreferenceKey` usage
* No unsafe global state

---

## 🧱 Architecture

```
Input Layer
   ↓
Skeleton Nodes (layout capture)
   ↓
Processing Engine (merge + group)
   ↓
Renderer (shapes + shimmer)
```

---

## 📁 Project Structure

```
Core/
Skeleton/
Modifiers/
Containers/
Engine/
Shapes/
Extensions/
Utilities/
```

---

## 🚫 What This Is NOT

* ❌ Not a simple `.shimmer()` modifier
* ❌ Not manual skeleton UI
* ❌ Not tied to specific layouts

---

## 💣 Why ShimmerKit

Most libraries:

> “Draw grey rectangles”

ShimmerKit:

> **Reconstructs your UI structure automatically**

---

## 🧪 Example

```swift
VStack(alignment: .leading, spacing: 12) {
    Text("Product Title")
    Text("Subtitle")
    HStack {
        Text("₹99")
        Text("₹199")
    }
}
.smartSkeleton(true)
```

---

## 🚀 Roadmap

* 🔥 Multi-line text splitting
* ⚡ SwiftUI Layout protocol integration
* 🎯 Partial skeleton rendering
* 🧠 Semantic grouping (title vs subtitle detection)
* 🎨 Multiple shape support (circle, capsule, etc.)

---

## 🛠️ Contributing

PRs are welcome—but keep it:

* clean
* modular
* concurrency-safe

---

## 📄 License

MIT License

---

## 👤 Author

Built with intent, not shortcuts.

---

## ⭐ Final Note

If your skeleton UI breaks when your layout changes,
you built it wrong.

ShimmerKit fixes that.
