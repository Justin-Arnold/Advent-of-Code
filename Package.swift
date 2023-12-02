// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    products: [
        .executable(
            name: "aoc",
            targets: ["Puzzles"]),
    ],
    targets: [
        .executableTarget(
            name: "Puzzles",
            path: "Sources/Puzzles"),
        .testTarget(
            name: "Tests",
            dependencies: ["Puzzles"],
            path: "Tests")
    ]
)