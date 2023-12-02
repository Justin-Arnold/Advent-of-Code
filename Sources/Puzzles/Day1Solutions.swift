import Foundation

let file1URL = URL(fileURLWithPath: "Inputs/Day1Input.txt")


struct Day1: DayChallenge {
    static func partOne() {

    }
    static func partTwo() {
        let replacements = ["one": "o1ne", "two": "t2wo", "three": "t3hree", "four": "f4our", "five": "f5ive", "six": "s6ix", "seven": "s7even", "eight": "e8ight", "nine": "n9ine"]
        do {
            let fileContents = try String(contentsOf: file1URL, encoding: .utf8)
            let lines = fileContents.split(separator: "\n")
            var totalSum = 0

            for line in lines {

                var modifiedLine = String(line)
                for replacement in replacements {
                    modifiedLine = modifiedLine.replacingOccurrences(of: replacement.key, with: replacement.value)
                }
                modifiedLine = modifiedLine.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

                if !modifiedLine.isEmpty {
                    let firstIndex = modifiedLine.startIndex
                    let lastIndex = modifiedLine.index(before: modifiedLine.endIndex)

                    let first = String(modifiedLine[firstIndex])
                    let last = String(modifiedLine[lastIndex])

                    if modifiedLine.count == 1 {
                        totalSum += Int(first + first) ?? 0
                    } else {
                        totalSum += Int(first + last) ?? 0
                    }
                }
            }
            print(totalSum)
        } catch {
            print("Error reading the file: \(error)")
        }
    }
}

