//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// MARK: - EqualityValidationRuleTests

final class EqualityValidationRuleTests: XCTestCase {
    // MARK: Properties

    private var sut: EqualityValidationRule<Int>!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = EqualityValidationRule(compareTo: 10, error: String.error)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatValidationRuleSetsProperties() {
        // then
        XCTAssertEqual(sut.value, 10)
        XCTAssertEqual(sut.error.message, .error)
    }

    func test_thatRuleValidatesCorrectValue() {
        // when
        let result = sut.validate(input: 10)

        // then
        XCTAssertTrue(result)
    }

    func test_thatRuleFailsForIncorrectValue() {
        // when
        let result = sut.validate(input: 5)

        // then
        XCTAssertFalse(result)
    }

    func test_thatRuleWorksWithStringInput() {
        // given
        let rule = EqualityValidationRule(compareTo: "abc", error: String.error)

        // when
        let resultPass = rule.validate(input: "abc")
        let resultFail = rule.validate(input: "abcd")

        // then
        XCTAssertTrue(resultPass)
        XCTAssertFalse(resultFail)
    }

    func test_thatRuleWorksWithCustomEquatableType() {
        // given
        struct User: Equatable {
            let id: Int
            let name: String
        }

        let matchUser = User(id: 1, name: "Nikita")
        let anotherUser = User(id: 2, name: "Alex")

        let rule = EqualityValidationRule(compareTo: matchUser, error: String.error)

        // when
        let resultPass = rule.validate(input: matchUser)
        let resultFail = rule.validate(input: anotherUser)

        // then
        XCTAssertTrue(resultPass)
        XCTAssertFalse(resultFail)
    }
}

// MARK: Constants

private extension String {
    static let error = "Values must be equal"
}
