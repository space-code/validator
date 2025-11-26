//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// `IValidationRule` is a generic protocol representing a validation rule.
/// Types conforming to this protocol define the logic for validating input values of type `Input`.
///
/// You can create custom validators by implementing this protocol.
///
/// Example:
/// ```swift
/// struct NonEmptyRule: IValidationRule<String> {
///     let error = "Field cannot be empty"
///     func validate(input: String) -> Bool {
///         !input.isEmpty
///     }
/// }
/// ```
public protocol IValidationRule<Input> {
    /// The type of input this validator works with.
    associatedtype Input

    /// The validation error that will be returned if validation fails.
    var error: IValidationError { get }

    /// Validates the provided input.
    ///
    /// - Parameter input: The value to validate.
    /// - Returns: `true` if the input passes validation, `false` otherwise.
    func validate(input: Input) -> Bool
}
