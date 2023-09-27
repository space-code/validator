//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - PrefixValidationRuleTests

final class PrefixValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: PrefixValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = PrefixValidationRule(prefix: .prefix, error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatPrefixValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.prefix, .prefix)
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatPrefixValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: .input)

        // then
        XCTAssertTrue(result)
    }

    func test_thatPrefixValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: .error)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: - Constants

private extension String {
    static let prefix = "lorem"
    static let input = "lorem ipsum lorem ipsum lorem ipsum"
    static let error = "error"
}
