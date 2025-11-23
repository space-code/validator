//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

final class EmailValidationRuleTests: XCTestCase {
    var sut: EmailValidationRule!

    override func setUp() {
        super.setUp()
        sut = EmailValidationRule(error: "Invalid email")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Valid Email Tests

    func testValidateWithValidEmail_ReturnsTrue() {
        // Given
        let email = "user@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithNumbers_ReturnsTrue() {
        // Given
        let email = "user123@example456.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithDots_ReturnsTrue() {
        // Given
        let email = "first.last@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithPlus_ReturnsTrue() {
        // Given
        let email = "user+tag@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithUnderscore_ReturnsTrue() {
        // Given
        let email = "user_name@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithHyphen_ReturnsTrue() {
        // Given
        let email = "user@my-domain.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithSubdomain_ReturnsTrue() {
        // Given
        let email = "user@mail.example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithLongTLD_ReturnsTrue() {
        // Given
        let email = "user@example.museum"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithValidEmailWithTwoCharacterTLD_ReturnsTrue() {
        // Given
        let email = "user@example.io"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Invalid Email Tests

    func testValidateWithInvalidEmailMissingAtSign_ReturnsFalse() {
        // Given
        let email = "invalid.email.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailMissingDomain_ReturnsFalse() {
        // Given
        let email = "user@"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailMissingLocalPart_ReturnsFalse() {
        // Given
        let email = "@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailMissingTLD_ReturnsFalse() {
        // Given
        let email = "user@example"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailMultipleAtSigns_ReturnsFalse() {
        // Given
        let email = "user@@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailSpaces_ReturnsFalse() {
        // Given
        let email = "user @example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailSpecialCharacters_ReturnsFalse() {
        // Given
        let email = "user#name@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailDotAtStart_ReturnsFalse() {
        // Given
        let email = ".user@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailDotAtEnd_ReturnsFalse() {
        // Given
        let email = "user.@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailConsecutiveDots_ReturnsFalse() {
        // Given
        let email = "user..name@example.com"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailTLDTooLong_ReturnsFalse() {
        // Given
        let email = "user@example.abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklm"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithInvalidEmailSingleCharacterTLD_ReturnsFalse() {
        // Given
        let email = "user@example.c"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    // MARK: - Edge Cases

    func testValidateWithEmptyString_ReturnsFalse() {
        // Given
        let email = ""

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithOnlyAtSign_ReturnsFalse() {
        // Given
        let email = "@"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithOnlyDot_ReturnsFalse() {
        // Given
        let email = "."

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithWhitespaceOnly_ReturnsFalse() {
        // Given
        let email = "   "

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertFalse(result)
    }

    func testValidateWithValidEmailWithMaxTLDLength_ReturnsTrue() {
        // Given
        let email = "user@example.abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghij"

        // When
        let result = sut.validate(input: email)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Error Property Tests

    func testErrorPropertyIsSetCorrectly() {
        // Given
        let expectedError = "Invalid email"

        // When
        let actualError = sut.error as? String

        // Then
        XCTAssertEqual(actualError, expectedError)
    }
}
