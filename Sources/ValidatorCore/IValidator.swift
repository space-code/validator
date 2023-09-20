//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A type that can be used to validate the contents of an input value.
/// Each validator accepts a value as its first argument and a rule or an array of rules as its second argument.
public protocol IValidator {
    /// Validates an input value.
    ///
    /// - Parameters:
    ///   - input: The input value.
    ///   - rule: The validation rule.
    ///
    /// - Returns: A validation result.
    func validate<T: IValidationRule>(input: T.Input, rule: T) -> ValidationResult

    /// Validates an input value.
    ///
    /// - Parameters:
    ///   - input: The input value.
    ///   - rules: The validation rules array.
    ///
    /// - Returns: A validation result.
    func validate<T>(input: T, rules: [AnyValidationRule<T>]) -> ValidationResult

    /// Validates an input value.
    ///
    /// - Parameters:
    ///   - input: The input value.
    ///   - rule: The validation rule.
    ///
    /// - Returns: A validation result.
    @available(macOS 13.0, iOS 16, tvOS 16, watchOS 9, *)
    func validate<T>(input: T, rule: some IValidationRule<T>) -> ValidationResult

    /// Validates an input value.
    ///
    /// - Parameters:
    ///   - input: The input value.
    ///   - rules: The validation rules array.
    ///
    /// - Returns: A validation result.
    @available(macOS 13.0, iOS 16, tvOS 16, watchOS 9, *)
    func validate<T>(input: T, rules: [any IValidationRule<T>]) -> ValidationResult
}
