//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

// MARK: - Validator

/// A type-safe validator that checks input values against one or more validation rules.
///
/// Use `Validator` to perform validation on any value that conforms to a validation rule.
/// You can validate a single rule or multiple rules at once. Validation results are returned
/// as `ValidationResult`, which indicates either `.valid` or `.invalid` with associated errors.
///
/// Example:
/// ```swift
/// let validator = Validator()
/// let result = validator.validate(
///     input: "user@example.com",
///     rule: RegexValidationRule(
///         pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
///         error: "Invalid email"
///     )
/// )
///
/// switch result {
/// case .valid:
///     print("✅ Valid input")
/// case .invalid(let errors):
///     print("❌ Validation failed: \(errors.map(\.message))")
/// }
/// ```
public struct Validator: Sendable {
    // MARK: Initialization

    /// Initializes a new instance of `Validator`.
    public init() {}
}

// MARK: IValidator

extension Validator: IValidator {
    /// Validates a single input value with one validation rule.
    ///
    /// - Parameters:
    ///   - input: The input value to validate.
    ///   - rule: A single validation rule conforming to `IValidationRule`.
    ///
    /// - Returns: A `ValidationResult` indicating `.valid` or `.invalid` with associated errors.
    public func validate<T>(input: T, rule: some IValidationRule<T>) -> ValidationResult {
        validate(input: input, rules: [rule])
    }

    /// Validates a single input value with multiple validation rules.
    ///
    /// - Parameters:
    ///   - input: The input value to validate.
    ///   - rules: An array of validation rules conforming to `IValidationRule`.
    ///
    /// - Returns: A `ValidationResult` indicating `.valid` if all rules pass, or `.invalid` with all errors.
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
