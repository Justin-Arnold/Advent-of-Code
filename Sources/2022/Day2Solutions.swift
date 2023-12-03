
    import Foundation

    struct Day2_2022: DayChallenge {
        static func partOne(input: String) -> String {
            let gameValues = [
                "A": 1, //rock
                "B": 2, //paper
                "C": 3, ///scissors
                "X": 1, //rock
                "Y": 2, //paper
                "Z": 3  //scissors
            ]
            var sum = 0
            let turns = input.components(separatedBy: "\n").filter { !$0.isEmpty }
            for turn in turns {
                let moves = turn.components(separatedBy: " ")
                guard moves.count == 2,
                    let enemyMoveValue = gameValues[moves[0]],
                    let myMoveValue = gameValues[moves[1]] else {
                    continue
                }

                if (myMoveValue == 1 && enemyMoveValue == 3) || // Rock beats Scissors
                (myMoveValue == 3 && enemyMoveValue == 2) || // Scissors beats Paper
                (myMoveValue == 2 && enemyMoveValue == 1) {  // Paper beats Rock
                    sum += 6 // Win
                } else if myMoveValue == enemyMoveValue {
                    sum += 3 // Draw
                }

                sum += myMoveValue
            }

            return String(sum)
        }
        static func partTwo(input: String) -> String {
            let enemyMoves = [
                "A": "rock",
                "B": "paper",
                "C": "scissors"
            ]

            let outcomes = [
                "X": "loss",
                "Y": "draw",
                "Z": "win"
            ]


            var sum = 0
            let turns = input.components(separatedBy: "\n").filter { !$0.isEmpty }

            for turn in turns {
                let moves = turn.components(separatedBy: " ")
                guard moves.count == 2,
                    let enemyMove = enemyMoves[moves[0]],
                    let outcome = outcomes[moves[1]] else {
                    continue
                }

                if outcome == "win" {
                    sum += 6 // Win
                } else if outcome == "draw" {
                    sum += 3 // Draw
                }

                if enemyMove == "rock" {
                    switch outcome {
                    case "win":
                        sum += 2
                    case "draw":
                        sum += 1
                    default:
                        sum += 3
                    }
                } else if enemyMove == "paper" {
                    switch outcome {
                    case "win":
                        sum += 3
                    case "draw":
                        sum += 2
                    default:
                        sum += 1
                    }
                } else if enemyMove == "scissors" {
                    switch outcome {
                    case "win":
                        sum += 1
                    case "draw":
                        sum += 3
                    default:
                        sum += 2
                    }
                }
            }


            return String(sum)
        }
    }

