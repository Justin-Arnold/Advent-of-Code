import Foundation

// Protocols for each day's challenge
protocol DayChallenge {
    static func partOne(input: String) -> String
    static func partTwo(input: String) -> String
}

// Dictionary mapping day identifiers to their respective challenge structures
let challenges: [String: DayChallenge.Type] = [
    "d1": Day1.self,
    "d2": Day2.self,
    "d3": Day3.self,
    "d4": Day4.self,
    "d5": Day5.self,
    "d6": Day6.self,
    "d7": Day7.self,
    "d8": Day8.self,
    "d9": Day9.self,
    "d10": Day10.self,
    "d11": Day11.self,
    "d12": Day12.self,
    "d13": Day13.self,
    "d14": Day14.self,
    "d15": Day15.self,
    "d16": Day16.self,
    "d17": Day17.self,
    "d18": Day18.self,
    "d19": Day19.self,
    "d20": Day20.self,
    "d21": Day21.self,
    "d22": Day22.self,
    "d23": Day23.self,
    "d24": Day24.self,
    "d25": Day25.self
]

// Function to execute the challenge based on day and part
func executeChallenge(day: String, part: String) {
    guard let challenge = challenges[day] else {
        print("Day not found")
        return
    }

    let dayNumber = String(day.dropFirst())
    let fileURL = URL(fileURLWithPath: "Inputs/Day\(dayNumber)Input.txt")

    print(fileURL)
    let inputText = try? String(contentsOf: fileURL, encoding: .utf8)

    guard let input = inputText else {
        print("Input not found")
        return
    }


    switch part {
    case "p1":
        let result = challenge.partOne(input: input)
        print(result)
    case "p2":
        let result = challenge.partTwo(input: input)
        print(result)
    default:
        print("Invalid part")
    }
}

// Main execution logic
let args = CommandLine.arguments

guard args.count == 3 else {
    print("Usage: swift run d<x> p<1|2>")
    exit(1)
}

let day = args[1].lowercased()  // Ensure lowercase to match dictionary keys
let part = args[2].lowercased()

// Execute the challenge
executeChallenge(day: day, part: part)