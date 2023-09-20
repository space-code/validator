//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// `IValidationError` is the error type returned by Validator.
public protocol IValidationError: Error {
    /// The error message.
    var message: String { get }
}
