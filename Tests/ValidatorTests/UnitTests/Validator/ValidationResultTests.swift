//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - ValidationResultTests

final class ValidationResultTests: XCTestCase {
    func test_validationResultsEquality_whenValidResultsAreEqual() {
        // given
        let result1 = ValidationResult.valid
        let result2 = ValidationResult.valid

        // when
        let result = result1 == result2

        // then
        XCTAssertTrue(result)
    }

    func test_validationResultsEquality_whenResultsAreNotEqual() {
        // given
        let result1 = ValidationResult.valid
        let result2 = ValidationResult.invalid(errors: [])

        // when
        let result = result1 == result2

        // then
        XCTAssertFalse(result)
    }

    func test_validationResultsEquality_whenInvalidResultsAreEqual() {
        // given
        let result1 = ValidationResult.invalid(errors: [String.error])
        let result2 = ValidationResult.invalid(errors: [String.error])

        // when
        let result = result1 == result2

        // then
        XCTAssertTrue(result)
    }
}

// MARK: - Constants

private extension String {
    static let error = "error"
}
