//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

/// A type that represents a field on a form.
///
/// Each field knows how to validate itself using a set of rules and a validator.
/// Validation is performed via a `IFormValidationContainer` which publishes results
/// that can be observed by the UI.
public protocol IFormField {
    /// Performs validation of the form field.
    ///
    /// - Note: To integrate with a form, create a form validation container that keeps
    ///         track of the validation state and publishes updates.
    ///
    /// - Parameter manager: The form field manager that tracks all fields in a form.
    /// - Returns: A validation container which exposes a publisher of validation results.
    func validate(manager: some IFormFieldManager) -> any IFormValidationContainer
}
