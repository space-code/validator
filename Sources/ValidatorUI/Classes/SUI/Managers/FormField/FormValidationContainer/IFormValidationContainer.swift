//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

public typealias FormValidatorValueSubject<Value> = CurrentValueSubject<Value, Never>

// MARK: - IFormValidationContainer

/// A container for form validation logic.
public protocol IFormValidationContainer<Value> {
    associatedtype Value

    /// The value subject used for form validation.
    var value: FormValidatorValueSubject<Value> { get }

    /// The publisher responsible for emitting validation events.
    var publisher: ValidationPublisher { get }

    /// The validator associated with this validation container.
    var validator: IValidator { get }

    /// An array of validation rules to apply to the form field.
    var rules: [any IValidationRule<Value>] { get }

    /// Performs form field validation.
    ///
    /// - Returns: The result of the validation process.
    func validate() -> ValidationResult
}
