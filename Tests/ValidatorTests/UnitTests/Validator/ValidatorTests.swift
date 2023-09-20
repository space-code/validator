//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - ValidatorTests

final class ValidatorTests: XCTestCase {
    // MARK: Properties

    private var validator: Validator!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        validator = Validator()
    }

    override func tearDown() {
        validator = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatValidatorValidatesInput_whenLengthIsLessThanTenCharacters() {
        // given
        let validationRule = LengthValidationRule(min: .min, max: .max, error: String.error).eraseToAnyValidationRule()

        // when
        let validationResult = validator.validate(input: String(String.text.prefix(.max)), rule: validationRule)

        // then
        XCTAssertEqual(validationResult, .valid)
    }

    func test_thatValidatorValidatesInput_whenLengthIsGreaterThanTenCharacters() {
        // given
        let validationRule = LengthValidationRule(min: .min, max: .max, error: String.error).eraseToAnyValidationRule()

        // when
        let validationResult = validator.validate(input: String(String.text.prefix(11)), rules: [validationRule])

        // then
        if case let .invalid(errors) = validationResult {
            XCTAssertEqual(errors.count, 1)
            XCTAssertEqual(errors.first?.message, .error)
        } else {
            XCTFail("The input string must be greater than 10 characters")
        }
    }

    func test_thatValidatorValidatesInput_whenLengthIsLessThanOneCharacter() {
        // given
        let validationRule = LengthValidationRule(min: .min, max: .max, error: String.error).eraseToAnyValidationRule()

        // when
        let validationResult = validator.validate(input: .empty, rules: [validationRule])

        // then
        if case let .invalid(errors) = validationResult {
            XCTAssertEqual(errors.count, 1)
            XCTAssertEqual(errors.first?.message, .error)
        } else {
            XCTFail("The input string must be empty")
        }
    }

    func test_thatValidatorValidatesInput_whenThereAreCoupleOfRules() {
        // given
        let rules: [AnyValidationRule<String>] = [
            RegexValidationRule(pattern: .pattern, error: String.error).eraseToAnyValidationRule(),
            LengthValidationRule(min: .min, max: .max, error: String.error).eraseToAnyValidationRule(),
        ]

        // when
        let validationResult = validator.validate(input: .text, rules: rules)

        // then
        if case let .invalid(errors) = validationResult {
            XCTAssertEqual(errors.count, 2)
            XCTAssertEqual(errors[0].message, .error)
            XCTAssertEqual(errors[1].message, .error)
        } else {
            XCTFail("The input string must be empty")
        }
    }

    @available(macOS 13.0, iOS 16, tvOS 16, watchOS 9, *)
    func test_thatValidatorValidatesInputWithAnyRules_whenThereAreCoupleOfRules() {
        // given
        let rules: [any IValidationRule<String>] = [
            RegexValidationRule(pattern: .pattern, error: String.error),
            LengthValidationRule(min: .min, max: .max, error: String.error),
        ]

        // when
        let validationResult = validator.validate(input: .text, rules: rules)

        // then
        if case let .invalid(errors) = validationResult {
            XCTAssertEqual(errors.count, 2)
            XCTAssertEqual(errors[0].message, .error)
            XCTAssertEqual(errors[1].message, .error)
        } else {
            XCTFail("The input string must be empty")
        }
    }
}

// MARK: - Constants

private extension String {
    static let error: String = "error description"
    static let text: String = "lorem ipsum lorem ipsum lorem ipsum"
    static let empty: String = ""
    static let pattern: String = ""
}

private extension Int {
    static let min: Int = 1
    static let max: Int = 10
}
