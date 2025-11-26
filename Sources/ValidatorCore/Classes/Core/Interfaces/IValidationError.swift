//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// `IValidationError` is the protocol representing a validation error in `ValidatorCore`.
/// Any type conforming to `IValidationError` can be returned when validation fails.
///
/// Example usage:
/// ```swift
/// struct MyError: IValidationError {
///     var message: String { "Invalid input" }
/// }
/// ```
public protocol IValidationError: Error {
    /// A human-readable error message describing why validation failed.
    var message: String { get }
}
