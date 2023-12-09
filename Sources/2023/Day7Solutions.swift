import Foundation

struct Day7_2023: DayChallenge {
    static func partOne(input: String) -> String {
//         let input = """
// 32T3K 765
// T55J5 684
// KK677 28
// KTJJT 220
// QQQJA 483
// """
        let parsedString = parseDay7Input(input: input)
        let result = solveDay7Part1(input: parsedString)
        return String(result)
    }
    static func partTwo(input: String) -> String {
//         let input = """
// 32T3K 765
// T55J5 684
// KK677 28
// KTJJT 220
// QQQJA 483
// """
        let parsedString = parseDay7Input2(input: input)
        let results = run(withJokers: true, data: parsedString)
        return String(results)
    }
}


func parseDay7Input(input: String) -> [(hand: String, bid: Int)] {
    return input.components(separatedBy: "\n").compactMap { line in
        let components = line.split(separator: " ")
        guard components.count == 2, let bid = Int(components[1]) else { return nil }
        return (hand: String(components[0]), bid: bid)
    }
}

enum HandType: Comparable {
    case fiveOfAKind, fourOfAKind, fullHouse, threeOfAKind, twoPair, onePair, highCard
}

func classifyHand(_ hand: String) -> HandType {
    let counts = Dictionary(hand.map { ($0, 1) }, uniquingKeysWith: +)
    let uniqueCardCounts = Array(counts.values).sorted(by: >)

    switch uniqueCardCounts {
    case [5]:
        return .fiveOfAKind
    case let x where x.first == 4:
        return .fourOfAKind
    case [3, 2]:
        return .fullHouse
    case let x where x.first == 3 && x.count == 3:
        return .threeOfAKind
    case let x where x.first == 2 && x.count == 3:
        return .twoPair
    case let x where x.first == 2 && x.count == 4:
        return .onePair
    default:
        return .highCard
    }
}

func cardStrength(_ card: Character) -> Int {
    switch card {
    case "A": return 14
    case "K": return 13
    case "Q": return 12
    case "J": return 11
    case "T": return 10
    default: return Int(String(card)) ?? 0
    }
}

func compareHands(_ hand1: String, _ hand2: String) -> Bool {
    let type1 = classifyHand(hand1)
    let type2 = classifyHand(hand2)

    if type1 != type2 {
        return type1 > type2
    }

    print(hand1, hand2)

    let hand1Strengths = hand1.map { cardStrength($0) }
    let hand2Strengths = hand2.map { cardStrength($0) }

    print(hand1Strengths, hand2Strengths)

    for i in 0..<hand1Strengths.count {
        if hand1Strengths[i] != hand2Strengths[i] {
            return hand1Strengths[i] < hand2Strengths[i]
        }
    }

    return false // Hands are equal in strength
}

func solveDay7Part1(input: [(hand: String, bid: Int)]) -> Int {
    let rankedHands = input.map { ($0.hand, $0.bid, classifyHand($0.hand)) }
    let sortedHands = rankedHands.sorted { compareHands($0.0, $1.0) }
    var totalWinnings = 0
    for (index, handTuple) in sortedHands.enumerated() {
        let rank = index + 1 // Rank starts from 1 (weakest hand)
        totalWinnings += handTuple.1 * rank
    }
    return totalWinnings
}

func cleverSort(_ a: [Int], _ b: [Int]) -> Bool {
    for i in 0..<a.count {
        if a[i] != b[i] {
            return a[i] < b[i]
        }
    }
    return false
}

func run(withJokers: Bool = false, data: [String]) -> Int {
    let strength = withJokers ? "J23456789TQKA" : "23456789TJQKA"

    let hands = data.map { line -> (sort: [Int], bid: Int) in
        let parts = line.split(separator: " ")
        guard let bid = Int(parts[1]) else { return (sort: [], bid: 0) }

        let cards = parts[0].compactMap { strength.firstIndex(of: $0)?.utf16Offset(in: strength) }
        var frequencies = Dictionary<Int, Int>(cards.map { ($0, 1) }, uniquingKeysWith: +)

        var jokers = 0
        if withJokers {
            jokers = frequencies[0, default: 0]
            frequencies[0] = nil
        }

        var handHash = Array(frequencies.values).sorted(by: >)
        if withJokers && jokers > 0 {
            // Check if handHash has at least one element
            if handHash.isEmpty {
                handHash.append(jokers)
            } else {
                handHash[0] += jokers
            }
        }

        // Check if cards array is not empty before concatenating
        return (sort: handHash + (cards.isEmpty ? [] : cards), bid: bid)
    }

    let sortedHands = hands.sorted { cleverSort($0.sort, $1.sort) }
    return sortedHands.enumerated().map { $1.bid * ($0 + 1) }.reduce(0, +)
}

func parseDay7Input2(input: String) -> [String] {
    return input.components(separatedBy: "\n")
}