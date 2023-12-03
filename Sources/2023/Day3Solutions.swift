import Foundation

struct Day3_2023: DayChallenge {
    static func partOne(input: String) -> String {
        let schematic = input.components(separatedBy: "\n").map { Array($0) }.filter { !$0.isEmpty }
        let sum = getSumOfPartNumbers(from: schematic)
        return String(sum)
    }
    static func partTwo(input: String) -> String {
        let schematic = input.components(separatedBy: "\n").map { Array($0) }.filter { !$0.isEmpty }
        let sum = getGearRatio(from: schematic)
        return String(sum)
    }
}


// P1 Helpers

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

// P2 Helpers

func checkForAsteriskFromCharacter(named character: Character) -> Bool {
    return character == "*"
}
func getNumbersAroundLocation(at location: (x: Int, y: Int), in grid: [[Character]]) -> [Int] {
    var numbers = Set<Int>()
    for deltaX in -1...1 {
        for deltaY in -1...1 {
            let adjacentLocation = ( x: location.x + deltaX, y:  location.y + deltaY)
            let adjacentCharacter = grid[adjacentLocation.x][adjacentLocation.y]

            if isValidPosition(at: adjacentLocation, in: grid), adjacentCharacter.isNumber {
                let number = findWholeNumber(startingAt: adjacentLocation, in: grid)
                numbers.insert(number)
            }
        }
    }
    return Array(numbers)
}
func isValidPosition(at position: (x: Int, y: Int), in grid: [[Character]]) -> Bool {
    return position.x >= 0 && position.y >= 0 && position.x < grid.count && position.y < grid[0].count
}
func findWholeNumber(startingAt position: (x: Int, y: Int), in grid: [[Character]]) -> Int {
    var numberString = ""
    var yPointerIndex = position.y
    while yPointerIndex >= 0 && grid[position.x][yPointerIndex].isNumber {
        yPointerIndex -= 1
    }
    yPointerIndex += 1
    while yPointerIndex < grid[position.x].count && grid[position.x][yPointerIndex].isNumber {
        numberString.append(grid[position.x][yPointerIndex])
        yPointerIndex += 1
    }
    return Int(numberString) ?? 0
}
func getGearRatio(from grid: [[Character]]) -> Int {
    var sum = 0
    for x in 0..<grid.count {
        for y in 0..<grid[0].count {
            if checkForAsteriskFromCharacter(named: grid[x][y]) {
                let adjacentNumbers = getNumbersAroundLocation(at: (x, y), in: grid)
                if adjacentNumbers.count > 1 {
                    sum += adjacentNumbers.reduce(1, *)
                }
            }
        }
    }
    return sum
}
