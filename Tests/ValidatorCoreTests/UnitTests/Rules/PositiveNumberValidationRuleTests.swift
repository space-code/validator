//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - PositiveNumberValidationRuleTests

final class PositiveNumberValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: PositiveNumberValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = PositiveNumberValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatPositiveNumberValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatPositiveNumberValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: 10)

        // then
        XCTAssertTrue(result)
    }

    func test_thatPositiveNumberValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: -1)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: - Constants

private extension String {
    static let error = "Value must be positive"
}
