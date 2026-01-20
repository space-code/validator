//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// A validation rule that depends on another field's value to determine which rule to apply.
///
/// # Example:
/// ```swift
/// let countryField = FormField(value: "US")
/// let phoneField = FormField(
///     value: "",
///     rules: [
///         DependentValidationRule(
///             dependsOn: countryField,
///             error: "Invalid phone number",
///             ruleProvider: { country in
///                 if country == "US" {
///                     return USPhoneRule()
///                 } else {
///                     return InternationalPhoneRule()
///                 }
///             }
///         )
///     ]
/// )
/// ```
public struct DependentValidationRule<DependentInput, Input>: IValidationRule {
    // MARK: Properties

    /// The error message or error object to return if validation fails.
    public let error: IValidationError

    /// A closure that returns the value of the field this rule depends on.
    private let dependentField: () -> DependentInput

    /// A closure that takes the dependent field's value and returns the appropriate validation rule.
    private let ruleProvider: (DependentInput) -> any IValidationRule<Input>

    // MARK: Initialization

    /// Creates a dependent validation rule.
    ///
    /// - Parameters:
    ///   - dependsOn: A closure that returns the value of the field this rule depends on.
    ///   - error: The error message or error object to return if validation fails.
    ///   - ruleProvider: A closure that takes the dependent field's value and returns the appropriate validation rule.
    public init(
        dependsOn: @escaping @autoclosure () -> DependentInput,
        error: IValidationError,
        ruleProvider: @escaping (DependentInput) -> any IValidationRule<Input>
    ) {
        dependentField = dependsOn
        self.error = error
        self.ruleProvider = ruleProvider
    }

    // MARK: IValidationRule

    public func validate(input: Input) -> Bool {
        let dependentValue = dependentField()
        let rule = ruleProvider(dependentValue)
        return rule.validate(input: input)
    }
}
