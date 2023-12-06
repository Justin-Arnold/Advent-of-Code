import Foundation

struct Day5_2023: DayChallenge {
    static func partOne(input: String) -> String {
        let seeds = parseSeeds(input)
        let seedToSoilMapping = parseMapping(input, type: "seed-to-soil map:")
        let soilToFertilizerMapping = parseMapping(input, type: "soil-to-fertilizer map:")
        let fertilizerToWaterMapping = parseMapping(input, type: "fertilizer-to-water map:")
        let waterToLightMapping = parseMapping(input, type: "water-to-light map:")
        let lightToTemperatureMapping = parseMapping(input, type: "light-to-temperature map:")
        let temperatureToHumidityMapping = parseMapping(input, type: "temperature-to-humidity map:")
        let humidityToLocationMapping = parseMapping(input, type: "humidity-to-location map:")

        var lowestLocation = Int.max

        for seed in seeds {
            var currentNumber = seed
            currentNumber = mapNumber(currentNumber, using: seedToSoilMapping)
            currentNumber = mapNumber(currentNumber, using: soilToFertilizerMapping)
            currentNumber = mapNumber(currentNumber, using: fertilizerToWaterMapping)
            currentNumber = mapNumber(currentNumber, using: waterToLightMapping)
            currentNumber = mapNumber(currentNumber, using: lightToTemperatureMapping)
            currentNumber = mapNumber(currentNumber, using: temperatureToHumidityMapping)
            currentNumber = mapNumber(currentNumber, using: humidityToLocationMapping)

            if currentNumber < lowestLocation {
                lowestLocation = currentNumber
            }
        }

        return String(lowestLocation)
    }
    static func partTwo(input: String) -> String {
        let seeds = parseSeeds(input)
        let sections = input.components(separatedBy: "\n\n")
        let mappings = sections.dropFirst().map { section in
            section.split(separator: "\n").dropFirst().map { line in
                line.split(separator: " ").compactMap { Int($0) }
            }
        }

        var ranges = [(Int, Int)]()

        for i in stride(from: 0, to: seeds.count, by: 2) {
            ranges.append((seeds[i], seeds[i] + seeds[i + 1] - 1))
        }

        for mapping in mappings {
            var newRanges = [(Int, Int)]()
            for seedRange in ranges {
                var unprocessed = [seedRange]
                for map in mapping {
                    let (offset, mapStart, mapEnd) = (map[0] - map[1], map[1], map[1] + map[2] - 1)
                    var newUnprocessed = [(Int, Int)]()
                    for (rangeStart, rangeEnd) in unprocessed {
                        let (toMap, extra) = findOverlap(spanStart: rangeStart, spanEnd: rangeEnd, mapStart: mapStart, mapEnd: mapEnd)
                        newUnprocessed += extra
                        newRanges += toMap.map { ($0.0 + offset, $0.1 + offset) }
                    }
                    unprocessed = newUnprocessed
                }
                newRanges += unprocessed
            }
            ranges = newRanges
        }

        let lowestLocation = ranges.min(by: { $0.0 < $1.0 })?.0 ?? Int.max

        return String(lowestLocation)
        }
}

func findOverlap(spanStart: Int, spanEnd: Int, mapStart: Int, mapEnd: Int) -> (toMap: [(Int, Int)], extra: [(Int, Int)]) {
    if spanStart < mapStart && mapEnd < spanEnd {
        return ([(mapStart, mapEnd)], [(spanStart, mapStart - 1), (mapEnd + 1, spanEnd)])
    } else if spanStart < mapStart && mapStart <= spanEnd {
        return ([(mapStart, spanEnd)], [(spanStart, mapStart - 1)])
    } else if spanStart <= mapEnd && mapEnd < spanEnd {
        return ([(spanStart, mapEnd)], [(mapEnd + 1, spanEnd)])
    } else if mapStart <= spanStart && spanEnd <= mapEnd {
        return ([(spanStart, spanEnd)], [])
    } else {
        return ([], [(spanStart, spanEnd)])
    }
}


func parseMapping(_ input: String, type: String) -> [Mapping] {
    let lines = input.components(separatedBy: .newlines)
    var mapping = [Mapping]()
    var mappingLines = [String]()

    for line in lines.enumerated() {
        if line.element.contains(type) {
            //append all following lines until the next blank line to mapping lines
            for i in line.offset+1...lines.count {
                if lines[i].isEmpty {
                    break
                }
                mappingLines.append(lines[i])
            }
        }
    }
    for line in mappingLines {
        let mappingParts = line.components(separatedBy: " ")
        let destinationStart = Int(mappingParts[0])!
        let sourceStart = Int(mappingParts[1])!
        let rangeLength = Int(mappingParts[2])!
        mapping.append(Mapping(destinationStart: destinationStart, sourceStart: sourceStart, rangeLength: rangeLength))
    }

    return mapping
}


func parseSeeds(_ input: String) -> [Int] {
    let lines = input.components(separatedBy: .newlines)
    let seedsString = lines[0].components(separatedBy: ":")[1]
    let seeds = seedsString.components(separatedBy: " ").compactMap { Int($0) }

    return seeds
}

struct Mapping {
    var destinationStart: Int
    var sourceStart: Int
    var rangeLength: Int
}

func mapNumber(_ number: Int, using mapping: [Mapping]) -> Int {
    for map in mapping {
        if number >= map.sourceStart && number < map.sourceStart + map.rangeLength {
            return map.destinationStart + (number - map.sourceStart)
        }
    }
    return number
}
