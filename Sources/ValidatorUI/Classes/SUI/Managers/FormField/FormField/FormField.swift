//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

public typealias ValidationPublisher = AnyPublisher<ValidationResult, Never>

// MARK: - FormField

@propertyWrapper
public final class FormField<Value>: IFormField {
    // MARK: Properties

    @Published
    /// The value to validate.
    private var value: Value

    /// The validation.
    private let validator: IValidator

    /// The validation rules.
    private let rules: [any IValidationRule<Value>]

    public var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }

    // MARK: Initialization

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
