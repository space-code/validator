//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - SuffixValidationRuleTests

final class SuffixValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: SuffixValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = SuffixValidationRule(suffix: .suffix, error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatSuffixValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.suffix, .suffix)
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatSuffixValidationRuleValidatesInput_whenInputIsCorrectValue() {
        // when
        let result = sut.validate(input: .input)

        // then
        XCTAssertTrue(result)
    }

    func test_thatSuffixValidationRuleValidatesInput_whenInputIsIncorrectValue() {
        // when
        let result = sut.validate(input: .error)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: - Constants

private extension String {
    static let suffix = "ipsum"
    static let input = "lorem ipsum lorem ipsum lorem ipsum"
    static let error = "error"
}
