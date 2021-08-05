// swift-tools-version:5.3
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
        .package(url: "https://github.com/futuredapp/FTAPIKit.git", .branch("main"))
    ],
    targets: [
        .target(name: "BurningRingOfFire", dependencies: ["Gtk"]),
    ]
)
