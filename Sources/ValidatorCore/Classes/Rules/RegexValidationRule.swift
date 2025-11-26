//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates a string against a regular expression pattern.
///
/// # Example:
/// ```swift
/// let rule = RegexValidationRule(pattern: "^[A-Z]+$", error: "Only uppercase letters allowed")
/// rule.validate(input: "HELLO") // true
/// rule.validate(input: "Hello") // false
/// ```
public struct RegexValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The regular expression pattern to validate the input against.
    public let pattern: String

    /// The validation error returned if input does not match the pattern.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a regex validation rule.
    ///
    /// - Parameters:
    ///   - pattern: The regex pattern used for validation.
    ///   - error: The validation error returned if input fails validation.
    public init(pattern: String, error: IValidationError) {
        self.pattern = pattern
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let range = NSRange(location: .zero, length: input.count)
        if let regex = try? NSRegularExpression(pattern: pattern) {
            return regex.firstMatch(in: input, range: range) != nil
        }
        return false
    }
}
