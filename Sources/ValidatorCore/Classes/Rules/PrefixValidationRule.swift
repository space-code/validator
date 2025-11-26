//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string starts with a specific prefix.
///
/// # Example:
/// ```swift
/// let rule = PrefixValidationRule(prefix: "https://", error: "Must start with https://")
/// rule.validate(input: "https://example.com") // true
/// rule.validate(input: "http://example.com") // false
/// ```
public struct PrefixValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The prefix that the input must start with.
    public let prefix: Input

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a characters validation rule.
    ///
    /// - Parameters:
    ///   - prefix: The string that the input must start with.
    ///   - error: The validation error to return if input fails validation.
    public init(prefix: Input, error: IValidationError) {
        self.prefix = prefix
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.hasPrefix(prefix)
    }
}
