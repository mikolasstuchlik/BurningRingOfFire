// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BurningRingOfFire",
    products: [
        .executable(name: "BurningRingOfFire", targets: ["BurningRingOfFire"])
    ],
    dependencies: [
        .package(name: "gir2swift", url: "https://github.com/rhx/gir2swift.git", .branch("main")),
        .package(name: "Gtk", url: "https://github.com/rhx/SwiftGtk.git", .branch("main")),
        .package(url: "https://github.com/futuredapp/FTAPIKit.git", .branch("main")),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .revision("0a9893ec030501a3956bee572d6b4fdd3ae158a1")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.4.1"))
    ],
    targets: [
        .executableTarget(name: "BurningRingOfFire", dependencies: ["Gtk", "BurningModels", "BurningStorage", "BurningFioAPI"]),
        .target(name: "BurningStorage", dependencies: [.product(name: "SQLite", package: "SQLite.swift"), "CryptoSwift", "BurningModels"]),
        .target(name: "BurningFioAPI", dependencies: ["FTAPIKit", "BurningModels"]),
        .target(name: "BurningModels", dependencies: []),
        .testTarget(name: "BurningRingOfFireTests", dependencies: ["BurningRingOfFire"])
    ]
)
