//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// Validates that the input is equal to a given reference value.
///
/// This rule compares the provided `input` against a predefined value using `Equatable`.
/// Validation passes only if both values are equal.
///
/// # Example:
/// ```swift
/// let rule = EqualityValidationRule(compareTo: 42, error: SomeError())
/// rule.validate(input: 42) // true
/// rule.validate(input: 41) // false
/// ```
///
/// - Note: This rule works with any `Equatable` type.
public struct EqualityValidationRule<T: Equatable>: IValidationRule {
    // MARK: Types

    public typealias Input = T

    // MARK: Properties

    public let value: T

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    /// Creates a validation rule that checks whether the input equals a specific value.
    ///
    /// - Parameters:
    ///   - value: The value to compare the input against.
    ///   - error: The validation error to return if validation fails.
    public init(compareTo value: T, error: IValidationError) {
        self.value = value
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: T) -> Bool {
        value == input
    }
}
