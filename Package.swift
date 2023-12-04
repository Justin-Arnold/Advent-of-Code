// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    products: [
        .executable(
            name: "aoc-2015",
            targets: ["2015"]),
        .executable(
            name: "aoc-2016",
            targets: ["2016"]),
        .executable(
            name: "aoc-2017",
            targets: ["2017"]),
        .executable(
            name: "aoc-2018",
            targets: ["2018"]),
        .executable(
            name: "aoc-2019",
            targets: ["2019"]),
        .executable(
            name: "aoc-2020",
            targets: ["2020"]),
        .executable(
            name: "aoc-2021",
            targets: ["2021"]),
        .executable(
            name: "aoc-2022",
            targets: ["2022"]),
        .executable(
            name: "aoc-2023",
            targets: ["2023"]),
    ],
    targets: [
        .executableTarget(
            name: "2015",
            path: "Sources/2015"
        ),
        .executableTarget(
            name: "2016",
            path: "Sources/2016"
        ),
        .executableTarget(
            name: "2017",
            path: "Sources/2017"
        ),
        .executableTarget(
            name: "2018",
            path: "Sources/2018"
        ),
        .executableTarget(
            name: "2019",
            path: "Sources/2019"
        ),
        .executableTarget(
            name: "2020",
            path: "Sources/2020"),
        .executableTarget(
            name: "2021",
            path: "Sources/2021"),
        .executableTarget(
            name: "2022",
            path: "Sources/2022"),
        .executableTarget(
            name: "2023",
            path: "Sources/2023"),
    ]
)