//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A type that verifies the input data.
public protocol IValidationRule<Input> {
    /// The validation type.
    associatedtype Input

    /// The validation error.
    var error: IValidationError { get }

    /// Validates an input value.
    ///
    /// - Parameter input: The input value.
    ///
    /// - Returns: A validation result.
    func validate(input: Input) -> Bool
}
