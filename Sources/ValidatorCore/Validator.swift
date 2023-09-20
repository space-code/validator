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
    public func validate<T>(input: T.Input, rule: T) -> ValidationResult where T: IValidationRule {
        validate(input: input, rules: [rule.eraseToAnyValidationRule()])
    }

    public func validate<T>(input: T, rules: [AnyValidationRule<T>]) -> ValidationResult {
        let errors = rules
            .filter { !$0.validate(input: input) }
            .map(\.error)

        return errors.isEmpty ? .valid : ValidationResult.invalid(errors: errors)
    }

    @available(macOS 13.0, iOS 16, tvOS 16, watchOS 9, *)
    public func validate<T>(input: T, rules: [any IValidationRule<T>]) -> ValidationResult {
        let errors = rules
            .filter { !self.validate(input: input, rule: $0) }
            .map(\.error)

        return errors.isEmpty ? .valid : ValidationResult.invalid(errors: errors)
    }

    @available(macOS 13.0, iOS 16, tvOS 16, watchOS 9, *)
    func validate<T>(input: T, rule: some IValidationRule<T>) -> Bool {
        rule.validate(input: input)
    }
}
