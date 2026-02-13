//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

final class DependentValidationRuleTests: XCTestCase {
    // MARK: - Mock Validation Rules

    struct AlwaysPassRule<T>: IValidationRule {
        let error: IValidationError = "Should not fail"
        func validate(input _: T) -> Bool { true }
    }

    struct AlwaysFailRule<T>: IValidationRule {
        let error: IValidationError = "Failed"
        func validate(input _: T) -> Bool { false }
    }

    // MARK: - Tests

    func test_dependentValidationRuleUsesCorrectValidationBasedOnDependentValue() {
        // given
        let country = "US"

        let rule = DependentValidationRule<String, String>(
            dependsOn: country,
            error: "Invalid",
            ruleProvider: { value in
                if value == "US" {
                    AlwaysPassRule<String>()
                } else {
                    AlwaysFailRule<String>()
                }
            }
        )

        // when
        let isValid = rule.validate(input: "12345")

        // then
        XCTAssertTrue(isValid)
    }

    func test_dependentValidationRuleSwitchesBehaviorWhenDependentValueChanges() {
        // given
        var country = "US"

        let rule = DependentValidationRule(
            dependsOn: country,
            error: "Invalid",
            ruleProvider: { value in
                if value == "US" {
                    AlwaysPassRule<String>()
                } else {
                    AlwaysFailRule<String>()
                }
            }
        )

        // then
        XCTAssertTrue(rule.validate(input: "value"))

        country = "FR"

        XCTAssertFalse(rule.validate(input: "value"))
    }

    func test_validationFails_whenInnerRuleFails() {
        // given
        let rule = DependentValidationRule(
            dependsOn: "ANY",
            error: "Invalid",
            ruleProvider: { _ in AlwaysFailRule<String>() }
        )

        // when
        let result = rule.validate(input: "test")

        // then
        XCTAssertFalse(result)
    }

    func test_validationPasses_whenInnerRulePasses() {
        // given
        let rule = DependentValidationRule(
            dependsOn: "ANY",
            error: "Invalid",
            ruleProvider: { _ in AlwaysPassRule<String>() }
        )

        // when
        let result = rule.validate(input: "test")

        // then
        XCTAssertTrue(result)
    }

    func test_canWorkWithDifferentInputTypes() {
        // given
        let rule = DependentValidationRule(
            dependsOn: true,
            error: "Invalid",
            ruleProvider: { condition in
                if condition {
                    AlwaysPassRule<Int>()
                } else {
                    AlwaysFailRule<Int>()
                }
            }
        )

        // then
        XCTAssertTrue(rule.validate(input: 123))
    }
}
