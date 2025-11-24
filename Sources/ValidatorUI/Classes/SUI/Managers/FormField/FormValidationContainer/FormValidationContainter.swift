//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

/// A concrete implementation of `IFormValidationContainer` for a single form field.
///
/// Wraps a value subject, a validator, and a set of validation rules, and exposes a
/// publisher that emits validation results whenever the value changes.
public struct FormValidationContainter<T>: IFormValidationContainer {
    // MARK: Properties

    /// The value subject for the form field.
    public var value: FormValidatorValueSubject<T>

    /// The publisher that emits validation results.
    public let publisher: ValidationPublisher

    /// The validator used to check the field's value against its rules.
    public let validator: IValidator

    /// The validation rules applied to the field.
    public let rules: [any IValidationRule<T>]

    // MARK: Initialization

    /// Creates a new form validation container.
    ///
    /// - Parameters:
    ///   - value: The subject holding the field's value.
    ///   - publisher: The publisher that emits validation results.
    ///   - validator: The validator instance used to apply rules.
    ///   - rules: The validation rules to apply.
    public init(
        value: FormValidatorValueSubject<T>,
        publisher: ValidationPublisher,
        validator: IValidator,
        rules: [any IValidationRule<T>]
    ) {
        self.value = value
        self.publisher = publisher
        self.validator = validator
        self.rules = rules
    }

    // MARK: IFormValidationContainer

    /// Validates the current value using the associated rules and validator.
    ///
    /// - Returns: The `ValidationResult` of the validation.
    public func validate() -> ValidationResult {
        validator.validate(input: value.value, rules: rules)
    }
}
