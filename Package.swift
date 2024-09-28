// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RegionSelectionView",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "RegionSelectionView",
      targets: ["RegionSelectionView"])
  ],
  targets: [
    .target(
      name: "RegionSelectionView",
      dependencies: [])
  ],
  swiftLanguageVersions: [.v5]
)
