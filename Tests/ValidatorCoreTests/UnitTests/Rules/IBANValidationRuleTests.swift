//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - IBANValidationRuleTests

final class IBANValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: IBANValidationRule!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = IBANValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatIBANValidationRuleValidatesInput_whenInputIsCorrectValue() {
        let validIBANs = [
            "GB82 WEST 1234 5698 7654 32",
            "DE89370400440532013000",
            "FR1420041010050500013M02606",
        ]

        for iban in validIBANs {
            XCTAssertTrue(sut.validate(input: iban))
        }
    }

    func test_thatIBANValidationRuleValidatesInput_whenInputIsInCorrectValue() {
        let invalidIBANs = [
            "GB82WEST12345698765431",
            "INVALIDIBAN",
            "DE123",
        ]

        for iban in invalidIBANs {
            XCTAssertFalse(sut.validate(input: iban))
        }
    }

    func test_thatIBANValidationRuleValidatesInput_whenInputIsEmpty() {
        XCTAssertFalse(sut.validate(input: ""))
    }

    func test_thatIBANValidationRuleValidatesInput_whenInputHasInvalidCharacters() {
        XCTAssertFalse(sut.validate(input: "GB82WEST1234$5698765432"))
    }
}

// MARK: Constants

private extension String {
    static let error = "Invalid IBAN"
}
