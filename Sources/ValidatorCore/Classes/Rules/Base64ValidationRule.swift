//
// Validator
// Copyright © 2026 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string represents valid Base64-encoded data.
///
/// # Example:
/// ```swift
/// let rule = Base64ValidationRule(error: "Invalid Base64")
/// rule.validate(input: "SGVsbG8gV29ybGQ=") // true
/// rule.validate(input: "not_base64!") // false
/// ```
public struct Base64ValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error returned if the input is not valid Base64.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a Base64 validation rule.
    ///
    /// - Parameter error: The validation error returned if input fails validation.
    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        guard !input.isEmpty else { return false }

        let cleanedInput = input.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)

        guard !cleanedInput.isEmpty else { return false }

        guard cleanedInput.count.isMultiple(of: 4) else { return false }

        guard Data(base64Encoded: cleanedInput) != nil else { return false }

        let base64Pattern = "^[A-Za-z0-9+/]*={0,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", base64Pattern)
        return predicate.evaluate(with: cleanedInput)
    }
}
