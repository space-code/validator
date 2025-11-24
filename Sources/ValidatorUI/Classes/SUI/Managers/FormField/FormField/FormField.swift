//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

/// A convenience typealias for a Combine publisher that emits validation results.
public typealias ValidationPublisher = AnyPublisher<ValidationResult, Never>

// MARK: - FormField

/// A property wrapper representing a single field in a form.
///
/// Encapsulates a value, its validation rules, and the validator used for checking the value.
/// Provides automatic integration with a form via `IFormField` protocol.
@propertyWrapper
public final class FormField<Value>: IFormField {
    // MARK: Properties

    /// The value stored in the field. Wrapped with `@Published` to observe changes.
    @Published
    private var value: Value

    /// The validator used to apply rules to the value.
    private let validator: IValidator

    /// The rules applied to the value during validation.
    private let rules: [any IValidationRule<Value>]

    /// The wrapped property value.
    public var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }

    // MARK: Initialization

    /// Creates a new `FormField` with a value, validator, and rules.
    ///
    /// - Parameters:
    ///   - wrappedValue: The initial value of the field.
    ///   - validator: The validator instance to use (defaults to `Validator()`).
    ///   - rules: The array of validation rules to apply to the value.
    public init(
        wrappedValue: Value,
        validator: IValidator = Validator(),
        rules: [any IValidationRule<Value>]
    ) {
        value = wrappedValue
        self.validator = validator
        self.rules = rules
    }

    // MARK: IFormField

    /// Validates the field using its rules and connects it to a form manager.
    ///
    /// - Parameter manager: The form field manager that tracks this field.
    ///
    /// - Returns: A `IFormValidationContainer` which exposes a publisher of validation results.
    public func validate(manager: some IFormFieldManager) -> any IFormValidationContainer {
        let subject = CurrentValueSubject<Value, Never>(value)

        let publisher = $value
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { subject.send($0) })
            .map { self.validator.validate(input: $0, rules: self.rules) }
            .eraseToAnyPublisher()

        let container = FormValidationContainter(
            value: subject,
            publisher: publisher,
            validator: validator,
            rules: rules
        )

        manager.append(validator: container)

        return container
    }
}
