//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - NilValidationRuleTests

final class NilValidationRuleTests: XCTestCase {
    // MARK: - Properties

    private var sut: NilValidationRule<String>!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        sut = NilValidationRule<String>(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Validation Tests

    func testValidateWithNilInput_ReturnsTrue() {
        // Given
        let input: String? = nil

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertTrue(result)
    }

    func testValidateWithNonNilInput_ReturnsFalse() {
        // Given
        let input: String? = "Hello"

        // When
        let result = sut.validate(input: input)

        // Then
        XCTAssertFalse(result)
    }

    func testErrorProperty_ReturnsProvidedError() {
        // Then
        XCTAssertEqual(sut.error as? String, String.error)
    }
}

private extension String {
    static let error = "Value must be nil"
}
