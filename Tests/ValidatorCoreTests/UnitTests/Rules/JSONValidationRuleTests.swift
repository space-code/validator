//
// Validator
// Copyright © 2026 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - JSONValidationRuleTests

final class JSONValidationRuleTests: XCTestCase {
    // MARK: - Properties

    private var sut: JSONValidationRule!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        sut = JSONValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_validate_validJSONObject_shouldReturnTrue() {
        // given
        let json = "{\"key\": \"value\"}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validJSONArray_shouldReturnTrue() {
        // given
        let json = "[1, 2, 3]"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validNestedJSON_shouldReturnTrue() {
        // given
        let json = "{\"user\": {\"name\": \"John\", \"age\": 30}}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validJSONWithNumbers_shouldReturnTrue() {
        // given
        let json = "{\"count\": 42, \"price\": 19.99}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validJSONWithBooleans_shouldReturnTrue() {
        // given
        let json = "{\"active\": true, \"deleted\": false}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_validJSONWithNull_shouldReturnTrue() {
        // given
        let json = "{\"value\": null}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_invalidJSON_shouldReturnFalse() {
        // given
        let json = "{key: value}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_incompleteBraces_shouldReturnFalse() {
        // given
        let json = "{\"key\": \"value\""

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_trailingComma_shouldReturnFalse() {
        // given
        let json = "{\"key\": \"value\",}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_plainText_shouldReturnFalse() {
        // given
        let json = "not json"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_emptyString_shouldReturnFalse() {
        // given
        let json = ""

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_whitespaceString_shouldReturnFalse() {
        // given
        let json = "    "

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_singleQuotesJSON_shouldReturnFalse() {
        // given
        let json = "{'key': 'value'}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_missingQuotesOnKey_shouldReturnFalse() {
        // given
        let json = "{key: \"value\"}"

        // when
        let result = sut.validate(input: json)

        // then
        XCTAssertFalse(result)
    }
}

// MARK: Constants

private extension String {
    static let error = "JSON is invalid"
}
