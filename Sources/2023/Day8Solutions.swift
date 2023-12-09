import Foundation

struct Day8_2023: DayChallenge {
    static func partOne(input: String) -> String {
//         let input = """
// RL

// AAA = (BBB, CCC)
// BBB = (DDD, EEE)
// CCC = (ZZZ, GGG)
// DDD = (DDD, DDD)
// EEE = (EEE, EEE)
// GGG = (GGG, GGG)
// ZZZ = (ZZZ, ZZZ)
// """
        let (network, instructions) = parseDay8Input(input: input)
        let result = solveDay8Part1(network: network, instructions: instructions)
        return String(result)
    }
    static func partTwo(input: String) -> String {
//         let input = """
// LR

// 11A = (11B, XXX)
// 11B = (XXX, 11Z)
// 11Z = (11B, XXX)
// 22A = (22B, XXX)
// 22B = (22C, 22C)
// 22C = (22Z, 22Z)
// 22Z = (22B, 22B)
// XXX = (XXX, XXX)
// """
        let (network, instructions, startingNodes) = parseDay8Input(input: input)
        let result = solveDay8Part2(network: network, instructions: instructions, startingNodes: startingNodes)
        return String(result)
    }
}

func parseDay8Input(input: String) -> ([String: (String, String)], String) {
    var network = [String: (String, String)]()
    var instructions = ""

    let lines = input.components(separatedBy: "\n")
    for (index, line) in lines.enumerated() {
        if index == 0 {
            instructions = line.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            let parts = line.components(separatedBy: " = ")
            if parts.count == 2 {
                let node = parts[0]
                let connections = parts[1].trimmingCharacters(in: .punctuationCharacters)
                    .components(separatedBy: ", ")
                if connections.count == 2 {
                    network[node] = (connections[0], connections[1])
                }
            }
        }
    }

    return (network, instructions)
}

func solveDay8Part1(network: [String: (String, String)], instructions: String) -> Int {
    var currentNode = "AAA"
    var steps = 0

    let instructionArray = Array(instructions)
    var instructionIndex = 0

    while currentNode != "ZZZ" {
        let instruction = instructionArray[instructionIndex]
        if let nextNodes = network[currentNode] {
            currentNode = instruction == "L" ? nextNodes.0 : nextNodes.1
        }
        steps += 1

        instructionIndex = (instructionIndex + 1) % instructionArray.count
    }

    return steps
}

func solveDay8Part2(network: [String: (String, String)], instructions: String, startingNodes: [String]) -> Int {
    var cycles = [Int]()
    for (node, _) in network {
        if node.hasSuffix("A") {
            var currentNode = node
            var stepCount = 0
            var instructionIndex = 0

            repeat {
                let index = instructions.index(instructions.startIndex, offsetBy: instructionIndex % instructions.count)
                let instruction = String(instructions[index])
                let nextNodes = network[currentNode]!
                currentNode = instruction == "L" ? nextNodes.0 : nextNodes.1
                stepCount += 1
                instructionIndex += 1
            } while !currentNode.hasSuffix("Z")

            cycles.append(stepCount)
        }
    }

    return lcm(of: cycles)
}

func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a
    var b = b
    while b != 0 {
        let temp = b
        b = a % b
        a = temp
    }
    return a
}

// Function to calculate the Least Common Multiple (LCM) for two numbers
func lcm(_ a: Int, _ b: Int) -> Int {
    return (a / gcd(a, b)) * b
}

// Function to calculate the LCM for an array of numbers
func lcm(of numbers: [Int]) -> Int {
    return numbers.reduce(1) { lcm($0, $1) }
}

func parseDay8Input(input: String) -> ([String: (String, String)], String, [String]) {
    var network = [String: (String, String)]()
    var instructions = ""
    var startingNodes = [String]()

    let lines = input.components(separatedBy: "\n")
    for (index, line) in lines.enumerated() {
        if index == 0 {
            instructions = line.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            let parts = line.components(separatedBy: " = ")
            if parts.count == 2 {
                let node = parts[0]
                let connections = parts[1].trimmingCharacters(in: .punctuationCharacters)
                    .components(separatedBy: ", ")
                if connections.count == 2 {
                    network[node] = (connections[0], connections[1])
                    if node.hasSuffix("A") {
                        startingNodes.append(node)
                    }
                }
            }
        }
    }

    return (network, instructions, startingNodes)
}


