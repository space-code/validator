//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - RegexValidationRuleTests

final class RegexValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: RegexValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = RegexValidationRule(pattern: .pattern, error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatRegexValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.pattern, .pattern)
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatRegexValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: .input)

        // then
        XCTAssertTrue(result)
    }

    func test_thatRegexValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: .invalidInput)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: - Constants

private extension String {
    static let input = "abbat"
    static let invalidInput = "abb"
    static let pattern = "[a-zA-Z]at"
    static let error = "error"
}
