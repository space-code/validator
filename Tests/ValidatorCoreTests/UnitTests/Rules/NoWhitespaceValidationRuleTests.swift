//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - NoWhitespaceValidationRuleTests

final class NoWhitespaceValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: NoWhitespaceValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = NoWhitespaceValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatNoWhitespaceValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatNoWhitespaceValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: "text")

        // then
        XCTAssertTrue(result)
    }

    func test_thatNoWhitespaceValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: .error)

        // then
        XCTAssertFalse(result)
    }

    func test_thatNoWhitespaceValidationRuleFails_whenInputContainsSpace() {
        // when
        let result = sut.validate(input: "hello world")

        // then
        XCTAssertFalse(result)
    }

    func test_thatNoWhitespaceValidationRuleFails_whenInputContainsTab() {
        // when
        let result = sut.validate(input: "hello\tworld")

        // then
        XCTAssertFalse(result)
    }

    func test_thatNoWhitespaceValidationRuleFails_whenInputContainsNewline() {
        // when
        let result = sut.validate(input: "hello\nworld")

        // then
        XCTAssertFalse(result)
    }

    func test_thatNoWhitespaceValidationRulePasses_whenInputIsEmptyString() {
        // when
        let result = sut.validate(input: "")

        // then
        XCTAssertTrue(result)
    }

    func test_thatNoWhitespaceValidationRulePasses_whenInputContainsSymbolsOnly() {
        // when
        let result = sut.validate(input: "!@#$%^&*()")

        // then
        XCTAssertTrue(result)
    }
}

// MARK: - Constants

private extension String {
    static let error = "Spaces are not allowed"
}
