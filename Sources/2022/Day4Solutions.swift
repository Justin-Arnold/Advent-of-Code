
import Foundation

struct Day4_2022: DayChallenge {
    static func partOne(input: String) -> String {
        let ranges = parseInput(input: input)
        let CountOfRangesThatContainOtherRange = ranges.filter { range in
            let range1 = range[0]
            let range2 = range[1]

            return range1.contains(range2.lowerBound) && range1.contains(range2.upperBound) || range2.contains(range1.lowerBound) && range2.contains(range1.upperBound)
        }.count
        return "\(CountOfRangesThatContainOtherRange)"
    }
    static func partTwo(input: String) -> String {

        let ranges = parseInput(input: input)
        let CountOfRangesThatOverlap = ranges.filter { range in
            let range1 = range[0]
            let range2 = range[1]

            return range1.contains(range2.lowerBound) || range1.contains(range2.upperBound) || range2.contains(range1.lowerBound) || range2.contains(range1.upperBound)
        }.count
        return "\(CountOfRangesThatOverlap)"
    }
}

func parseInput(input: String) ->  [[ClosedRange<Int>]] {
    let lines = input.components(separatedBy: .newlines).filter({ !$0.isEmpty })

    var ranges = [[ClosedRange<Int>]]()
    for line in lines {
        let pair = line.components(separatedBy: ",")
        let firstRange = pair[0].components(separatedBy: "-")
        let secondRange = pair[1].components(separatedBy: "-")

        let a1 = Int(firstRange[0])!
        let a2 = Int(firstRange[1])!
        let b1 = Int(secondRange[0])!
        let b2 = Int(secondRange[1])!

        let range1 = a1...a2
        let range2 = b1...b2

        let groupRanges = [range1, range2]

        ranges.append(groupRanges)
    }

    return ranges
}

