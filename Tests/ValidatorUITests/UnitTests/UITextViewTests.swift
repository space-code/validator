//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import ValidatorCore
import ValidatorUI
import XCTest

#if canImport(UIKit)
    import UIKit
#endif

#if os(iOS)
    final class UITextViewTests: XCTestCase {
        // MARK: Tests

        @MainActor
        func test_thatTextViewValidationReturnsValid_whenInputValueIsValid() {
            // given
            let textView = UITextView()

            textView.validateOnInputChange(isEnabled: true)
            textView.add(rule: LengthValidationRule(max: .max, error: String.error))

            // when
            textView.text = String(String.text.prefix(.max))

            var result: ValidationResult?

            textView.validationHandler = { result = $0 }
            textView.validate(rules: textView.validationRules)

            // when
            if case .valid = result {}
            else { XCTFail("The result must be equal to the valid value") }
        }

        @MainActor
        func test_thatTextViewValidationReturnsInvalid_whenInputValueIsInvalid() {
            // given
            let textView = UITextView()

            textView.validateOnInputChange(isEnabled: true)
            textView.add(rule: LengthValidationRule(max: .max, error: String.error))

            // when
            textView.text = .text

            var result: ValidationResult?

            textView.validationHandler = { result = $0 }
            textView.validate(rules: textView.validationRules)

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
