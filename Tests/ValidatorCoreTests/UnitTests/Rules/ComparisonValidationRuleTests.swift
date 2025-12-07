//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - ComparisonValidationRuleTests

final class ComparisonValidationRuleTests: XCTestCase {
    func test_greaterThanRule_passesForValidValue() {
        let sut = ComparisonValidationRule(greaterThan: 10, error: String.error)
        XCTAssertTrue(sut.validate(input: 20))
    }

    func test_greaterThanRule_failsForInvalidValue() {
        let sut = ComparisonValidationRule(greaterThan: 10, error: String.error)
        XCTAssertFalse(sut.validate(input: 10))
    }

    func test_greaterThanOrEqualRule_allowsEqualValue() {
        let sut = ComparisonValidationRule(greaterThanOrEqual: 10, error: String.error)
        XCTAssertTrue(sut.validate(input: 10))
    }

    func test_lessThanRule_passesForSmallerValues() {
        let sut = ComparisonValidationRule(lessThan: 100, error: String.error)
        XCTAssertTrue(sut.validate(input: 50))
        XCTAssertFalse(sut.validate(input: 100))
    }

    func test_lessThanOrEqualRule_allowsEqualValue() {
        let sut = ComparisonValidationRule(lessThanOrEqual: 100, error: String.error)
        XCTAssertTrue(sut.validate(input: 100))
        XCTAssertFalse(sut.validate(input: 101))
    }

    func test_ruleWorksWithStringComparable() {
        let sut = ComparisonValidationRule(lessThan: "m", error: String.error)
        XCTAssertTrue(sut.validate(input: "apple"))
        XCTAssertFalse(sut.validate(input: "z"))
    }
}

// MARK: Constants

private extension String {
    static let error = "Invalid characters"
}
