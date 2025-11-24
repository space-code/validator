//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string length is within the specified range.
///
/// This rule checks whether the input string's length is greater than or equal to `min`
/// and less than or equal to `max`. If the string length falls outside this range, validation fails.
///
/// # Example:
/// ```swift
/// let rule = LengthValidationRule(min: 3, max: 10, error: "Length out of range")
/// rule.validate(input: "Hello") // true
/// rule.validate(input: "Hi") // false
/// ```
public struct LengthValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The minimum allowed length of the string. Defaults to `0`.
    public let min: Int

    /// The maximum allowed length of the string. Defaults to `Int.max`.
    public let max: Int

    /// The validation error returned if the input does not satisfy the length constraints.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a length validation rule.
    ///
    /// - Parameters:
    ///   - min: The minimum allowed string length. Defaults to 0.
    ///   - max: The maximum allowed string length. Defaults to `Int.max`.
    ///   - error: The validation error returned if input is invalid.
    public init(min: Int = .zero, max: Int = .max, error: IValidationError) {
        self.min = min
        self.max = max
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let length = input.count
        return length >= min && length <= max
    }
}
