
    import Foundation

    struct Day1_2015: DayChallenge {
        static func partOne(input: String) -> String {
            var floor = 0
            //for each character in input
            for (_, character) in input.enumerated() {
                //if character is (
                if character == "(" {
                    //floor += 1
                    floor += 1
                } else if character == ")" {
                    //floor -= 1
                    floor -= 1
                }

            }

            return String(floor)
        }
        static func partTwo(input: String) -> String {
            var floor = 0
            //for each character in input
            for (index, character) in input.enumerated() {
                //if character is (
                if character == "(" {
                    //floor += 1
                    floor += 1
                } else if character == ")" {
                    //floor -= 1
                    floor -= 1
                }

                if floor == -1 {
                    return String(index + 1)
                }
            }
            return String(floor)
        }
    }

