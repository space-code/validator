//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// `ValidationResult` represents the outcome of a validation operation.
/// It can either be `.valid` when all checks pass or `.invalid` with a list of errors.
public enum ValidationResult {
    /// Indicates that validation succeeded.
    case valid

    /// Indicates that validation failed.
    ///
    /// - Parameter errors: An array of `IValidationError` instances describing each failure.
    case invalid(errors: [IValidationError])
}
