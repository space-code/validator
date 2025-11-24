//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string ends with a specific suffix.
///
/// # Example:
/// ```swift
/// let rule = SuffixValidationRule(suffix: ".com", error: "Must end with .com")
/// rule.validate(input: "example.com") // true
/// rule.validate(input: "example.org") // false
/// ```
public struct SuffixValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The required suffix.
    public let suffix: Input

    /// The validation error returned if input does not end with the suffix.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a suffix validation rule.
    ///
    /// - Parameters:
    ///   - suffix: The required string suffix.
    ///   - error: The validation error returned if input fails validation.
    public init(suffix: Input, error: IValidationError) {
        self.suffix = suffix
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.hasSuffix(suffix)
    }
}
