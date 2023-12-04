import Foundation

// Protocols for each day's challenge
protocol DayChallenge {
    static func partOne(input: String) -> String
    static func partTwo(input: String) -> String
}

// Dictionary mapping day identifiers to their respective challenge structures
let challenges: [String: DayChallenge.Type] = [
    "d1": Day1_2020.self,
    // "d2": Day2_2020.self,
    // "d3": Day3_2020.self,
    // "d4": Day4_2020.self,
    // "d5": Day5_2020.self,
    // "d6": Day6_2020.self,
    // "d7": Day7_2020.self,
    // "d8": Day8_2020.self,
    // "d9": Day9_2020.self,
    // "d10": Day10_2020.self,
    // "d11": Day11_2020.self,
    // "d12": Day12_2020.self,
    // "d13": Day13_2020.self,
    // "d14": Day14_2020.self,
    // "d15": Day15_2020.self,
    // "d16": Day16_2020.self,
    // "d17": Day17_2020.self,
    // "d18": Day18_2020.self,
    // "d19": Day19_2020.self,
    // "d20": Day20_2020.self,
    // "d21": Day21_2020.self,
    // "d22": Day22_2020.self,
    // "d23": Day23_2020.self,
    // "d24": Day24_2020.self,
    // "d25": Day25_2020.self
]

// Function to execute the challenge based on day and part
func executeChallenge(day: String, part: String, isSolved: String?) {
    guard let challenge = challenges[day] else {
        print("Day not found")
        return
    }
    let dayNumber = String(day.dropFirst())
    let fileURL = URL(fileURLWithPath: "Inputs/2020/Day\(dayNumber)Input.txt")

    let inputText = try? String(contentsOf: fileURL, encoding: .utf8)

    guard let input = inputText else {
        print("Input not found")
        return
    }


    switch part {
    case "p1":
        let result = challenge.partOne(input: input)
        print("=========================")
        print("Answer: \(result)")
        if (isSolved != nil) {
            let task = Process()
            task.launchPath = "/bin/bash"
            task.arguments = ["Scripts/submit.sh", "2020", dayNumber, "1", result]
            task.launch()
            task.waitUntilExit()
        }
        print("=========================")
    case "p2":
        let result = challenge.partTwo(input: input)
        print("=========================")
        print("Answer: \(result)")
        if (isSolved != nil) {
            let task = Process()
            task.launchPath = "/bin/bash"
            task.arguments = ["Scripts/submit.sh", "2020", dayNumber, "2", result]
            task.launch()
            task.waitUntilExit()
        }
        print("=========================")
    default:
        print("Invalid part")
    }
}

// Main execution logic
let args = CommandLine.arguments

guard args.count == 3 || args.count == 4 else {
    print("Usage: swift run d<x> p<1|2>")
    exit(1)
}

let day = args[1].lowercased()  // Ensure lowercase to match dictionary keys
let part = args[2].lowercased()

if args.count == 4 {
    let solved = args[3].lowercased()
    guard solved == "submit" else {
        print("Usage: swift run d<x> p<1|2> submit")
        exit(1)
    }
    executeChallenge(day: day, part: part, isSolved: solved)
    exit(0)
} else {
    executeChallenge(day: day, part: part, isSolved: nil)
}
