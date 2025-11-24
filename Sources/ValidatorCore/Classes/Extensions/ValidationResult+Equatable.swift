//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Adds `Equatable` conformance to `ValidationResult`.
/// Validation results are considered equal if both are `.valid`
/// or if both are `.invalid` and all error messages match.
///
/// Example:
/// ```swift
/// let r1: ValidationResult = .invalid(errors: ["Error 1", "Error 2"])
/// let r2: ValidationResult = .invalid(errors: ["Error 1", "Error 2"])
/// print(r1 == r2) // true
/// ```
extension ValidationResult: Equatable {
    public static func == (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.valid, .valid):
            true
        case let (.invalid(errors: lhsErrors), .invalid(errors: rhsErrors)):
            lhsErrors.map(\.message).joined() == rhsErrors.map(\.message).joined()
        default:
            false
        }
    }
}
