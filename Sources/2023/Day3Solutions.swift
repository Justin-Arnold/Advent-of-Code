import Foundation

struct Day3_2023: DayChallenge {
    static func partOne(input: String) -> String {
        let schematic = input.components(separatedBy: "\n").map { Array($0) }.filter { !$0.isEmpty }
        let sum = getSumOfPartNumbers(from: schematic)
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
            let x = i
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

func checkForSymbolFromCharacter(named character: Character) -> Bool {
    return character != "." && !character.isNumber
}

func hasSymbolsAroundLocation(at locations: [(Int, Int)], in grid: [[Character]]) -> Bool {
    for (x, y) in locations {
        for deltaX in -1...1 {
            for deltaY in -1...1 {
                let positionToCheck = [
                    "x" : x + deltaX,
                    "y" : y + deltaY
                ]
                let positionIsInGrid = positionToCheck["x"]! >= 0 && positionToCheck["y"]! >= 0 && positionToCheck["x"]! < grid.count && positionToCheck["y"]! < grid[0].count
                if positionIsInGrid,
                    checkForSymbolFromCharacter(named: grid[positionToCheck["x"]!][positionToCheck["y"]!]) {
                        return true
                }
            }
        }
    }
    return false
}

func getSumOfPartNumbers(from grid: [[Character]]) -> Int {

    var sum = 0
    var currentNumber = ""
    var currentNumberLocation = [(Int, Int)]()

    for x in 0..<grid.count {
        for y in 0..<grid[0].count {
            let character = grid[x][y]

            if character.isNumber {
                currentNumber.append(character)
                currentNumberLocation.append((x, y))
            } else {
                if !currentNumber.isEmpty && hasSymbolsAroundLocation(at: currentNumberLocation, in: grid) {
                    sum += Int(currentNumber) ?? 0
                }
                currentNumber = ""
                currentNumberLocation.removeAll()
            }
        }
    }

    return sum
}
