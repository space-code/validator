//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

/// A type that manages the validation state of a form.
public protocol IFormFieldManager: ObservableObject {
    /// A Boolean value that indicates whether all fields on a form are valid or not.
    var isValid: Bool { get }

    /// Appends a new validator to the manager.
    ///
    /// - Parameter validator: The validation container that encompasses required validation logic.
    func append(validator: some IFormValidationContainer)
}
