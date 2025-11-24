//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - CharactersValidationRuleTests

final class CharactersValidationRuleTests: XCTestCase {
    // MARK: - Properties

    private var sut: CharactersValidationRule!

    // MARK: - Setup / Teardown

    override func setUp() {
        super.setUp()
        sut = CharactersValidationRule(characterSet: .letters, error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Valid Input Tests

    func testValidate_WithOnlyAllowedCharacters_ReturnsTrue() {
        // Given
        let input = "HelloWorld"

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Invalid Input Tests

    func testValidate_WithDisallowedCharacters_ReturnsFalse() {
        // Given
        let input = "Hello123"

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertFalse(result)
    }

    func testValidate_WithSpecialCharacters_ReturnsFalse() {
        // Given
        let input = "Hi!"

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertFalse(result)
    }

    // MARK: - Edge Cases

    func testValidate_EmptyString_ReturnsTrue() {
        // Given
        let input = ""

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertTrue(result)
    }

    func testValidate_UnicodeCharacters_WhenNotAllowed_ReturnsTrue() {
        // Given
        let input = "Привет"

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Error Property

    func testErrorProperty_ReturnsProvidedError() {
        XCTAssertEqual(sut.error as? String, String.error)
    }
}

// MARK: Constants

private extension String {
    static let error = "Invalid characters"
}
