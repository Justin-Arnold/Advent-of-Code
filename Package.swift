// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    products: [
        .executable(
            name: "aoc",
            targets: ["Puzzles"]),
        .executable(
            name: "aoc-2022",
            targets: ["2022"]),
        .executable(
            name: "aoc-2023",
            targets: ["2023"]),
    ],
    targets: [
        .executableTarget(
            name: "Puzzles",
            path: "Sources/Puzzles"),
        .executableTarget(
            name: "2022",
            path: "Sources/2022"),
        .executableTarget(
            name: "2023",
            path: "Sources/2023"),
        .testTarget(
            name: "Tests",
            dependencies: ["Puzzles"],
            path: "Tests")
    ]
)