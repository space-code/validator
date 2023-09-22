//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import ValidatorCore
import ValidatorUI
import XCTest

#if canImport(UIKit)
    import UIKit
#endif

#if os(iOS)
    final class UITextFieldTests: XCTestCase {
        // MARK: Properties

        private var textField: UITextField!

        // MARK: XCTestCase

        override func setUp() {
            super.setUp()
            textField = UITextField()
        }

        override func tearDown() {
            textField = nil
            super.tearDown()
        }

        // MARK: Tests

        func test_thatTextFieldValidationReturnsValid_whenInputValueIsValid() {
            // given
            textField.validateOnInputChange(isEnabled: true)
            textField.add(rule: LengthValidationRule(max: .max, error: String.error))

            // when
            textField.text = String(String.text.prefix(.max))

            var result: ValidationResult?

            textField.validationHandler = { result = $0 }
            textField.validate(rules: textField.validationRules)

            // when
            if case .valid = result {}
            else { XCTFail("The result must be equal to the valid value") }
        }

        func test_thatTextFieldValidationReturnsInvalid_whenInputValueIsInvalid() {
            // given
            textField.validateOnInputChange(isEnabled: true)
            textField.add(rule: LengthValidationRule(max: .max, error: String.error))

            // when
            textField.text = .text

            var result: ValidationResult?

            textField.validationHandler = { result = $0 }
            textField.validate(rules: textField.validationRules)

            // when
            if case let .invalid(errors) = result {
                XCTAssertEqual(errors.count, 1)
                XCTAssertEqual(errors.first?.message, .error)
            } else { XCTFail("The result must be equal to the invalid value") }
        }
    }
#endif

private extension String {
    static let text: String = "lorem ipsum lorem ipsum lorem ipsum"
    static let error: String = "error"
}

private extension Int {
    static let min = 0
    static let max = 10
}
