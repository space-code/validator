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

    /// The time the publisher should wait before publishing an element.
    private let debounce: TimeInterval

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
    ///   - debounce: The time the publisher should wait before publishing an element.
    public init(
        wrappedValue: Value,
        validator: IValidator = Validator(),
        rules: [any IValidationRule<Value>],
        debounce: TimeInterval = .zero
    ) {
        value = wrappedValue
        self.validator = validator
        self.rules = rules
        self.debounce = debounce
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
            .dropFirst()
            .debounce(for: RunLoop.SchedulerTimeType.Stride(debounce), scheduler: RunLoop.main)
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
