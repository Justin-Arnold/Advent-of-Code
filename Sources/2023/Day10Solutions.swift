
import Foundation

struct Day10_2023: DayChallenge {
    static func partOne(input: String) -> String {
        let grid = input.split(separator: "\n").map { Array($0) }
        var graph = [Point: [Point]]()
        var start = Point(x: 0, y: 0)

        for (x, line) in grid.enumerated() {
            for (y, tile) in line.enumerated() {
                var adjacent = [Point]()
                if "-J7S".contains(tile) {
                    adjacent.append(Point(x: x, y: y - 1))
                }
                if "-FLS".contains(tile) {
                    adjacent.append(Point(x: x, y: y + 1))
                }
                if "|F7S".contains(tile) {
                    adjacent.append(Point(x: x + 1, y: y))
                }
                if "|LJS".contains(tile) {
                    adjacent.append(Point(x: x - 1, y: y))
                }
                if tile == "S" {
                    start = Point(x: x, y: y)
                }
                graph[Point(x: x, y: y)] = adjacent
            }
        }

        var steps = -1
        var q = Set([start])
        var visited = Set([start])

        while !q.isEmpty {
            var nxt = Set<Point>()
            for point in q {
                guard let neighbors = graph[point] else { continue }
                for neighbor in neighbors {
                    if !visited.contains(neighbor), graph[neighbor]?.contains(point) == true {
                        nxt.insert(neighbor)
                        visited.insert(neighbor)
                    }
                }
            }
            q = nxt
            steps += 1
        }

        return String(steps)
    }
    static func partTwo(input: String) -> String {

        let input = """
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJIF7FJ-
L---JF-JLJIIIIFJLJJ7
|F|F-JF---7IIIL7L|7|
|FFJF7L7F-JF7IIL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L
"""

        //parse input to rows
        let rows = input.split(separator: "\n").map { Array($0) }
        var mat: [[Character]] = rows.map { Array($0) }
        let directions: [Character: [Point]] = [
            "|": [Point(x: -1, y: 0), Point(x: 1, y: 0)],
            "-": [Point(x: 0, y: -1), Point(x: 0, y: 1)],
            "L": [Point(x: -1, y: 0), Point(x: 0, y: 1)],
            "J": [Point(x: -1, y: 0), Point(x: 0, y: -1)],
            "7": [Point(x: 1, y: 0), Point(x: 0, y: -1)],
            "F": [Point(x: 1, y: 0), Point(x: 0, y: 1)],
            "S": [Point(x: -1, y: 0), Point(x: 0, y: -1), Point(x: 0, y: 1), Point(x: 1, y: 0)],
            ".": []
        ]

        func neighbors(of point: Point, flood: Bool = false) -> [Point] {
            let opts = flood ? directions["S"]! : directions[mat[point.x][point.y]]!
            return opts.compactMap { opt in
                let newPoint = Point(x: point.x + opt.x, y: point.y + opt.y)
                guard newPoint.x >= 0, newPoint.x < mat.count, newPoint.y >= 0, newPoint.y < mat[newPoint.x].count else {
                    return nil
                }
                let isDot = mat[newPoint.x][newPoint.y] == "."
                return flood != isDot ? nil : newPoint
            }
        }

        func floodFill(from start: Point) -> Int {
            var queue: [Point] = [start]
            var rounds = 0
            var seen: Set<Point> = []
            while !queue.isEmpty {
                for _ in 0..<queue.count {
                    let point = queue.removeFirst()
                    if mat[point.x][point.y] != "." {
                        continue
                    }
                    mat[point.x][point.y] = "@"
                    for neighbor in neighbors(of: point, flood: true) {
                        if !seen.contains(neighbor) {
                            seen.insert(neighbor)
                            queue.append(neighbor)
                        }
                    }
                }
                rounds += 1
            }
            return rounds
        }

        func nextPoint(from current: Point, considering previous: Point) -> Point? {
            for next in neighbors(of: current) {
                if current == previous && !neighbors(of: next).contains(where: { $0 == current }) {
                    continue
                }
                if next == previous {
                    continue
                }
                return next
            }
            return nil
        }

        func process() -> Int {
            // Find the starting point
            var start = Point(x: 0, y: 0)
            for (i, row) in mat.enumerated() {
                for (j, char) in row.enumerated() {
                    if char == "S" {
                        start = Point(x: i, y: j)
                        break
                    }
                }
            }

            // Find and mark the cycle
            var cycle: Set<Point> = []
            var current = start
            var previous = start
            while current == previous || current != start {
                cycle.insert(current)
                if let nextPoint = nextPoint(from: current, considering: previous) {
                    previous = current
                    current = nextPoint
                } else {
                    break
                }
            }

            // Clear junk
            for i in 0..<mat.count {
                for j in 0..<mat[i].count {
                    if !cycle.contains(Point(x: i, y: j)) {
                        mat[i][j] = "."
                    }
                }
            }

            // Perform flood fill
            for i in 0..<mat.count {
                _ = floodFill(from: Point(x: i, y: 0))
                _ = floodFill(from: Point(x: i, y: mat[i].count - 1))
            }

            // Count and modify grid
            var count = 0
            for (i, row) in mat.enumerated() {
                var out = true
                var semi: Character = " "
                for (j, char) in row.enumerated() {
                    if !out && char == "." {
                        count += 1
                        mat[i][j] = "$"
                    }
                    if char == "|" || (char == semi || (semi != " " && char == "S")) {
                        out.toggle()
                    }
                    if char == "L" {
                        semi = "7"
                    } else if char == "F" {
                        semi = "J"
                    } else if char != "-" {
                        semi = " "
                    }
                }
            }

            return count
        }

        let result = process()
        return String(result)
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}

