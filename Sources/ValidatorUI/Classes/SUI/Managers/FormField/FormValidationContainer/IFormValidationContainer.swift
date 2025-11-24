//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

/// A typealias for a `CurrentValueSubject` used to track form field values.
///
/// This subject publishes the current value of a form field and emits new values
/// whenever the field is updated, enabling reactive validation in SwiftUI or other UI frameworks.
public typealias FormValidatorValueSubject<Value> = CurrentValueSubject<Value, Never>

// MARK: - IFormValidationContainer

/// A container that encapsulates validation logic for a single form field.
///
/// This protocol defines the core components required to perform field validation
/// and publish validation results to observers such as UI elements or a form manager.
public protocol IFormValidationContainer<Value> {
    associatedtype Value

    /// The subject that holds the current value of the form field and publishes changes.
    var value: FormValidatorValueSubject<Value> { get }

    /// A publisher that emits validation results whenever the field is updated.
    var publisher: ValidationPublisher { get }

    /// The validator used to evaluate the field's value against the provided rules.
    var validator: IValidator { get }

    /// The array of validation rules to apply to the field.
    var rules: [any IValidationRule<Value>] { get }

    /// Performs validation on the current value of the field.
    ///
    /// - Returns: The `ValidationResult` indicating whether the field is valid or contains errors.
    func validate() -> ValidationResult
}
