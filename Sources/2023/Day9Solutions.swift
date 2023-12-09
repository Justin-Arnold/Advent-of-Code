import Foundation

struct Day9_2023: DayChallenge {
    static func partOne(input: String) -> String {
//         let input = """
// 0 3 6 9 12 15
// 1 3 6 10 15 21
// 10 13 16 21 30 45
// """
        let parsedInput = parseDay9Input(input: input)
        // print("parsedInput: \(parsedInput)")
        let results = solveDay9Part1(input: parsedInput)
        return results
    }
    static func partTwo(input: String) -> String {
//         let input = """
// 0 3 6 9 12 15
// 1 3 6 10 15 21
// 10 13 16 21 30 45
// """
        let parsedInput = parseDay9Input(input: input)
        let results = solveDay9Part2(input: parsedInput)
        return results
    }
}

func parseDay9Input(input: String) -> [[Int]] {
    return input.split(separator: "\n").map { line in
        line.split(separator: " ").compactMap { Int($0) }
    }
}

func solveDay9Part1(input: [[Int]]) -> String {
    let sumOfExtrapolatedValues = input.map { history -> Int in
        extrapolateNextValue(history: history)
    }.reduce(0, +)

    return String(sumOfExtrapolatedValues)
}

func solveDay9Part2(input: [[Int]]) -> String {
    let sumOfExtrapolatedValues = input.map { history -> Int in
        extrapolatePreviousValue(history: history)
    }.reduce(0, +)

    return String(sumOfExtrapolatedValues)
}

func extrapolateNextValue(history: [Int]) -> Int {
    var sequences = [history]
    while true {
        let lastSequence = sequences.last!
        if lastSequence.count < 2 { break } // Prevents "Index out of range" error
        let diffSequence = (0..<lastSequence.count-1).map { lastSequence[$0 + 1] - lastSequence[$0] }
        sequences.append(diffSequence)
        if diffSequence.allSatisfy({ $0 == 0 }) {
            break
        }
    }

    var extrapolatedValue = sequences.first!.last!
    for sequence in sequences.dropFirst() {
        extrapolatedValue += sequence.last ?? 0
    }

    return extrapolatedValue
}


func extrapolatePreviousValue(history: [Int]) -> Int {
    var sequences = [history]
    // Generate sequences of differences
    while true {
        let lastSequence = sequences.last!
        if lastSequence.count < 2 { break }
        let diffSequence = (0..<lastSequence.count-1).map { lastSequence[$0 + 1] - lastSequence[$0] }
        sequences.append(diffSequence)
        if diffSequence.allSatisfy({ $0 == 0 }) {
            break
        }
    }

    // Reverse the sequences for backward extrapolation
    sequences = sequences.reversed()
    // Add a zero at the beginning of the sequence of zeroes
    sequences[0].insert(0, at: 0)

    // Calculate the new first value for each previous sequence
    for i in 1..<sequences.count {
        let newFirstValue = sequences[i].first! - sequences[i-1][0]
        sequences[i].insert(newFirstValue, at: 0)
    }

    return sequences.last!.first!
}

// func extrapolatePreviousValue(history: [Int]) -> Int {
//     var sequences = [history]
//     while true {
//         let lastSequence = sequences.last!
//         if lastSequence.count < 2 { break } // Prevents "Index out of range" error
//         let diffSequence = (0..<lastSequence.count-1).map { lastSequence[$0 + 1] - lastSequence[$0] }
//         sequences.append(diffSequence)
//         if diffSequence.allSatisfy({ $0 == 0 }) {
//             break
//         }
//     }

//     var extrapolatedValue = sequences.first!.first!
//     for sequence in sequences.dropFirst() {
//         extrapolatedValue -= sequence.first ?? 0
//     }

//     return extrapolatedValue
// }





