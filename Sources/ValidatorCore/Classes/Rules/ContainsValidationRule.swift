//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// Validates that a string contains a specific substring.
///
/// # Example:
/// ```swift
/// let rule = ContainsValidationRule(substring: "@", error: "Must contain @")
/// rule.validate(input: "user@example.com") // true
/// ```
public struct ContainsValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The substring that the input must contain.
    public let substring: String

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    /// Creates a validation rule that checks whether the input contains a required substring.
    ///
    /// - Parameters:
    ///   - substring: The string the input must contain.
    ///   - error: The validation error associated with failed validation.
    public init(substring: String, error: IValidationError) {
        self.substring = substring
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.contains(substring)
    }
}
