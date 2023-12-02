import Foundation

let file2URL = URL(fileURLWithPath: "Inputs/Day2Input.txt")


struct Day2: DayChallenge {
    static func partOne(input: String) -> String {

        let startingCounts = [
            "red": 12,
            "green": 13,
            "blue": 14
        ]

        let input = try! String(contentsOf: file2URL, encoding: .utf8)

        let expectedTestOutput = 8

        var sumOfAllowedGames = 0

        for line in input.components(separatedBy: "\n") {
            let splitGame = line.components(separatedBy: ":")
            let gameName = splitGame[0]
            let gameId = Int(gameName.components(separatedBy: " ").filter { !$0.isEmpty }[1])!
            let gameTurns = splitGame[1].components(separatedBy: ";")
            var hadBadDraw = false

            for turn in gameTurns {
                let turnData = turn.components(separatedBy: ",")


                for draws in turnData {
                    let trimmedDraws = draws.trimmingCharacters(in: .whitespacesAndNewlines)
                    let colorCount = trimmedDraws.components(separatedBy: " ").filter { !$0.isEmpty }
                    let count = Int(colorCount[0])!
                    let color = colorCount[1]
                    if count > startingCounts[color]! {
                        print("Game \(gameId) is not allowed")
                        hadBadDraw = true
                        break
                    }
                }
            }

            if !hadBadDraw {
                sumOfAllowedGames += gameId
            }
        }

        print("Sum of allowed games: \(sumOfAllowedGames) | Expected: \(expectedTestOutput)" )
        return String(sumOfAllowedGames)

    }
    static func partTwo(input: String) -> String {

        let input = try! String(contentsOf: file2URL, encoding: .utf8)

        var totalPower = 0

        for line in input.components(separatedBy: "\n") {
            let splitGame = line.components(separatedBy: ":")
            let gameName = splitGame[0]
            let gameId = Int(gameName.components(separatedBy: " ").filter { !$0.isEmpty }[1])!
            let gameTurns = splitGame[1].components(separatedBy: ";")

            var turnMinimums = [
                "red": 0,
                "green": 0,
                "blue": 0
            ]

            for turn in gameTurns {
                let turnData = turn.components(separatedBy: ",")
                for draws in turnData {
                    let trimmedDraws = draws.trimmingCharacters(in: .whitespacesAndNewlines)
                    let colorCount = trimmedDraws.components(separatedBy: " ").filter { !$0.isEmpty }
                    let count = Int(colorCount[0])!
                    let color = colorCount[1]
                    if count > turnMinimums[color]! {
                        turnMinimums[color] = count
                    }
                }
            }

            let turnTotalPower = turnMinimums["red"]! * turnMinimums["green"]! * turnMinimums["blue"]!

            print("Game \(gameId) has a total power of \(turnTotalPower)")
            totalPower += turnTotalPower
        }
        print("Total power: \(totalPower)" )
        return String(totalPower)
    }
}
