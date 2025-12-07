//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// Validates that a number is positive.
///
/// # Example:
/// ```swift
/// let rule = PositiveNumberValidationRule(error: "Value must be positive")
/// rule.validate(input: -1) // false
/// rule.validate(input: 10) // true
/// ```
public struct PositiveNumberValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = Double

    // MARK: Properties

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: Double) -> Bool {
        input > 0
    }
}
