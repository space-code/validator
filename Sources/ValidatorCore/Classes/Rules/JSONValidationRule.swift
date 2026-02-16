//
// Validator
// Copyright © 2026 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string represents valid JSON.
///
/// # Example:
/// ```swift
/// let rule = JSONValidationRule(error: "Invalid JSON")
/// rule.validate(input: "{\"key\": \"value\"}") // true
/// rule.validate(input: "not json") // false
/// ```
public struct JSONValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error returned if the input is not valid JSON.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a JSON validation rule.
    ///
    /// - Parameter error: The validation error returned if input fails validation.
    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        guard !input.isEmpty else { return false }
        guard let data = input.data(using: .utf8) else { return false }

        do {
            _ = try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            return false
        }

        return isStrictJSON(input)
    }

    // MARK: Private Methods

    /// Validates strict JSON syntax to catch issues like trailing commas.
    private func isStrictJSON(_ input: String) -> Bool {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)

        let trailingCommaPatterns = [
            ",\\s*}",
            ",\\s*\\]",
        ]

        for pattern in trailingCommaPatterns where trimmed.range(of: pattern, options: .regularExpression) != nil {
            return false
        }

        if trimmed.range(of: ",,", options: .literal) != nil {
            return false
        }

        return true
    }
}
