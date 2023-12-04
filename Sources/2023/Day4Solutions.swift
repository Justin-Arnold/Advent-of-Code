import Foundation

struct Day4_2023: DayChallenge {
    static func partOne(input: String) -> String {

        let scratchCards = input.components(separatedBy: "\n").filter { !$0.isEmpty }

        var totalPoints = 0

        for card in scratchCards {
            let parts = card.split(separator: "|")

            var winningNumbers = parts[0].split(separator: ":")
            winningNumbers = winningNumbers[1].split(separator: " ")

            let yourNumbers = parts[1].split(separator: " ")

            print(yourNumbers)
            var points = 0
            var isMatchFound = false

            for number in yourNumbers {
                if winningNumbers.contains(number) {
                    if !isMatchFound {
                        points = 1
                        isMatchFound = true
                    } else {
                        points *= 2
                    }
                }
            }

            totalPoints += points
        }

        return String(totalPoints)
    }
    static func partTwo(input: String) -> String {
        let cards = parseInput(input)
        return String(processCards(cards: cards))
    }
}

class ScratchCard {
    var winningNumbers: Set<Int>
    var playerNumbers: Set<Int>

    init(winningNumbers: Set<Int>, playerNumbers: Set<Int>) {
        self.winningNumbers = winningNumbers
        self.playerNumbers = playerNumbers
    }

    func countMatches() -> Int {
        return winningNumbers.intersection(playerNumbers).count
    }
}

func parseInput(_ input: String) -> [ScratchCard] {
    return input.components(separatedBy: "\n").map { line in
        let parts = line.split(separator: "|").map { String($0) }
        let winningNumbers = Set(parts[0].split(separator: " ").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) })
        let playerNumbers = Set(parts[1].split(separator: " ").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) })
        return ScratchCard(winningNumbers: winningNumbers, playerNumbers: playerNumbers)
    }
}

func processCards(cards: [ScratchCard]) -> Int {
    var totalCards = 0
    var cardCopies = Array(repeating: 1, count: cards.count) // Start with 1 copy of each card

    for (index, card) in cards.enumerated() {
        totalCards += cardCopies[index] // Count this card and its copies

        let matches = card.countMatches()
        // Increase the count of subsequent cards based on the number of matches
        for nextIndex in index+1..<index+1+matches {
            if nextIndex < cards.count {
                cardCopies[nextIndex] += cardCopies[index]
            }
        }
    }

    return totalCards
}
