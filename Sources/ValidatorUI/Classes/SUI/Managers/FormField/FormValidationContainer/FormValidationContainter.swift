//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

public struct FormValidationContainter<T>: IFormValidationContainer {
    // MARK: Properties

    public var value: FormValidatorValueSubject<T>
    public let publisher: ValidationPublisher
    public let validator: IValidator
    public let rules: [any IValidationRule<T>]

    // MARK: Initialization

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

    public func validate() -> ValidationResult {
        validator.validate(input: value.value, rules: rules)
    }
}
