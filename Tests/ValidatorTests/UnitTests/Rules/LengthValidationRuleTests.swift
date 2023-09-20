//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - LengthValidationRuleTests

final class LengthValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: LengthValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = LengthValidationRule(min: .min, max: .max, error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatLengthValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.min, .min)
        XCTAssertEqual(sut.max, .max)
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatLengthValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: String(String.input.prefix(.max)))

        // then
        XCTAssertTrue(result)
    }

    func test_thatLengthValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: .input)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: - Constants

private extension Int {
    static let min = 1
    static let max = 10
}

private extension String {
    static let input = "lorem ipsum lorem ipsum lorem ipsum"
    static let error = "error"
}
