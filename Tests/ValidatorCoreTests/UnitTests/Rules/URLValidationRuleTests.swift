//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import ValidatorCore
import XCTest

// MARK: - URLValidationRuleTests

final class URLValidationRuleTests: XCTestCase {
    // MARK: - Properties

    private var sut: URLValidationRule!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        sut = URLValidationRule(error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_validate_validURL_shouldReturnTrue() {
        // given
        let url = "https://google.com"

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_missingScheme_shouldReturnFalse() {
        // given
        let url = "google.com"

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_missingHost_shouldReturnFalse() {
        // given
        let url = "https://"

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_emptyString_shouldReturnFalse() {
        // given
        let url = ""

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_whitespaceString_shouldReturnFalse() {
        // given
        let url = "    "

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertFalse(result)
    }

    func test_validate_ipAddressURL_shouldReturnTrue() {
        // given
        let url = "http://192.168.0.1"

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_urlWithPort_shouldReturnTrue() {
        // given
        let url = "https://localhost:8080"

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertTrue(result)
    }

    func test_validate_ftpScheme_shouldReturnTrue() {
        // given
        let url = "ftp://example.com"

        // when
        let result = sut.validate(input: url)

        // then
        XCTAssertTrue(result)
    }
}

// MARK: Constants

private extension String {
    static let error = "URL is invalid"
}
