//
// Validator
// Copyright © 2026 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - UUIDValidationRuleTests

final class UUIDValidationRuleTests: XCTestCase {
    // MARK: - Properties

    private var sut: UUIDValidationRule!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        sut = UUIDValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_validate_validUUID_shouldReturnTrue() {
        // given
        let uuid = "550e8400-e29b-41d4-a716-446655440000"

        // when
        let result = sut.validate(input: uuid)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_emptyString_shouldReturnFalse() {
        // given
        let uuid = ""

        // when
        let result = sut.validate(input: uuid)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_whitespaceString_shouldReturnFalse() {
        // given
        let uuid = "    "

        // when
        let result = sut.validate(input: uuid)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_invalidUUID_shouldReturnFalse() {
        // given
        let uuid = "not-a-uuid"

        // when
        let result = sut.validate(input: uuid)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: Constants

private extension String {
    static let error = "UUID is invalid"
}
