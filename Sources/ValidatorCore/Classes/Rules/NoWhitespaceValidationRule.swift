//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// Validates that a string does not contain any whitespace characters.
///
/// # Example:
/// ```swift
/// let rule = NoWhitespaceValidationRule(error: "Spaces are not allowed")
/// rule.validate(input: "lorem lorem") // false
/// rule.validate(input: "Text") // true
/// ```
public struct NoWhitespaceValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a characters validation rule.
    ///
    /// - Parameters:
    ///   - error: The validation error to return if input fails validation.
    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }
}
