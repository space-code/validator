//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// A validation rule that checks input against a comparison constraint.
///
/// Supports comparisons such as:
/// - `>` (greater than)
/// - `>=` (greater than or equal to)
/// - `<` (less than)
/// - `<=` (less than or equal to)
///
/// # Examples:
/// ```swift
/// let rule1 = ComparisonValidationRule(greaterThan: 0, error: "Must be greater than 0")
/// rule1.validate(input: 5)   // true
/// rule1.validate(input: -1)  // false
///
/// let rule2 = ComparisonValidationRule(lessThanOrEqual: 100, error: "Must be <= 100")
/// rule2.validate(input: 100) // true
/// rule2.validate(input: 150) // false
/// ```
public struct ComparisonValidationRule<T: Comparable>: IValidationRule {
    // MARK: - Types

    public typealias Input = T

    /// Supported comparison operators.
    public enum Condition {
        case greaterThan(T)
        case greaterThanOrEqual(T)
        case lessThan(T)
        case lessThanOrEqual(T)
    }

    // MARK: - Properties

    /// The comparison condition to evaluate.
    public let condition: Condition

    /// The validation error returned when validation fails.
    public let error: IValidationError

    // MARK: - Initialization

    /// Creates a comparison-based validation rule.
    ///
    /// - Parameters:
    ///   - condition: The comparison condition.
    ///   - error: The validation error returned if validation fails.
    public init(condition: Condition, error: IValidationError) {
        self.condition = condition
        self.error = error
    }

    /// Convenience initializer for `greaterThan`.
    public init(greaterThan value: T, error: IValidationError) {
        self.init(condition: .greaterThan(value), error: error)
    }

    /// Convenience initializer for `greaterThanOrEqual`.
    public init(greaterThanOrEqual value: T, error: IValidationError) {
        self.init(condition: .greaterThanOrEqual(value), error: error)
    }

    /// Convenience initializer for `lessThan`.
    public init(lessThan value: T, error: IValidationError) {
        self.init(condition: .lessThan(value), error: error)
    }

    /// Convenience initializer for `lessThanOrEqual`.
    public init(lessThanOrEqual value: T, error: IValidationError) {
        self.init(condition: .lessThanOrEqual(value), error: error)
    }

    // MARK: - IValidationRule

    public func validate(input: T) -> Bool {
        switch condition {
        case let .greaterThan(value):
            input > value
        case let .greaterThanOrEqual(value):
            input >= value
        case let .lessThan(value):
            input < value
        case let .lessThanOrEqual(value):
            input <= value
        }
    }
}
