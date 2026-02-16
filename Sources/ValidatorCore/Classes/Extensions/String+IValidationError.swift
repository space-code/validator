//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

#if hasFeature(RetroactiveAttribute)
    /// Retroactive conformance to `Error` for `String` if the feature is enabled.
    extension String: @retroactive Error {}
#endif

// MARK: - String + IValidationError

/// Makes `String` conform to `IValidationError`.
/// This allows simple string literals to be used as validation errors without creating a custom type.
///
/// Example:
/// ```swift
/// let error: IValidationError = "Invalid input"
/// print(error.message) // "Invalid input"
/// ```
extension String: IValidationError {
    /// Returns the string itself as the error message.
    public var message: String {
        self
    }
}
