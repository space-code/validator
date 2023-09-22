//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

// MARK: - Validator

public final class Validator {
    // MARK: Initialization

    public init() {}
}

// MARK: IValidator

extension Validator: IValidator {
    public func validate<T>(input: T, rule: some IValidationRule<T>) -> ValidationResult {
        validate(input: input, rules: [rule])
    }

    public func validate<T>(input: T, rules: [any IValidationRule<T>]) -> ValidationResult {
        let errors = rules
            .filter { !self.validate(input: input, rule: $0) }
            .map(\.error)

        return errors.isEmpty ? .valid : ValidationResult.invalid(errors: errors)
    }

    private func validate<T>(input: T, rule: some IValidationRule<T>) -> Bool {
        rule.validate(input: input)
    }
}
