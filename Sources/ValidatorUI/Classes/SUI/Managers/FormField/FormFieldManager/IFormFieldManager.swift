//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation

// MARK: - IFormFieldManager

/// A type that manages the validation state of a form.
///
/// The form field manager keeps track of all fields and their validation containers,
/// provides a centralized way to query the overall form validity, and allows UI components
/// to reactively respond to validation changes.
///
/// Conforms to `ObservableObject` so SwiftUI views can observe changes in form validation state.
public protocol IFormFieldManager: ObservableObject {
    /// A Boolean value indicating whether all fields in the form are valid.
    ///
    /// Returns `true` only if every registered field is valid.
    var isValid: Bool { get }

    /// Appends a new validator to the manager.
    ///
    /// - Parameter validator: The validation container that encompasses
    ///                        the required validation logic for a specific field.
    ///
    /// After appending, the manager will track this validator and include it
    /// in the computation of `isValid` and any publishers that expose validation results.
    func append(validator: some IFormValidationContainer)
}
