//
// Validator
// Copyright © 2026 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - Base64ValidationRuleTests

final class Base64ValidationRuleTests: XCTestCase {
    // MARK: - Properties

    private var sut: Base64ValidationRule!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        sut = Base64ValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_validate_validBase64_shouldReturnTrue() {
        // given
        let base64 = "SGVsbG8gV29ybGQ="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validBase64WithoutPadding_shouldReturnTrue() {
        // given
        let base64 = "SGVsbG8="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validBase64NoPadding_shouldReturnTrue() {
        // given
        let base64 = "YWJj"

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validBase64WithPlus_shouldReturnTrue() {
        // given
        let base64 = "YWJjZGVmZ2hpamts+A=="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validBase64WithSlash_shouldReturnTrue() {
        // given
        let base64 = "YWJjZGVmZ2hpamts/w=="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_invalidCharacters_shouldReturnFalse() {
        // given
        let base64 = "Hello@World!"

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_invalidLength_shouldReturnFalse() {
        // given
        let base64 = "SGVsbG"

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_tooManyPaddingCharacters_shouldReturnFalse() {
        // given
        let base64 = "SGVsbG8==="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_emptyString_shouldReturnFalse() {
        // given
        let base64 = ""

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_whitespaceString_shouldReturnFalse() {
        // given
        let base64 = "    "

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_plainText_shouldReturnFalse() {
        // given
        let base64 = "not base64"

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_base64WithWhitespace_shouldReturnTrue() {
        // given
        let base64 = "SGVs bG8g V29y bGQ="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_base64WithNewlines_shouldReturnTrue() {
        // given
        let base64 = "SGVs\nbG8g\nV29y\nbGQ="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_paddingInMiddle_shouldReturnFalse() {
        // given
        let base64 = "SGVs=bG8="

        // when
        let result = sut.validate(input: base64)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: Constants

private extension String {
    static let error = "Base64 string is invalid"
}
