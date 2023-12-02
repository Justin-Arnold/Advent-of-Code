import XCTest
@testable import Puzzles

let d1p1Input = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
"""
let d1p1Output = 142

final class Day1Tests: XCTestCase {
    func testPartOne() {
        let results = Day1.partOne(input: d1p1Input)
        XCTAssertEqual(results, d1p1Output, "Expected \(d1p1Output), got \(results)")
    }

    func testPartTwo() {
        XCTFail("Test not implemented yet")
    }
}