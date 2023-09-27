//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

/// A type that represents a field on a form.
public protocol IFormField {
    /// Performs field validation.
    ///
    /// - Note: Create a form validation container that keeps track of the validation.
    ///
    /// - Parameter manager: The form field manager.
    ///
    /// - Returns: A validation container.
    func validate(manager: some IFormFieldManager) -> any IFormValidationContainer
}
