//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - ContainsValidationRuleTests

final class ContainsValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: ContainsValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = ContainsValidationRule(substring: "@", error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatContainsValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.substring, "@")
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatRuleReturnsTrue_whenInputContainsSubstring() {
        // when
        let result = sut.validate(input: "user@example.com")

        // then
        XCTAssertTrue(result)
    }

    func test_thatRuleReturnsFalse_whenInputDoesNotContainSubstring() {
        // when
        let result = sut.validate(input: "userexample.com")

        // then
        XCTAssertFalse(result)
    }

    func test_thatRuleReturnsFalse_whenInputIsEmpty() {
        // when
        let result = sut.validate(input: "")

        // then
        XCTAssertFalse(result)
    }

    func test_thatRuleReturnsTrue_whenSubstringAppearsMultipleTimes() {
        // when
        let result = sut.validate(input: "@user@domain.com")

        // then
        XCTAssertTrue(result)
    }
}

// MARK: - Constants

private extension String {
    static let error = "Must contain @"
}
