# Changelog

All notable changes to this project are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> Tag status: this repository currently has no published git tags yet.
> Create and push `v0.1.0` for the first official release.

## [Unreleased]

### Added
- Configurable shimmer direction via `ShimmerConfig.angle` in rendering.
- Configurable base placeholder color via `ShimmerConfig.skeletonColor`.
- Convenience `ShimmerConfig` initializer with `shimmerColor` + `shimmerOpacity`.
- New public `ShimmerKit.config(...)` overloads for color-first configuration.
- Optional multiple shape support with `SkeletonShapeStyle` (`automatic`, `roundedRectangle`, `capsule`, `circle`).
- `skeletonNode(..., shape:, scope:)` support for explicit shape and scope tagging.
- Partial rendering support with `smartSkeleton(..., includeScopes:)`.
- Optional multiline text splitting via `splitMultilineText`.
- Optional semantic text grouping via `enableSemanticGrouping`.
- Optional SwiftUI `Layout` integration via `useLayoutProtocolIntegration`.
- Preset profiles with `ShimmerProfile` and `ShimmerKit.config(_ profile:)`.
- Full showcase demo app in `Examples/ShimmerKitShowcaseApp/`.
- Standalone Xcode project for showcase demo app.
- Redacted comparison demo screen (`Apple .redacted` vs `ShimmerKit`).

### Changed
- Shimmer rendering now adapts movement to placeholder geometry.
- Shimmer animation updated to use animated gradient endpoints for smoother sweep.
- Skeleton capture/render pipeline improved for list and global coordinate alignment.
- Placeholder content hiding switched to opacity-based hidden behavior for stable layout capture.
- `SmartSkeletonContainer` geometry handling moved to overlay path to avoid root layout distortion.
- `SkeletonNode` identity made deterministic/computed for stable `ForEach` rendering.

### Fixed
- Duplicate `ForEach` ID issues from transformed skeleton nodes.
- Missing shimmer placeholders in repeated list rows.
- List placeholder vertical offset/centering mismatch due to coordinate-space drift.
- Clipped or partially rendered shimmer cards while loading in comparison view.
- Repeated preference churn warnings mitigated with normalized preference updates.

## [0.1.0] - 2026-03-19

### Added
- Initial release of ShimmerKit.
- Automatic layout-aware skeleton node capture and rendering.
- Heuristic skeleton kind detection (`text`, `image`, `generic`).
- Timeline-based shimmer rendering.
- Public `smartSkeleton`, `skeletonNode`, and `skeletonID` APIs.
- Swift Package Manager support.

[Unreleased]: https://github.com/Sharnabh/ShimmerKit/commits/main
[0.1.0]: https://github.com/Sharnabh/ShimmerKit/releases
