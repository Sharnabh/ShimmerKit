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
        speed: 0.8,
        angle: .degrees(45)
    )
)
```

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
