import Foundation

struct Day1_2023: DayChallenge {
    static func partOne(input: String) -> String {
        let lines = input.split(separator: "\n")
        var totalSum = 0

        for line in lines {
            let strippedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let characters = strippedLine.map { String($0) }
            let numbers = characters.filter { Int($0) != nil }

            if numbers.count == 1 {
                totalSum += Int(numbers[0] + numbers[0]) ?? 0
            } else {
                totalSum += Int(numbers[0] + numbers[numbers.count - 1]) ?? 0
            }
        }
        print(totalSum)
        return String(totalSum)
    }
    static func partTwo(input: String) -> String {
        let replacements = ["one": "o1ne", "two": "t2wo", "three": "t3hree", "four": "f4our", "five": "f5ive", "six": "s6ix", "seven": "s7even", "eight": "e8ight", "nine": "n9ine"]
        // let fileContents = try String(contentsOf: file1URL, encoding: .utf8)
        let lines = input.split(separator: "\n")
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
        return String(totalSum)
    }
}

