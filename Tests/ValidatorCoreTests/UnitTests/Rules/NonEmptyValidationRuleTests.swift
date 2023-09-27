//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - NonEmptyValidationRuleTests

final class NonEmptyValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: NonEmptyValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = NonEmptyValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatNonEmptyValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatNonEmptyValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: .input)

        // then
        XCTAssertTrue(result)
    }

    func test_thatNonEmptyValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: .empty)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: - Constants

private extension String {
    static let empty = ""
    static let input = "lorem ipsum lorem ipsum lorem ipsum"
    static let error = "error"
}
