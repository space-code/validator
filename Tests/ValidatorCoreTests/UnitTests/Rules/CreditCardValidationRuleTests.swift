//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - CreditCardValidationRuleTests

final class CreditCardValidationRuleTests: XCTestCase {
    // MARK: - Visa

    func test_validate_visaCardValid_shouldReturnTrue() {
        // given
        let rule = CreditCardValidationRule(types: [.visa], error: String.error)
        let validVisa = "4111111111111111"

        // when
        let isValid = rule.validate(input: validVisa)

        // then
        XCTAssertTrue(isValid)
    }

    func test_validate_visaCardInvalid_shouldReturnFalse() {
        // given
        let rule = CreditCardValidationRule(types: [.visa], error: String.error)
        let invalidVisa = "411111111111112"

        // when
        let isValid = rule.validate(input: invalidVisa)

        // then
        XCTAssertFalse(isValid)
    }

    // MARK: - MasterCard

    func test_validate_masterCardValid_shouldReturnTrue() {
        // given
        let rule = CreditCardValidationRule(types: [.masterCard], error: String.error)
        let validMasterCard = "5500000000000004"

        // when
        let isValid = rule.validate(input: validMasterCard)

        // then
        XCTAssertTrue(isValid)
    }

    func test_validate_masterCardInvalid_shouldReturnFalse() {
        // given
        let rule = CreditCardValidationRule(types: [.masterCard], error: String.error)
        let invalidMasterCard = "550000000000"

        // when
        let isValid = rule.validate(input: invalidMasterCard)

        // then
        XCTAssertFalse(isValid)
    }

    // MARK: - American Express

    func test_validate_amexValid_shouldReturnTrue() {
        // given
        let rule = CreditCardValidationRule(types: [.amex], error: String.error)
        let validAmex = "340000000000009"

        // when
        let isValid = rule.validate(input: validAmex)

        // then
        XCTAssertTrue(isValid)
    }

    func test_validate_amexInvalid_shouldReturnFalse() {
        // given
        let rule = CreditCardValidationRule(types: [.amex], error: String.error)
        let invalidAmex = "3400000000000099"

        // when
        let isValid = rule.validate(input: invalidAmex)

        // then
        XCTAssertFalse(isValid)
    }

    // MARK: - JCB

    func test_validate_jcbValid_shouldReturnTrue() {
        // given
        let rule = CreditCardValidationRule(types: [.jcb], error: String.error)
        let validJCB = "3528000000000007"

        // when
        let isValid = rule.validate(input: validJCB)

        // then
        XCTAssertTrue(isValid)
    }

    // MARK: - UnionPay

    func test_validate_unionPayValid_shouldReturnTrue() {
        // given
        let rule = CreditCardValidationRule(types: [.unionPay], error: String.error)
        let validUnionPay = "6221260000000000"

        // when
        let isValid = rule.validate(input: validUnionPay)

        // then
        XCTAssertTrue(isValid)
    }

    // MARK: - Multiple Types

    func test_validate_multipleTypesValid_shouldReturnTrue() {
        // given
        let rule = CreditCardValidationRule(types: [.visa, .amex, .masterCard], error: String.error)
        let validVisa = "4111111111111111"

        // when
        let isValid = rule.validate(input: validVisa)

        // then
        XCTAssertTrue(isValid)
    }

    // MARK: - Unknown Card Type

    func test_validate_unknownCardType_shouldReturnFalse() {
        // given
        let rule = CreditCardValidationRule(types: [.visa], error: String.error)
        let randomCard = "9999999999999999"

        // when
        let isValid = rule.validate(input: randomCard)

        // then
        XCTAssertFalse(isValid)
    }

    // MARK: - Empty Input

    func test_validate_emptyString_shouldReturnFalse() {
        // given
        let rule = CreditCardValidationRule(types: [.visa], error: String.error)

        // when
        let isValid = rule.validate(input: "")

        // then
        XCTAssertFalse(isValid)
    }
}

// MARK: Constants

private extension String {
    static let error = "Invalid card number"
}
