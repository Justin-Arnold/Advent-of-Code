import Foundation

struct Day6_2023: DayChallenge {
    static func partOne(input: String) -> String {
//         let input = """
// Time:      7  15   30
// Distance:  9  40  200
// """
        let races = parseDay6Input(input)
        print(races)
        let result = calculateWaysToWin(races: races)
        return String(result)
    }
    static func partTwo(input: String) -> String {
//         let input = """
// Time:      7  15   30
// Distance:  9  40  200
// """
        let race = parseDay6InputPart2(input)
        // print(race)

        let result = calculateWaysToWinSingleRace(time: race.time, record: race.record)

        return String(result)
    }
}

func parseDay6Input(_ input: String) -> [(time: Int, record: Int)] {
    let lines = input.split(separator: "\n").map(String.init)
    guard lines.count == 2 else { return [] }

    let times = lines[0].components(separatedBy: " ").compactMap(Int.init)
    let distances = lines[1].components(separatedBy: " ").compactMap(Int.init)

    guard times.count == distances.count else { return [] }

    return zip(times, distances).map { ($0, $1) }
}

func parseDay6InputPart2(_ input: String) ->  (time: Int, record: Int) {
    let lines = input.split(separator: "\n").map(String.init)


    // Remove non-numeric characters and convert to integer
    let timeString = lines[0].filter { $0.isNumber }
    let recordString = lines[1].filter { $0.isNumber }

    let time = Int(timeString) ?? 0
    let record = Int(recordString) ?? 0

    return (time, record)
}

func calculateWaysToWin(races: [(time: Int, record: Int)]) -> Int {
    func maxDistance(holdTime: Int, totalRaceTime: Int) -> Int {
        let travelTime = totalRaceTime - holdTime
        return holdTime * travelTime
    }

    var totalWays = 1
    var totalIterations = 0
    for race in races {

        var waysToWin = 0
        for holdTime in 0..<race.time {
            totalIterations += 1
            if holdTime * (race.time - holdTime) > race.record {
                waysToWin += 1
            }
        }
        totalWays &*= waysToWin
    }
    print("p1", totalIterations)
    return totalWays
}

func calculateWaysToWinSingleRace(time: Int, record: Int) -> Int {

    var waysToWin = 0

    for holdTime in 0..<time {
        if holdTime &* (time - holdTime) > record {
            waysToWin += 1
        }
    }

    return waysToWin
}

func CalcUsingQuad(time: Int, record: Int) -> Int {
    // Quadratic formula: ax^2 + bx + c = 0
    let a = 1
    let b = -time
    let c = -record

    let discriminant = Double(b * b - 4 * a * c)
    guard discriminant >= 0 else { return 0 }

    let sqrtDiscriminant = sqrt(discriminant)
    let root1 = Double(-b) + sqrtDiscriminant
    let root2 = Double(-b) - sqrtDiscriminant

    // Find the range of hold times
    let lowerBound = max(0, min(root1, root2) / 2.0)
    let upperBound = min(Double(time), max(root1, root2) / 2.0)

    // Calculate the number of ways to win
    let waysToWin = max(0, Int(upperBound) - Int(lowerBound))

    return waysToWin
}
