import Foundation

struct Day3_2023: DayChallenge {
    static func partOne(input: String) -> String {
        func isSymbol(_ ch: Character) -> Bool {
            return ch != "." && !ch.isNumber
        }

        func isAdjacentToSymbol(_ numberLocations: [(Int, Int)], in schematic: [[Character]]) -> Bool {
            for (x, y) in numberLocations {
                for dx in -1...1 {
                    for dy in -1...1 {
                        let newX = x + dx
                        let newY = y + dy
                        if newX >= 0, newY >= 0, newX < schematic.count, newY < schematic[0].count,
                            isSymbol(schematic[newX][newY]) {
                            return true
                        }
                    }
                }
            }
            return false
        }

        let lines = input.components(separatedBy: "\n").map { Array($0) }.filter { !$0.isEmpty }

        var sum = 0
        var numberLocations = [(Int, Int)]()
        var currentNumber = ""

        for i in 0..<lines.count {
            for j in 0..<lines[0].count {
                // print(i, j)
                let ch = lines[i][j]
                if ch.isNumber {
                    currentNumber.append(ch)
                    numberLocations.append((i, j))
                } else {
                    if !currentNumber.isEmpty && isAdjacentToSymbol(numberLocations, in: lines) {
                        sum += Int(currentNumber) ?? 0
                    }
                    currentNumber = ""
                    numberLocations.removeAll()
                }
            }
            if !currentNumber.isEmpty && isAdjacentToSymbol(numberLocations, in: lines) {
                sum += Int(currentNumber) ?? 0
            }
            currentNumber = ""
            numberLocations.removeAll()
        }

        return String(sum)
    }
    static func partTwo(input: String) -> String {

        func isSymbol(_ ch: Character) -> Bool {
            return ch == "*"
        }

        func findNumbersAroundSymbol(at i: Int, _ j: Int, in schematic: [[Character]]) -> [Int] {
            var numbers = Set<Int>()
            for dx in -1...1 {
                for dy in -1...1 {
                    let newX = i + dx
                    let newY = j + dy
                    if newX >= 0, newY >= 0, newX < schematic.count, newY < schematic[0].count,
                    schematic[newX][newY].isNumber {
                        let number = findWholeNumber(startingAt: newX, newY, in: schematic)
                        numbers.insert(number)
                    }
                }
            }
            return Array(numbers)
        }

        func findWholeNumber(startingAt i: Int, _ j: Int, in schematic: [[Character]]) -> Int {
            var numberString = ""
            var x = i
            var y = j

            // Move left to the start of the number
            while y >= 0 && schematic[x][y].isNumber {
                y -= 1
            }
            y += 1

            // Move right to get the whole number
            while y < schematic[x].count && schematic[x][y].isNumber {
                numberString.append(schematic[x][y])
                y += 1
            }

            return Int(numberString) ?? 0
        }

        let lines = input.components(separatedBy: "\n").map { Array($0) }.filter { !$0.isEmpty }
        var sum = 0

        for i in 0..<lines.count {
            for j in 0..<lines[0].count {
                if isSymbol(lines[i][j]) {
                    let adjacentNumbers = findNumbersAroundSymbol(at: i, j, in: lines)
                    if adjacentNumbers.count > 1 {
                        sum += adjacentNumbers.reduce(1, *)
                    }
                }
            }
        }

        return String(sum)
    }
}

