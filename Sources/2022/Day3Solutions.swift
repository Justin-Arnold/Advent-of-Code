
    import Foundation

    struct Day3_2022: DayChallenge {
        static func partOne(input: String) -> String {
            var sum = 0
            let lines = input.components(separatedBy: "\n").filter { !$0.isEmpty }
            let alphabet = "abcdefghijklmnopqrstuvwxyz"
            let alphabetUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var alphabetValues = [Character: Int]()
            var alphabetValuesUpper = [Character: Int]()
            for (index, character) in alphabet.enumerated() {
                alphabetValues[character] = index + 1
            }
            for (index, character) in alphabetUpper.enumerated() {
                alphabetValuesUpper[character] = index + 27
            }
            for line in lines {
                let firstHalf = line.prefix(line.count / 2)
                let secondHalf = line.suffix(line.count / 2)
                var sharedCharacters = Set<Character>()
                for character in firstHalf {
                    if secondHalf.contains(character) {
                        sharedCharacters.insert(character)
                    }
                }
                for character in sharedCharacters {
                    if let value = alphabetValues[character] {
                        sum += value
                    } else if let value = alphabetValuesUpper[character] {
                        sum += value
                    }
                }
            }
            return String(sum)
        }
        static func partTwo(input: String) -> String {
            var sum = 0
            let lines = input.components(separatedBy: "\n").filter { !$0.isEmpty }

            let alphabet = "abcdefghijklmnopqrstuvwxyz"
            let alphabetUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var alphabetValues = [Character: Int]()
            var alphabetValuesUpper = [Character: Int]()
            for (index, character) in alphabet.enumerated() {
                alphabetValues[character] = index + 1
            }
            for (index, character) in alphabetUpper.enumerated() {
                alphabetValuesUpper[character] = index + 27
            }

            let groups = stride(from: 0, to: lines.count, by: 3).map {
                Array(lines[$0..<min($0 + 3, lines.count)])
            }

            for group in groups {
                let sharedCharacters = Set(group[0]).intersection(Set(group[1])).intersection(Set(group[2]))
                for character in sharedCharacters {
                    if let value = alphabetValues[character] {
                        sum += value
                    } else if let value = alphabetValuesUpper[character] {
                        sum += value
                    }
                }
            }


            return String(sum)
        }
    }

