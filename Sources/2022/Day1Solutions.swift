
import Foundation

struct Day1_2022: DayChallenge {
    static func partOne(input: String) -> String {
        let groupedLines = input.components(separatedBy: "\n\n")

        var maxTotal = 0

        for line in groupedLines {
            let splitLines = line.components(separatedBy: "\n")
            var total = 0
            for splitLine in splitLines {
                total += Int(splitLine) ?? 0
            }
            if total > maxTotal {
                maxTotal = total
            }
        }
        return String(maxTotal)
    }
    static func partTwo(input: String) -> String {

        let groupedLines = input.components(separatedBy: "\n\n")

        var totals: [Int] = []

        for line in groupedLines {
            let splitLines = line.components(separatedBy: "\n")
            print(splitLines)
            var total = 0
            for splitLine in splitLines {
                total += Int(splitLine) ?? 0
            }
            totals.append(total)
        }

        totals.sort(by: >)
        let maxTotal = totals[0]
        let secondMaxTotal = totals[1]
        let thirdMaxTotal = totals[2]

        return String(maxTotal + secondMaxTotal + thirdMaxTotal)
    }
}

